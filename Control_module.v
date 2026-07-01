module control ( 
	input [5:0] opcode,
	output reg reg_dst, alu_src, mem_to_reg, reg_write,
	output reg mem_read, mem_write, branch,
	output reg [1:0] alu_op
);
	
	always @(*) begin
		// Default values to prevent inferred latches
		reg_dst = 0;
		alu_src = 0;
		mem_to_reg = 0;
		reg_write = 0;
		mem_read = 0;
		mem_write = 0;
		branch = 0;
		alu_op = 2'b00;
		
		case (opcode)
			6'b000000: begin // R-type (add, sub, and, or, slt)
				reg_dst = 1;      // Destination is rd
				mem_to_reg = 0;   // Writeback data comes from ALU
				reg_write = 1;
				mem_read = 0;
				alu_op = 2'b10;   // ALU operation determined by funct field
			end
			6'b100011: begin // lw (load word)
				alu_src = 1;      // ALU second operand is immediate
				mem_to_reg = 1;   // Writeback data comes from memory
				reg_write = 1;
				mem_read = 1;
				alu_op = 2'b00;   // ALU adds base address + offset
			end
			6'b101011: begin // sw (store word)
				alu_src = 1;      // ALU second operand is immediate
				mem_write = 1;
				alu_op = 2'b00;   // ALU adds base address + offset
			end
			6'b000100: begin // beq (branch on equal)
				branch = 1;
				alu_op = 2'b01;   // ALU subtracts operands to test equality
			end
		endcase
	end
	
endmodule
