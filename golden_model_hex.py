import json
import os


def read_hex_unsigned(path):
    """Read a hex file (one value per line) as a list of unsigned integers."""
    with open(path, "r", encoding="utf-8") as f:
        lines = [line.strip() for line in f if line.strip()]
    return [int(x, 16) for x in lines]


def sign_extend(value, bits):
    """Convert an N-bit two's complement unsigned integer to a signed Python int."""
    if value >= (1 << (bits - 1)):
        value -= 1 << bits
    return value


def read_hex_signed(path, bits):
    """Read a hex file as N-bit two's complement signed integers."""
    values = read_hex_unsigned(path)
    return [sign_extend(v, bits) for v in values]


def make_grid(flat, H, W):
    """Reshape a flat list into an H x W 2D nested list."""
    assert len(flat) == H * W, f"Expected {H * W} values, got {len(flat)}"
    return [[flat[r * W + c] for c in range(W)] for r in range(H)]


def make_tensor3d(flat, C, H, W):
    """Reshape a flat list into a C x H x W 3D nested list."""
    assert len(flat) == C * H * W, f"Expected {C * H * W} values, got {len(flat)}"
    return [
        [[flat[c * H * W + r * W + col] for col in range(W)] for r in range(H)]
        for c in range(C)
    ]


def make_tensor4d(flat, C_out, C_in, KH, KW):
    """Reshape a flat list into a C_out x C_in x KH x KW 4D nested list."""
    total = C_out * C_in * KH * KW
    assert len(flat) == total, f"Expected {total} values, got {len(flat)}"
    stride_co = C_in * KH * KW
    stride_ci = KH * KW
    stride_kh = KW
    return [
        [
            [
                [
                    flat[co * stride_co + ci * stride_ci + kh * stride_kh + kw]
                    for kw in range(KW)
                ]
                for kh in range(KH)
            ]
            for ci in range(C_in)
        ]
        for co in range(C_out)
    ]


def decode_weight_code(code, w_frac=7):
    """Decode a 4-bit pow2 weight code [s e2 e1 e0] into its integer value."""
    s = (code >> 3) & 1
    e = code & 7
    if e == 0:
        return 0
    magnitude = 1 << (w_frac - e)
    return -magnitude if s else magnitude


def load_params(hex_dir):
    """Load hardware and model configuration from params.json."""
    with open(os.path.join(hex_dir, "params.json"), "r", encoding="utf-8") as f:
        return json.load(f)


def load_weights_and_bn(hex_dir, params):
    """Load conv weight codes, FC weight codes, and folded BN parameters."""
    kept_idx = params["kept_idx"]
    m_bits = params["m_bits"]
    bq_bits = params["bq_bits"]
    n_layers = len(params["SH"])

    W_code = []
    BN_M = []
    BN_Bq = []

    for i in range(n_layers):
        cout = len(kept_idx[i])
        cin = 1 if i == 0 else len(kept_idx[i - 1])

        codes_flat = read_hex_unsigned(os.path.join(hex_dir, f"w_L{i}.hex"))
        W_code.append(make_tensor4d(codes_flat, cout, cin, 3, 3))

        m_vals = read_hex_signed(os.path.join(hex_dir, f"bn_M_L{i}.hex"), m_bits)
        bq_vals = read_hex_signed(os.path.join(hex_dir, f"bn_B_L{i}.hex"), bq_bits)
        assert len(m_vals) == cout, f"Layer {i}: expected {cout} M values, got {len(m_vals)}"
        assert len(bq_vals) == cout, f"Layer {i}: expected {cout} Bq values, got {len(bq_vals)}"
        BN_M.append(m_vals)
        BN_Bq.append(bq_vals)

    n_classes = 2
    n_fc_in = len(kept_idx[-1])
    fc_codes_flat = read_hex_unsigned(os.path.join(hex_dir, "fc_w.hex"))
    FC_code = [
        [fc_codes_flat[cl * n_fc_in + ci] for ci in range(n_fc_in)]
        for cl in range(n_classes)
    ]

    return {
        "W_code": W_code,
        "FC_code": FC_code,
        "BN_M": BN_M,
        "BN_Bq": BN_Bq,
    }


def conv3x3_code(inp, w_code, cin, cout, H, W, w_frac=7):
    """3x3 same-padded convolution using 4-bit pow2 weight codes and bit-shifts."""
    H_pad = H + 2
    W_pad = W + 2
    inp_pad = [[[0] * W_pad for _ in range(H_pad)] for _ in range(cin)]

    for c in range(cin):
        for r in range(H):
            for col in range(W):
                inp_pad[c][r + 1][col + 1] = inp[c][r][col]

    out = [[[0] * W for _ in range(H)] for _ in range(cout)]
    for co in range(cout):
        for r in range(H):
            for col in range(W):
                acc = 0
                for ci in range(cin):
                    for ky in range(3):
                        for kx in range(3):
                            w = w_code[co][ci][ky][kx]
                            e = w & 7
                            if e == 0:
                                continue
                            pixel = inp_pad[ci][r + ky][col + kx]
                            val = pixel << (w_frac - e)
                            if (w >> 3) & 1:
                                acc -= val
                            else:
                                acc += val
                out[co][r][col] = acc
    return out


def requant(acc_map, m_list, bq_list, sh_val, cout, H, W, amax=63):
    """Apply folded BN scale/bias, arithmetic right shift, ReLU, and 6-bit clamp."""
    out = [[[0] * W for _ in range(H)] for _ in range(cout)]
    for co in range(cout):
        m = m_list[co]
        bq = bq_list[co]
        for r in range(H):
            for col in range(W):
                val = (acc_map[co][r][col] * m + bq) >> sh_val
                val = max(0, min(amax, val))
                out[co][r][col] = val
    return out


