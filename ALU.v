module alu(
    input wire [31:0] a, b,
    input wire [2:0] alu_ctrl,
    output reg [31:0] result,
    output wire zero
);

    always @(*) begin
        case (alu_ctrl)
            3'b000: result = a & b;
            3'b001: result = a | b;
            3'b010: result = a + b;
            3'b011: result = a ^ b;
            3'b100: result = ~(a | b);
            3'b101: result = b << a[4:0];
            3'b110: result = a - b;
            3'b111: result = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0;
            default: result = 32'd0;
        endcase
    end

    assign zero = (result == 32'd0) ? 1'b1 : 1'b0;

endmodule
