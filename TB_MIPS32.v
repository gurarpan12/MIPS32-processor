`timescale 1ns/1ps

module mips_tb;

	reg clk;
	reg reset;
	integer i;

	// Instantiate the core processor
	pipelined_cpu uut(
		.clk(clk),
		.reset(reset)
	);

	// Generate a 10ns clock
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	// Generate VCD file for GTKWave
	initial begin
		$dumpfile("mips32_processor.vcd");
		$dumpvars(0, mips_tb);
	end

	initial begin
		// Force reset to stabilize the CPU
		reset = 1;
		#20;
		reset = 0;

		// Initialize Data Memory for the 'lw' instructions (Indices 0 to 5)
		uut.DMEM.memory[0] = 32'd15;
		uut.DMEM.memory[1] = 32'd25;
		uut.DMEM.memory[2] = 32'd35;
		uut.DMEM.memory[3] = 32'd45;
		uut.DMEM.memory[4] = 32'd55;
		uut.DMEM.memory[5] = 32'd65;

		// Let the 56-instruction program run to completion
		#1200;

		// Print the results written back by the 'sw' instructions
		// The program stores results in byte addresses 24 through 60.
		// Since DMEM is word-aligned, these are indices 6 through 15.
		$display("\n=============================================");
		$display("PROGRAM EXECUTION COMPLETE");
		$display("=============================================");
		$display("Final Calculated Values Stored in Data Memory:");
		
		for (i = 6; i <= 15; i = i + 1) begin
			$display("DMEM[%0d] (Address %0d) = %0d", i, (i*4), $signed(uut.DMEM.memory[i]));
		end
		
		$display("=============================================\n");

		#50;
		$finish;
	end

endmodule
