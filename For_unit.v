module forwarding_unit (
    input [4:0] rs_ex, rt_ex,
    input [4:0] write_reg_mem, write_reg_wb,
    input reg_write_mem, reg_write_wb,
    output reg [1:0] forward_a, forward_b
);

    always @(*) begin
        forward_a = 2'b00;
        forward_b = 2'b00;
        
        // Priority 1: Forward from EX/MEM (Most recent data)
        if (reg_write_mem && (write_reg_mem != 5'b0) && (write_reg_mem == rs_ex)) 
            forward_a = 2'b10; 
        // Priority 2: Forward from MEM/WB (Older data, only if EX/MEM doesn't match)
        else if (reg_write_wb && (write_reg_wb != 5'b0) && (write_reg_wb == rs_ex)) 
            forward_a = 2'b01; 
        
        if (reg_write_mem && (write_reg_mem != 5'b0) && (write_reg_mem == rt_ex)) 
            forward_b = 2'b10; 
        else if (reg_write_wb && (write_reg_wb != 5'b0) && (write_reg_wb == rt_ex)) 
            forward_b = 2'b01; 
    end
endmodule
