#!/usr/bin/env python3
"""Entry point for iter_p2w4a6_in4 (pow2 4-bit W, 6-bit A, 4-bit gray input, iterative quantize + prune).

Pipeline (each step reads the previous step's checkpoint from --out):
    train  : stage 0, float training                                   -> <out>/float.pt
    prune  : per layer quantize / freeze / retrain / prune, FC stage,
             BN re-estimation, threshold tuning on the calib split      -> <out>/model.pt
    eval   : metrics + confusion matrix + hardware estimate on val
             (or on --test-dir/{no_person,person})                      -> <out>/eval.json
    all    : train -> prune -> eval

Examples (run from commit_folder/):
    python main.py all   --epochs 100
    python main.py train --epochs 100
    python main.py prune --iter-epochs 3 --prune-tol 0.005
    python main.py eval
    python main.py eval  --ckpt ../runs/iter_p2w4a6_in4/model.pt       # old qnn_presence.py run
    python main.py eval  --test-dir ../human_detection_dataset_split
    python main.py all   --epochs 1 --iter-epochs 1 --max-train 3000    # quick smoke test
"""
import argparse
import json
import os
import time

import numpy as np
import torch

from qnn.config import DEFAULT_ARCH, NAME, parse_arch
from qnn.data import Data, load_folder
from qnn.engine import fit, load_ckpt, predict, recalibrate_bn, save_ckpt
from qnn.hw import estimate, format_estimate
from qnn.metrics import confusion, format_confusion, metrics, tune_threshold
from qnn.model import QNet
from qnn.prune import quantize_and_prune

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)


def setup(args):
    if args.threads:
        torch.set_num_threads(args.threads)
    torch.manual_seed(args.seed)
    np.random.seed(args.seed)
    os.makedirs(args.out, exist_ok=True)
    device = torch.device("cuda" if torch.cuda.is_available() and not args.cpu else "cpu")
    print(f"[{NAME}] device: {device}  out: {args.out}", flush=True)
    return device


def get_data(args, need_train=True):
    cache = args.cache or os.path.join(args.out, "_cache")
    d = Data(args.data, cache, args.seed, args.calib_frac, args.max_train, need_train)
    print(d.describe(), flush=True)
    return d


def fit_kw(args):
    return dict(batch=args.batch, aug=not args.no_aug, balance=not args.no_balance)


# ---------------------------------------------------------------- commands
def cmd_train(args, device, data=None):
    data = data or get_data(args)
    arch = parse_arch(args.arch)
    torch.manual_seed(args.seed)
    model = QNet(arch).to(device)
    model.set_quant(False)
    print(f"\n=== train (float): arch {args.arch}, {args.epochs} epochs", flush=True)
    t0 = time.time()
    fit(model, data, device, args.epochs, args.lr, "float", **fit_kw(args))
    path = os.path.join(args.out, "float.pt")
    save_ckpt(path, model, args.arch, "float", train_seconds=time.time() - t0)
    print(f"saved {path}")
    return data


def cmd_prune(args, device, data=None):
    data = data or get_data(args)
    src = args.ckpt or os.path.join(args.out, "float.pt")
    model, meta = load_ckpt(src, device, args.arch)
    if meta.get("stage") != "float":
        raise SystemExit(f"{src} is not a float checkpoint (stage={meta.get('stage')}); run `train` first")
    print(f"\n=== prune: from {src}, iter_epochs {args.iter_epochs}, prune_tol {args.prune_tol}", flush=True)
    t0 = time.time()
    kept = quantize_and_prune(model, data, device, args.lr, args.iter_epochs, args.prune_tol,
                              args.prune_eval_n, seed=args.seed, **fit_kw(args))
    m_raw = metrics(predict(model, data.Xva, device), data.yva)
    recalibrate_bn(model, data.Xtr, device)
    thr = tune_threshold(predict(model, data.Xcal, device), data.ycal)
    path = os.path.join(args.out, "model.pt")
    save_ckpt(path, model, meta["arch"], "quant", thr=thr, prune_seconds=time.time() - t0,
              auc_before_bn_recal=m_raw["auc"])
    print(f"kept channels {kept}  threshold (calib split) {thr:+.4f}")
    print(f"saved {path}")
    return data


