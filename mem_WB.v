module mem_wb (
	input clk,
	input reset,
	input [31:0] mem_data_in,
	input [31:0] alu_result_in,
	input [4:0] write_reg_in,
	input mem_to_reg_in,
	input reg_write_in,

	output reg [31:0] mem_data_out,
	output reg [31:0] alu_result_out,
	output reg [4:0] write_reg_out,
	output reg mem_to_reg_out,
	output reg reg_write_out
);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			mem_data_out   <= 32'b0;
			alu_result_out <= 32'b0;
			write_reg_out  <= 5'b0;
			mem_to_reg_out <= 1'b0;
			reg_write_out  <= 1'b0;
		end else begin
			mem_data_out   <= mem_data_in;
			alu_result_out <= alu_result_in;
			write_reg_out  <= write_reg_in;
			mem_to_reg_out <= mem_to_reg_in;
			reg_write_out  <= reg_write_in;
		end
	end

endmodule
