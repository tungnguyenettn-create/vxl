"""Accuracy / AUC / recall at fixed FPR, threshold tuning, confusion matrix."""
import numpy as np


def metrics(scores, labels, thr=0.0):
    s = np.asarray(scores, dtype=np.float64)
    y = np.asarray(labels)
    acc = float(((s > thr) == (y == 1)).mean())
    ys = y[np.argsort(-s, kind="stable")]
    P = max(1, int((y == 1).sum()))
    N = max(1, int((y == 0).sum()))
    tpr = np.r_[0.0, np.cumsum(ys == 1) / P]
    fpr = np.r_[0.0, np.cumsum(ys == 0) / N]
    auc = float(np.sum((fpr[1:] - fpr[:-1]) * (tpr[1:] + tpr[:-1]) / 2))

    def rec(f):
        return float(tpr[fpr <= f].max())

    return dict(acc=acc, auc=auc, rec_fpr5=rec(0.05), rec_fpr1=rec(0.01))


def tune_threshold(scores, labels):
    """Threshold maximising balanced accuracy (in hardware: just the output bias)."""
    s = np.asarray(scores, dtype=np.float64)
    y = np.asarray(labels)
    o = np.argsort(s, kind="stable")
    s, y = s[o], y[o]
    if len(s) < 2:
        return 0.0
    P = max(1, int((y == 1).sum()))
    N = max(1, int((y == 0).sum()))
    ba = 0.5 * (np.cumsum(y == 0) / N + (P - np.cumsum(y == 1)) / P)   # threshold just above s[i]
    i = int(np.argmax(ba[:-1]))
    return float(0.5 * (s[i] + s[i + 1]))


def confusion(scores, labels, thr=0.0):
    pred = np.asarray(scores) > thr
    y = np.asarray(labels) == 1
    return dict(tn=int((~y & ~pred).sum()), fp=int((~y & pred).sum()),
                fn=int((y & ~pred).sum()), tp=int((y & pred).sum()))


def format_confusion(cm, title):
    tn, fp, fn, tp = cm["tn"], cm["fp"], cm["fn"], cm["tp"]
    n = max(1, tn + fp + fn + tp)
    prec = tp / max(1, tp + fp)
    rec = tp / max(1, tp + fn)
    spec = tn / max(1, tn + fp)
    f1 = 2 * prec * rec / max(1e-12, prec + rec)
    return (f"{title}\n"
            f"                 pred no_person   pred person\n"
            f"  no_person   {tn:14d} {fp:13d}\n"
            f"  person      {fn:14d} {tp:13d}\n"
            f"  acc {(tp + tn) / n:.4f}  precision {prec:.4f}  recall {rec:.4f}  "
            f"specificity {spec:.4f}  F1 {f1:.4f}")