def cmd_eval(args, device, data=None):
    src = args.ckpt or os.path.join(args.out, "model.pt")
    model, meta = load_ckpt(src, device, args.arch)
    thr = meta.get("thr")
    if thr is None:                                   # old run: threshold lives in result.json next to it
        rj = os.path.join(os.path.dirname(src), "result.json")
        if os.path.exists(rj):
            thr = json.load(open(rj))["metrics"].get("thr")
    thr = 0.0 if thr is None else float(thr)

    if args.test_dir:
        x, y = load_folder(args.test_dir)
        X, labels, split = torch.from_numpy(x).unsqueeze(1), y, args.test_dir
    else:
        data = data or get_data(args, need_train=False)
        X, labels, split = data.Xva, data.yva, "val"

    scores = predict(model, X, device)
    m = metrics(scores, labels)
    m["acc_tuned"] = metrics(scores, labels, thr)["acc"]
    m["thr"] = thr
    cm0, cmt = confusion(scores, labels, 0.0), confusion(scores, labels, thr)
    arch = parse_arch(meta["arch"])
    kept = model.kept()
    est = [estimate(arch, kept, P, args.fclk) for P in args.P]

    print(f"\n=== eval {src} on {split} ({len(labels)} images)")
    print(f"arch {meta['arch']}  kept channels {kept}")
    print(f"acc {m['acc']:.4f}  acc@thr {m['acc_tuned']:.4f}  auc {m['auc']:.4f}  "
          f"rec@5%FPR {m['rec_fpr5']:.3f}  rec@1%FPR {m['rec_fpr1']:.3f}")
    print(format_confusion(cm0, "\nconfusion @ thr 0.0"))
    print(format_confusion(cmt, f"\nconfusion @ tuned thr {thr:+.4f}"))
    print(f"\nhardware estimate (EP4CE6, fclk {args.fclk / 1e6:.0f} MHz, rough):")
    for e in est:
        print(format_estimate(e))

    os.makedirs(args.out, exist_ok=True)
    np.save(os.path.join(args.out, "eval_scores.npy"), scores)
    np.save(os.path.join(args.out, "eval_labels.npy"), labels)
    with open(os.path.join(args.out, "eval.json"), "w") as f:
        json.dump(dict(ckpt=src, split=split, arch=meta["arch"], kept=kept, metrics=m,
                       confusion_thr0=cm0, confusion_tuned=cmt, est=est), f, indent=1, default=float)
    print(f"\nsaved {os.path.join(args.out, 'eval.json')}")


def cmd_all(args, device):
    data = cmd_train(args, device)
    cmd_prune(args, device, data)
    args.ckpt = None
    cmd_eval(args, device, data)


# ---------------------------------------------------------------- CLI
def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)

    common = argparse.ArgumentParser(add_help=False)
    common.add_argument("--data", default=os.path.join(ROOT, "data"), help="folder with train/ and val/")
    common.add_argument("--out", default=os.path.join(HERE, "runs", NAME))
    common.add_argument("--cache", default=None, help="npz cache folder (default <out>/_cache)")
    common.add_argument("--arch", default=DEFAULT_ARCH,
                        help="conv channels, 'p' = 2x2 max-pool after that conv (used by train; "
                             "prune/eval read it from the checkpoint)")
    common.add_argument("--ckpt", default=None, help="input checkpoint (prune: float.pt, eval: model.pt)")
    common.add_argument("--seed", type=int, default=0)
    common.add_argument("--calib-frac", type=float, default=0.05,
                        help="fraction of train held out for pruning decisions + threshold")
    common.add_argument("--max-train", type=int, default=0, help="subsample training set (0 = all)")
    common.add_argument("--threads", type=int, default=0)
    common.add_argument("--cpu", action="store_true")

    hp = argparse.ArgumentParser(add_help=False)
    hp.add_argument("--batch", type=int, default=128)
    hp.add_argument("--lr", type=float, default=2e-3)
    hp.add_argument("--no-aug", action="store_true")
    hp.add_argument("--no-balance", action="store_true", help="disable class-weighted loss")

    tr = argparse.ArgumentParser(add_help=False)
    tr.add_argument("--epochs", type=int, default=100, help="float training epochs")

    pr = argparse.ArgumentParser(add_help=False)
    pr.add_argument("--iter-epochs", type=int, default=3, help="retrain epochs after quantizing each layer")
    pr.add_argument("--prune-tol", type=float, default=0.005, help="max calib-split AUC drop per layer")
    pr.add_argument("--prune-eval-n", type=int, default=4000, help="calib images used for pruning decisions")

    ev = argparse.ArgumentParser(add_help=False)
    ev.add_argument("--test-dir", default=None, help="evaluate on <dir>/{no_person,person} instead of val")
    ev.add_argument("--P", type=int, nargs="+", default=[1, 2, 4, 8], help="parallel PEs for the estimate")
    ev.add_argument("--fclk", type=float, default=50e6)

    sub.add_parser("train", parents=[common, hp, tr], help="float training -> float.pt")
    sub.add_parser("prune", parents=[common, hp, pr], help="iterative quantize + prune -> model.pt")
    sub.add_parser("eval", parents=[common, ev], help="evaluate model.pt")
    sub.add_parser("all", parents=[common, hp, tr, pr, ev], help="train -> prune -> eval")

    args = ap.parse_args()
    device = setup(args)
    dict(train=cmd_train, prune=cmd_prune, eval=cmd_eval, all=cmd_all)[args.cmd](args, device)


if __name__ == "__main__":
    main()
