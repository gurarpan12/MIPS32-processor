module hazard_detection_unit (
    input [4:0] rs_id, rt_id,
    input [4:0] rt_ex,
    input mem_read_ex,
    output reg pc_write,
    output reg if_id_write,
    output reg stall_ctrl
);

    always @(*) begin
        pc_write = 1'b1;
        if_id_write = 1'b1;
        stall_ctrl = 1'b0;
        
        if (mem_read_ex && ((rt_ex == rs_id) || (rt_ex == rt_id))) begin
            pc_write = 1'b0;      // Freeze PC
            if_id_write = 1'b0;   // Freeze IF/ID
            stall_ctrl = 1'b1;    // Clear control signals in ID/EX (Bubble)
        end
    end
endmodule
