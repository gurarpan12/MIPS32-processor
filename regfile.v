module regfile (
	input clk,
	input reg_write,
	input [4:0] rs, rt, rd,
	input [31:0] write_data,
	output [31:0] read_data1, read_data2
);
	
	reg [31:0] regs[0:31];

	assign read_data1 = (rs == 5'b0) ? 32'b0 : ((reg_write && (rd == rs)) ? write_data : regs[rs]);
	assign read_data2 = (rt == 5'b0) ? 32'b0 : ((reg_write && (rd == rt)) ? write_data : regs[rt]);

	always @(posedge clk) begin
		if (reg_write && rd != 5'b0)
			regs[rd] <= write_data;
	end
	
endmodule
