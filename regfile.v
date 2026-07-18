module regfile (
    input wire clk,
    input wire reset, 
    input wire reg_write,
    input wire [4:0] rs, rt, rd,
    input wire [31:0] write_data,
    output wire [31:0] read_data1, read_data2
);
    
    reg [31:0] regs [0:31];
    integer i;

    assign read_data1 = (rs == 5'b0) ? 32'b0 : ((reg_write && (rd == rs)) ? write_data : regs[rs]);
    assign read_data2 = (rt == 5'b0) ? 32'b0 : ((reg_write && (rd == rt)) ? write_data : regs[rt]);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                regs[i] <= 32'b0; 
            end
        end else begin
            if (reg_write && rd != 5'b0) begin
                regs[rd] <= write_data;
            end
        end
    end
    
endmodule
