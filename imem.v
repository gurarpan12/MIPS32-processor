module imem (
    input [31:0] addr,
    output reg [31:0] instr
);
    reg [31:0] memory [0:255]; 

    initial begin
        $readmemh("imem_init.mem", memory);
    end

    always @(*) begin
        if (addr[9:2] >= 256 || addr[1:0] != 2'b00) begin
            instr = 32'h00000000; 
        end else begin
            instr = memory[addr[9:2]];
            if (instr === 32'bxxxxxxxx) begin
                instr = 32'h00000000;
            end
        end
    end
endmodule
