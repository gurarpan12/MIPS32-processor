💻 32-bit Pipelined MIPS Processor in Verilog

📌 Overview

This repository contains a full RTL (Register Transfer Level) Verilog implementation of a 32-bit MIPS microprocessor. It features a classic 5-stage pipeline architecture designed for high instruction throughput.

Unlike basic sequential processors, this design implements advanced hardware-level hazard resolution—including a Forwarding Unit and a Hazard Detection Unit—allowing it to handle Read-After-Write (RAW) data dependencies and control hazards dynamically without relying on software-injected NOPs (bubbles).

🏗️ Architecture & Datapath

The core is built upon the standard RISC 5-stage pipeline. Each stage is separated by synchronous pipeline registers (IF/ID, ID/EX, EX/MEM, MEM/WB) that latch data and control signals on the positive clock edge.

Instruction Fetch (IF):

Maintains the Program Counter (PC).

Fetches the 32-bit machine code instruction from Instruction Memory (imem).

Instruction Decode (ID):

Decodes the instruction using the Control Unit.

Reads operand values from the Register File.

Calculates branch targets and evaluates branch conditions early to minimize penalties.

Execute (EX):

The Arithmetic Logic Unit (ALU) performs mathematical operations, logical operations, or calculates memory addresses.

Memory (MEM):

Interfaces with Data Memory (dmem) for Load Word (lw) and Store Word (sw) instructions.

Write-Back (WB):

Commits the final ALU result or Memory read data back to the Register File.

⚡ Advanced Hazard Resolution

To maintain a Cycles Per Instruction (CPI) close to 1.0, this processor implements robust hardware interlocks:

Data Hazard Mitigation (Forwarding Unit):
Detects RAW dependencies where an instruction needs an operand that is still in the EX or MEM stage. It bypasses the register file and forwards the data directly to the ALU inputs (forward_a, forward_b), preventing unnecessary pipeline stalls.

Load-Use Hazard Mitigation (Stall Logic):
If an instruction requires data from a preceding lw instruction that hasn't reached the WB stage, the Hazard Unit dynamically stalls the IF and ID stages and injects a single pipeline bubble (NOP) into the EX stage.

Control Hazard Mitigation (Branch Flushing):
When a branch is taken, the instructions fetched in the "branch delay slots" are invalid. The hardware actively flushes the IF/ID pipeline register (forcing it to 32'b0 / NOP), effectively clearing the undefined or incorrect states before jumping to the new target address.

🚀 How to Run the Simulation

Prerequisites

Icarus Verilog (iverilog): For compiling the Verilog code.

GTKWave: For viewing the .vcd waveform output.

Execution Steps

Write Assembly / Machine Code:
Place your 32-bit hexadecimal machine code instructions into the imem_init.mem file.

Compile the Design:

iverilog -o cpu_sim *.v


Run the Simulation:

vvp cpu_sim


Note: Upon successful execution, the testbench will output a "Core Simulation and Performance Audit Report" directly in the terminal, displaying the final Register states, RAM states, and calculated CPI.

View Waveforms:

gtkwave mips_pipeline.vcd


📊 Waveform Analysis & Verification

When analyzing the GTKWave output, you can verify the pipeline's functional correctness by observing the "Waterfall Effect":

Synchronous Flow: Instructions (instr_if) can be seen cascading down into the Decode stage (instr_id) exactly one clock cycle later.

Flawless Branching: When pc_current jumps to a new address due to a branch, you will observe the pipeline actively flushing. The intermediate registers are zeroed out (NOPs), ensuring no garbage data or X (undefined) states poison the ALU.

Write-Back Commit: You can trace the initial reg_write control signal generated in the ID stage delaying by exactly 3 clock cycles to become reg_write_wb, successfully retiring the instruction lifecycle.
