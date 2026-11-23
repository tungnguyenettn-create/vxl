#include "VPersonCnn.h"
#include "verilated.h"
#include <cstdio>
#include <fstream>
#include <vector>

int main() {
    VPersonCnn* dut = new VPersonCnn;
    auto tick = [&]() {
        dut->clock = 0; dut->eval();
        dut->clock = 1; dut->eval();
    };

    int indices[] = {0, 362};
    for (int idx : indices) {
        char path[64];
        snprintf(path, sizeof(path), "golden_out/img%d_in.hex", idx);
        std::ifstream fin(path);
        std::vector<int> img;
        int val;
        while (fin >> std::hex >> val) img.push_back(val);

        dut->reset = 1; dut->io_loadEn = 0; dut->io_start = 0;
        for (int i = 0; i < 5; i++) tick();
        dut->reset = 0; tick();

        dut->io_loadEn = 1;
        for (int i = 0; i < 4096; i++) {
            dut->io_loadAddr = i;
            dut->io_loadData = img[i];
            tick();
        }
        dut->io_loadEn = 0;

        dut->io_start = 1; tick();
        dut->io_start = 0;

        long cycles = 0;
        while (!dut->io_done) { tick(); cycles++; }
        printf("Img %d -> dOut = %d, pred = %d, cycles = %ld\n",
               idx, (int32_t)dut->io_dOut, dut->io_pred, cycles);
    }
    delete dut;
    return 0;
}
