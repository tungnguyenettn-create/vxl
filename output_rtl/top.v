module top (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       serial_in,
    output reg        busy,
    output reg        done,
    output reg        pred,
    output reg        dout_parity
);

    // Thanh ghi dịch 18-bit để giữ nguyên toàn bộ ngõ vào mà chỉ tốn 1 chân pin
    // Bit: [17]=loadEn, [16:5]=loadAddr[11:0], [4:1]=loadData[3:0], [0]=start
    reg [17:0] in_sr;
    always @(posedge clk) begin
        if (!rst_n)
            in_sr <= 18'd0;
        else
            in_sr <= {in_sr[16:0], serial_in};
    end

    wire        w_busy;
    wire        w_done;
    wire        w_pred;
    wire [31:0] w_dout;

    PersonCnn u_person_cnn (
        .clock       (clk),
        .reset       (~rst_n),
        .io_loadEn   (in_sr[17]),
        .io_loadAddr (in_sr[16:5]),
        .io_loadData (in_sr[4:1]),
        .io_start    (in_sr[0]),
        .io_busy     (w_busy),
        .io_done     (w_done),
        .io_pred     (w_pred),
        .io_dOut     (w_dout)
    );

    // Chốt thanh ghi ngõ ra trước khi gộp XOR để không làm ảnh hưởng đường găng của PersonCnn
    // và ngăn Quartus tối ưu xóa mất logic tính io_dOut[31:0]
    reg [31:0] dout_reg;
    always @(posedge clk) begin
        if (!rst_n) begin
            busy        <= 1'b0;
            done        <= 1'b0;
            pred        <= 1'b0;
            dout_reg    <= 32'd0;
            dout_parity <= 1'b0;
        end else begin
            busy        <= w_busy;
            done        <= w_done;
            pred        <= w_pred;
            dout_reg    <= w_dout;
            dout_parity <= ^dout_reg;
        end
    end

endmodule