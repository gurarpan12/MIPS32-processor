module dmem(
    input wire clk,
    input wire mem_read,
    input wire mem_write,
    input wire [31:0] addr,
    input wire [31:0] write_data,
    output reg [31:0] read_data
);

    reg [31:0] memory [0:255]; // 256 words of memory size is 1024 bytes

    always @(posedge clk) begin
        if (mem_write) begin
            memory[addr[9:2]] <= write_data;
        end
    end

    always @(*) begin
        if(mem_read)
            read_data = memory[addr[9:2]];
        else
            read_data = 32'b0;
    end
    
endmodule
