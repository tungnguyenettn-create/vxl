# Hardware-Efficient Power-of-2 Quantized CNN for Human Presence Detection

Triển khai phần cứng (FPGA/RTL) tiết kiệm năng lượng cho mạng nơ-ron tích chập lượng tử hóa lũy thừa của 2 (**Power-of-2 Weights**) kết hợp đầu vào độ chính xác bit thấp (**Low Bit-Precision Input**) phục vụ bài toán phát hiện người (Human Detection).

Dự án bao gồm quy trình khép kín từ huấn luyện mô hình PyTorch (QAT + Iterative Pruning), xuất mô hình tham chiếu nguyên bit-accurate (Integer Golden Model), đến sinh thiết kế phần cứng qua hai luồng: **Chisel/Scala RTL** và **Bambu HLS**.

---

## 📁 Cấu trúc thư mục

```text
.
├── main.py                  # Entry-point tổng hợp để train, prune và đánh giá mô hình
├── qnn/                     # Package lõi cho Quantized Neural Network (PyTorch)
│   ├── config.py            # Cấu hình kiến trúc mạng và tham số lượng tử hóa
│   ├── data.py              # Pipeline nạp dữ liệu và tiền xử lý ảnh đầu vào (4-bit)
│   ├── engine.py            # Vòng lặp huấn luyện (Training) và đánh giá (Evaluation)
│   ├── hw.py                # Mô phỏng hành vi phần cứng và gấp tham số BatchNorm
│   ├── metrics.py           # Các độ đo đánh giá hiệu năng mô hình
│   ├── model.py             # Định nghĩa kiến trúc CNN (8p-16p-24-32p-32)
│   ├── prune.py             # Thuật toán cắt tỉa kênh lặp (Iterative Channel Pruning)
│   └── quant.py             # Lượng tử hóa trọng số Power-of-2 (4-bit) & Activation (6-bit)
├── runs/                    # Lưu trữ checkpoints, cache dữ liệu và kết quả đánh giá
│   └── iter_p2w4a6_in4/     # Thư mục kết quả cấu hình P2W4-A6-IN4
│       ├── float.pt         # Checkpoint mô hình gốc (Floating-point)
│       ├── model.pt         # Checkpoint sau QAT và Pruning
│       └── eval.json        # Báo cáo các chỉ số đánh giá
├── golden_model.ipynb       # Notebook trích xuất trọng số từ PyTorch (.pt) sang định dạng .hex
├── golden_model_hex.ipynb   # Notebook trực quan hóa và đối chiếu từng tầng (layer-by-layer) của luồng tính toán
├── golden_model_hex.py      # Mô hình tham chiếu thuần số nguyên (Bit-accurate Golden Model) làm chuẩn cho C/Scala
├── golden_out/              # Dữ liệu tham chiếu định dạng .hex phục vụ kiểm thử RTL/HLS
│   ├── params.json          # Siêu tham số kiến trúc và hệ số dịch bit (shift)
│   ├── w_L*.hex, w_all_merged.hex  # Trọng số đã mã hóa 4-bit Power-of-2
│   ├── bn_M_L*.hex, bn_B_L*.hex    # Tham số BatchNorm đã gấp (Folded Multiplier & Bias)
│   └── img*_*.hex           # Vector đầu vào và kết quả trung gian từng lớp (acc, out, fc)
├── test.scala               # Mã nguồn Chisel/Scala mô tả kiến trúc phần cứng PersonCnn
├── generated/               # Mã nguồn Verilog và FIRRTL được sinh tự động từ Chisel
│
