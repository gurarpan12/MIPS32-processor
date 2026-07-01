# MIPS32 5-Stage Pipelined Processor

A synthesizable 32-bit RISC processor core implemented in Verilog, featuring a full 5-stage pipeline architecture designed for efficient instruction execution and hardware throughput.

## Overview
This project focuses on the implementation of a MIPS32-compatible processor from the ground up. It covers the full hardware lifecycle, from architectural design and RTL implementation in Verilog to automated self-checking verification.

## Key Technical Features
* 5-Stage Pipeline: Modular datapath architecture integrating Instruction Fetch (IF), Decode (ID), Execute (EX), Memory (MEM), and Write-Back (WB) stages.
* Register File with Forwarding: Robust register file implementation featuring hardware-level `$zero` register protection and internal forwarding logic to ensure single-cycle data consistency.
* Modular Memory System: Supports external program initialization via `$readmemh`, allowing for scalable software testing and seamless integration of new assembly programs.
* Automated Verification: Professional-grade testbench architecture featuring self-checking capabilities, enabling rigorous functional validation of arithmetic, logic, and memory operations.

## Architecture


## Getting Started
1. Prerequisites: Ensure you have an HDL simulator installed (e.g., Icarus Verilog or Vivado).
2. Setup: Clone the repository and ensure all `.v` files are in the same directory.
3. Program Loading: Place your machine code in the `imem_init.mem` file.
4. Simulation:
   * Compile the design: `iverilog -o mips_sim *.v`
   * Run the simulation: `vvp mips_sim`
   * View waveforms: `gtkwave mips32_processor.vcd`

## Project Structure
* `InstrMem.v` / `DataMem.v`: Modular memory units with external initialization support.
* `regfile.v`: Register file with hazard-prevention and write-protection logic.
* `mips_tb.v`: Automated self-checking testbench for functional validation.
* `imem_init.mem`: Hex-encoded instruction memory for program execution.
