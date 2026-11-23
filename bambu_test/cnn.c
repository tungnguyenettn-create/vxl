/* 5-layer pow2-weight integer CNN (person detection, W4A6) - C for Bambu HLS.
 * Top function: cnn_top.  Params come from cnn_params.h (see gen_params.py).
 * Same arithmetic as golden_forward() in the Python model.
 *
 * Area-oriented choices:
 *  - weight codes (4 bit) are packed 8 per uint32_t
 *  - two ping-pong buffers sized to the real maximum (BUF_A_SIZE / BUF_B_SIZE)
 *  - no multiplications for addressing (running indices); the only multiply
 *    in the datapath is acc*M in the requant step
 */
#include <stdint.h>
#include "cnn_params.h"

/* one activation memory: A = first BUF_A_SIZE bytes, B = the rest */
static uint8_t act_mem[BUF_A_SIZE + BUF_B_SIZE];
#define bufA (act_mem)
#define bufB (act_mem + BUF_A_SIZE)

/* all weights / BN params live in three ROMs (W_ALL, M_ALL, B_ALL) */
#define FC_W (W_ALL + FC_WOFF)

#define CODE(arr, k) (((arr)[(k) >> 3] >> (((k) & 7) << 2)) & 0xF)

/* conv3x3 (same pad) + BN requant + ReLU/clamp + optional 2x2 maxpool, fused.
 * in : [cin][H][H]   out: [cout][H/step][H/step]   (uint8, values 0..AMAX)
 * wp : packed 4-bit codes [s e2 e1 e0], flat [co][ci][ky][kx]; e==0 -> weight 0,
 *      else product = +-(x << (W_FRAC - e)).
 * hw : H*H (passed in so that no multiplier is needed)
 */
static void conv_layer(const uint8_t *in, uint8_t *out, const uint32_t *wp,
                       const int16_t *M, const int32_t *Bq,
                       int cin, int cout, int H, int hw, int sh, int pool)
{
    const int step = pool ? 2 : 1;
    const int Ho = pool ? (H >> 1) : H;
    const int stepH = pool ? (H << 1) : H;
    const int cin9 = (cin << 3) + cin;
    int wbase = 0;
    int oidx = 0;

    for (int co = 0; co < cout; co++) {
        const int32_t m = M[co];
        const int32_t bq = Bq[co];
        int rowH = 0; /* r*step*H */
        for (int r = 0; r < Ho; r++) {
            for (int c = 0; c < Ho; c++) {
                int best = 0; /* requant output is >= 0, so 0 is a valid max seed */
                int rr = pool ? (r << 1) : r;
                int rrH = rowH;
                for (int dy = 0; dy < step; dy++) {
                    for (int dx = 0; dx < step; dx++) {
                        const int cc = (pool ? (c << 1) : c) + dx;
                        int32_t acc = 0;
                        int widx = wbase;
                        int cbase = 0; /* ci*H*H */
                        for (int ci = 0; ci < cin; ci++) {
                            int y = rr - 1;
                            int yH = rrH - H;
                            for (int ky = 0; ky < 3; ky++) {
                                int x = cc - 1;
                                for (int kx = 0; kx < 3; kx++) {
                                    if (y >= 0 && y < H && x >= 0 && x < H) { /* zero padding */
                                        const uint32_t code = CODE(wp, widx);
                                        const int e = (int)(code & 7);
                                        if (e != 0) {
                                            const int32_t v =
                                                (int32_t)in[cbase + yH + x] << (W_FRAC - e);
                                            acc += (code & 8) ? -v : v;
                                        }
                                    }
                                    widx++;
                                    x++;
                                }
                                y++;
                                yH += H;
                            }
                            cbase += hw;
                        }
                        /* (acc*M + Bq) >> SH : needs 64-bit (acc ~22b, M 16b) */
                        const int64_t t = ((int64_t)acc * m + bq) >> sh;
                        const int q = (t < 0) ? 0 : ((t > AMAX) ? AMAX : (int)t);
                        if (q > best)
                            best = q;
                    }
                    rr++;
                    rrH += H;
                }
                out[oidx++] = (uint8_t)best;
            }
            rowH += stepH;
        }
        wbase += cin9;
    }
}

/* returns pred (1 = person); D = acc_fc[1] - acc_fc[0] written to *D_out */
int cnn_top(const uint8_t *img, int32_t *D_out)
{
    for (int i = 0; i < IMG_H * IMG_W; i++)
        bufA[i] = img[i];

    conv_layer(bufA, bufB, W_ALL + L0_WOFF, M_ALL + L0_MOFF, B_ALL + L0_MOFF, L0_CIN, L0_COUT, L0_H, L0_HW, L0_SH, L0_POOL);
    conv_layer(bufB, bufA, W_ALL + L1_WOFF, M_ALL + L1_MOFF, B_ALL + L1_MOFF, L1_CIN, L1_COUT, L1_H, L1_HW, L1_SH, L1_POOL);
    conv_layer(bufA, bufB, W_ALL + L2_WOFF, M_ALL + L2_MOFF, B_ALL + L2_MOFF, L2_CIN, L2_COUT, L2_H, L2_HW, L2_SH, L2_POOL);
    conv_layer(bufB, bufA, W_ALL + L3_WOFF, M_ALL + L3_MOFF, B_ALL + L3_MOFF, L3_CIN, L3_COUT, L3_H, L3_HW, L3_SH, L3_POOL);
    conv_layer(bufA, bufB, W_ALL + L4_WOFF, M_ALL + L4_MOFF, B_ALL + L4_MOFF, L4_CIN, L4_COUT, L4_H, L4_HW, L4_SH, L4_POOL);

    /* global average pool (sum only, max 64*63 = 4032 -> 12 bit) + FC with pow2 codes */
    int32_t acc_fc[2] = {0, 0};
    int pix = 0;
    int k0 = 0;      /* c            (class 0 code index) */
    int k1 = GAP_C;  /* GAP_C + c    (class 1 code index) */
    for (int c = 0; c < GAP_C; c++) {
        uint16_t s = 0;
        for (int i = 0; i < GAP_H * GAP_H; i++)
            s += bufB[pix++];

        const uint32_t f0 = CODE(FC_W, k0);
        const int e0 = (int)(f0 & 7);
        if (e0 != 0) {
            const int32_t v = (int32_t)s << (W_FRAC - e0);
            acc_fc[0] += (f0 & 8) ? -v : v;
        }
        const uint32_t f1 = CODE(FC_W, k1);
        const int e1 = (int)(f1 & 7);
        if (e1 != 0) {
            const int32_t v = (int32_t)s << (W_FRAC - e1);
            acc_fc[1] += (f1 & 8) ? -v : v;
        }
        k0++;
        k1++;
    }
    const int32_t D = acc_fc[1] - acc_fc[0];
    *D_out = D;
    return D > THRESH;
}
