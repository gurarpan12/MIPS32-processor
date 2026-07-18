module control(
    input wire [5:0] opcode,
    output reg reg_dst, alu_src, mem_to_reg, reg_write,
    output reg mem_read, mem_write, branch,
    output reg [1:0] alu_op
);

    always @(*) begin
        // Default values
        reg_dst = 0;
        alu_src = 0;
        mem_to_reg = 0;
        reg_write = 0;
        mem_read = 0;
        mem_write = 0;
        branch = 0;
        alu_op = 2'b00;

        case(opcode)
            6'b000000: begin // R-type (add, sub, and, or, slt)
                reg_dst = 1; // Write to rd
                alu_src = 0;    
                mem_to_reg = 0; // Write ALU result to register
                reg_write = 1;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b10; // ALU operation determined by funct field
            end
            6'b100011: begin // lw (load word)
                reg_dst = 0; 
                alu_src = 1; // use immediate value for address calculation
                mem_to_reg = 1; // write data from memory to register
                reg_write = 1;  
                mem_read = 1;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b00; // ALU performs addition for address calculation
            end
            6'b101011: begin // sw (store word)
                reg_dst = 0; 
                alu_src = 1; // use immediate value for address calculation
                mem_to_reg = 0; // not used
                reg_write = 0;  
                mem_read = 0;
                mem_write = 1;
                branch = 0;
                alu_op = 2'b00; // ALU performs addition for address calculation
            end
            6'b000100: begin // beq (branch on equal)
                reg_dst = 0; 
                alu_src = 0; // use register values for comparison
                mem_to_reg = 0; // not used
                reg_write = 0;  
                mem_read = 0;
                mem_write = 0;
                branch = 1; // enable branching
                alu_op = 2'b01; // ALU performs subtraction for comparison
            end
            default: begin 
                reg_dst = 0;
                alu_src = 0; 
                mem_to_reg = 0; 
                reg_write = 0;
                mem_read = 0; 
                mem_write = 0; 
                branch = 0; 
                alu_op = 2'b00;
            end
        endcase
    end

endmodule