def maxpool2(inp, cout, H, W):
    """2x2 non-overlapping max pooling."""
    H_out = H // 2
    W_out = W // 2
    out = [[[0] * W_out for _ in range(H_out)] for _ in range(cout)]
    for c in range(cout):
        for r in range(H_out):
            for col in range(W_out):
                r0 = r * 2
                c0 = col * 2
                out[c][r][col] = max(
                    inp[c][r0][c0],
                    inp[c][r0][c0 + 1],
                    inp[c][r0 + 1][c0],
                    inp[c][r0 + 1][c0 + 1],
                )
    return out


def global_avg_pool_sum(inp, cout, H, W):
    """Global average pooling returning spatial sum per channel."""
    S = [0] * cout
    for c in range(cout):
        total = 0
        for r in range(H):
            for col in range(W):
                total += inp[c][r][col]
        S[c] = total
    return S


def fc_layer(S, fc_code, n_classes, n_in, w_frac=7):
    """Fully connected layer using 4-bit pow2 weight codes and bit-shifts."""
    acc_fc = [0] * n_classes
    for cl in range(n_classes):
        acc = 0
        for c in range(n_in):
            fc = fc_code[cl][c]
            e = fc & 7
            if e == 0:
                continue
            val = S[c] << (w_frac - e)
            if (fc >> 3) & 1:
                acc -= val
            else:
                acc += val
        acc_fc[cl] = acc
    return acc_fc


def golden_forward(img_in, params, weights, H=64, W=64, verbose=True):
    """Run full 5-layer pure-integer CNN inference on a single image."""
    w_frac = params["w_frac"]
    amax = (1 << params["abits"]) - 1
    SH = params["SH"]
    pools = params["pools"]
    kept_idx = params["kept_idx"]
    T = params["T"]
    n_layers = len(SH)

    W_code = weights["W_code"]
    FC_code = weights["FC_code"]
    BN_M = weights["BN_M"]
    BN_Bq = weights["BN_Bq"]

    act = [[img_in[r][:] for r in range(H)]]
    H_cur, W_cur = H, W

    layer_outputs = []
    layer_accs = []

    for i in range(n_layers):
        cout = len(kept_idx[i])
        cin = len(act)

        if verbose:
            print(f"  Layer {i}: [{cin}x{H_cur}x{W_cur}]", end="")

        acc = conv3x3_code(act, W_code[i], cin, cout, H_cur, W_cur, w_frac=w_frac)
        layer_accs.append(acc)

        act = requant(acc, BN_M[i], BN_Bq[i], SH[i], cout, H_cur, W_cur, amax=amax)

        if pools[i]:
            act = maxpool2(act, cout, H_cur, W_cur)
            H_cur //= 2
            W_cur //= 2

        layer_outputs.append(act)
        if verbose:
            pool_str = "pool" if pools[i] else "no pool"
            print(f" -> [{cout}x{H_cur}x{W_cur}]  ({pool_str})")

    cout_last = len(kept_idx[-1])
    S = global_avg_pool_sum(act, cout_last, H_cur, W_cur)
    n_pixels = H_cur * W_cur
    if verbose:
        print(f"  GAP: [{cout_last}x{H_cur}x{W_cur}] -> S[{cout_last}]  (n_pixels={n_pixels})")

    acc_fc = fc_layer(S, FC_code, n_classes=2, n_in=cout_last, w_frac=w_frac)
    if verbose:
        print(f"  FC : acc_fc = {acc_fc}")

    D = acc_fc[1] - acc_fc[0]
    pred = 1 if D > T else 0
    if verbose:
        print(f"  Decision: D={D}, T={T}, pred={pred}")

    return {
        "layer_accs": layer_accs,
        "layer_outputs": layer_outputs,
        "S": S,
        "n_pixels": n_pixels,
        "acc_fc": acc_fc,
        "D": D,
        "pred": pred,
    }


if __name__ == "__main__":
    here = os.path.dirname(os.path.abspath(__file__))
    hex_dir = os.path.join(here, "golden_out")

    params = load_params(hex_dir)
    weights = load_weights_and_bn(hex_dir, params)

    # Load IMAGE 0
    img_info = params["images"][1]
    img_idx = img_info["idx"]
    label = img_info["label"]

    H_in, W_in = 64, 64
    in_flat = read_hex_unsigned(os.path.join(hex_dir, f"img{img_idx}_in.hex"))
    img_in = make_grid(in_flat, H_in, W_in)

    print(f"Running golden model on IMAGE {img_idx} (true label={label})...")
    result = golden_forward(img_in, params, weights, H=H_in, W=W_in, verbose=True)

    pred_str = "person (pred=1)" if result["pred"] == 1 else "no_person (pred=0)"
    ref_D = img_info.get("D", "N/A")

    print("=" * 50)
    print(f"Result for IMAGE {img_idx} (true label={label}):")
    print(f"  S (GAP sums)    = {result['S']}")
    print(f"  acc_fc          = {result['acc_fc']}")
    print(f"  D = acc_fc[1] - acc_fc[0] = {result['D']}")
    print(f"  T (threshold)   = {params['T']}")
    print(f"  Prediction      = {pred_str}")
    if ref_D != "N/A":
        print(f"  Expected D      = {ref_D} (match={result['D'] == ref_D})")
    print("=" * 50)
