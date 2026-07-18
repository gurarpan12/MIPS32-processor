`timescale 1ns / 1ps

module tb_cpu;

    reg clk;
    reg reset;

    pipelined_cpu uut (
        .clk(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        $dumpfile("cpu_waveform.vcd");
        $dumpvars(0, tb_cpu);

        #10;
        reset = 0;

        # 1000;
        $finish;
    end

endmodule
