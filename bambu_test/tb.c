/* Testbench: so C voi D / pred tu Python golden model. Dung cho gcc va Bambu. */
#include <stdio.h>
#include <stdint.h>
#include "test_vectors.h"

int cnn_top(const uint8_t *img, int32_t *D_out);

int main(void)
{
    int fail = 0;
    for (int k = 0; k < TV_N; k++) {
        int32_t D = 0;
        int pred = cnn_top(TV_IMG[k], &D);
        int ok = (D == TV_D[k]) && (pred == TV_PRED[k]);
        printf("img %d: D=%d (expect %d) pred=%d (expect %d) %s\n",
               k, (int)D, (int)TV_D[k], pred, TV_PRED[k], ok ? "OK" : "MISMATCH");
        fail |= !ok;
    }
    return fail; /* 0 = pass */
}
