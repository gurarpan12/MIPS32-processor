# 32-bit Pipelined MIPS Processor in Verilog

## Overview

This repository contains a Register Transfer Level (RTL) implementation of a **32-bit MIPS Processor** in Verilog. The processor follows the classic **5-stage pipelined architecture** to improve instruction throughput while maintaining modular and readable hardware design.

Unlike a basic single-cycle or sequential processor, this implementation includes dedicated hardware for resolving pipeline hazards. A **Forwarding Unit** and **Hazard Detection Unit** dynamically handle Read-After-Write (RAW) data dependencies and control hazards, minimizing pipeline stalls without relying on software-inserted NOP instructions.

---

## Architecture

The processor implements the standard 5-stage MIPS pipeline. Each stage is separated by synchronous pipeline registers (`IF/ID`, `ID/EX`, `EX/MEM`, and `MEM/WB`) that capture data and control signals on the rising edge of the clock.

### 1. Instruction Fetch (IF)
- Maintains the Program Counter (PC)
- Fetches 32-bit instructions from Instruction Memory (`imem`)
- Updates the PC for sequential execution or branching

### 2. Instruction Decode (ID)
- Decodes instructions using the Control Unit
- Reads source operands from the Register File
- Generates control signals
- Calculates branch targets and evaluates branch conditions

### 3. Execute (EX)
- Performs arithmetic and logical operations using the ALU
- Computes effective addresses for memory instructions
- Executes comparison operations for branching

### 4. Memory Access (MEM)
- Reads from or writes to Data Memory (`dmem`)
- Handles `lw` and `sw` instructions

### 5. Write Back (WB)
- Writes ALU results or memory data back into the Register File
- Completes the execution of an instruction

---

## Hazard Resolution

To achieve efficient pipeline execution with minimal stalls, the processor implements dedicated hazard handling hardware.

### Forwarding Unit
The forwarding unit detects Read-After-Write (RAW) dependencies and forwards results directly from later pipeline stages to the ALU inputs instead of waiting for register write-back. This significantly reduces unnecessary pipeline stalls.

### Hazard Detection Unit
Load-use hazards cannot always be resolved through forwarding. When an instruction depends on data from a preceding `lw` instruction, the hazard detection unit:
- Stalls the IF and ID stages
- Inserts a single NOP into the EX stage
- Resumes execution once the required data becomes available

### Branch Handling
When a branch is taken, instructions already fetched after the branch become invalid. The processor flushes the `IF/ID` pipeline register by replacing the incorrect instruction with a NOP (`32'b0`), ensuring correct program execution.

---

## Simulation

### Prerequisites

- Icarus Verilog (`iverilog`)
- GTKWave

### Steps

#### 1. Initialize Instruction Memory

Place the 32-bit hexadecimal machine code instructions in:

```text
imem_init.mem
```

#### 2. Compile

```bash
iverilog -o cpu_sim *.v
```

#### 3. Run the Simulation

```bash
vvp cpu_sim
```

After execution, the testbench prints a performance report including:
- Register File contents
- Data Memory contents
- Total clock cycles
- Cycles Per Instruction (CPI)

#### 4. View Waveforms

```bash
gtkwave mips_pipeline.vcd
```

---

## Waveform Verification

The generated waveform can be used to verify the correct operation of the pipeline.

### Pipeline Progression
Instructions move through the five pipeline stages one clock cycle at a time, demonstrating proper pipeline flow.

### Branch Verification
When a branch is taken:
- The Program Counter updates to the target address.
- Invalid instructions are flushed.
- Pipeline registers receive NOPs, preventing incorrect execution.

### Write-Back Verification
The `reg_write` control signal generated during instruction decode propagates through the pipeline and reaches the write-back stage after the expected pipeline latency, confirming correct instruction completion.

---

## Features

- 32-bit MIPS Processor
- 5-stage pipelined architecture
- Modular RTL Verilog implementation
- Forwarding Unit for RAW hazard resolution
- Hazard Detection Unit with automatic pipeline stalling
- Branch flushing for control hazard handling
- Separate Instruction and Data Memory
- Register File with synchronous write-back
- GTKWave-compatible waveform generation
- Simulation support using Icarus Verilog
