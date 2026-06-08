# 8-Bit Advanced RISC Processor

## Overview

This project implements a simple 8-bit RISC (Reduced Instruction Set Computer) processor in Verilog HDL. The processor consists of fundamental components such as an Arithmetic Logic Unit (ALU), Register File, Program Counter, Instruction Memory, Data Memory, and Control Unit.

The design demonstrates the basic working principles of a processor including instruction fetching, decoding, execution, and register write-back.

---

## Features

- 8-bit data path
- 16-bit Program Counter
- 8 General Purpose Registers
- Arithmetic and Logic Operations
- Instruction Memory
- Data Memory
- Control Unit for instruction decoding
- Simulation Testbench
- Waveform generation using VCD file

---

## Module Description

### 1. ALU (Arithmetic Logic Unit)

Performs arithmetic and logical operations.

Supported Operations:

| Opcode | Operation |
|----------|----------|
| 0000 | ADD |
| 0001 | SUB |
| 0010 | AND |
| 0011 | OR |

Outputs:
- Result
- Zero Flag
- Carry Flag
- Negative Flag
- Overflow Flag

---

### 2. Register File

Contains 8 registers of 8 bits each.

Features:
- Two read ports
- One write port
- Asynchronous read
- Synchronous write
- Reset capability

---

### 3. Program Counter

Maintains the address of the next instruction.

Operations:
- Reset
- Increment
- Load new address

---

### 4. Instruction Memory

Stores program instructions.

Memory Size:
- 256 locations
- 8-bit instruction width

Preloaded Instructions:

| Address | Instruction |
|----------|------------|
| 0 | 00000001 |
| 1 | 00000010 |
| 2 | 00000011 |
| 3 | 00000000 |

---

### 5. Data Memory

Stores data values.

Specifications:
- 256 memory locations
- 8-bit data width
- Synchronous write
- Asynchronous read

---

### 6. Control Unit

Decodes instructions and generates control signals.

Control Signals:
- Register Write Enable
- Program Counter Increment
- ALU Operation Select

---

### 7. Top Module

Integrates all processor components:

- Program Counter
- Instruction Memory
- Control Unit
- Register File
- ALU

---

### 8. Testbench

The testbench performs:

- Clock generation
- Reset generation
- Waveform dumping
- Simulation termination

Clock Period:

- 10 ns

Simulation Time:

- 200 ns

---

## Processor Architecture

```
          +----------------+
          | Program Counter|
          +-------+--------+
                  |
                  v
          +----------------+
          | Instruction    |
          | Memory         |
          +-------+--------+
                  |
                  v
          +----------------+
          | Control Unit   |
          +-------+--------+
                  |
                  v
          +----------------+
          | Register File  |
          +-------+--------+
                  |
                  v
          +----------------+
          | ALU            |
          +-------+--------+
                  |
                  v
          +----------------+
          | Write Back     |
          +----------------+
```

---

## Simulation Instructions

### Using Icarus Verilog

Compile:

```bash
iverilog -o risc risc_processor.v
```

Run:

```bash
vvp risc
```

Generate Waveform:

```bash
gtkwave risc.vcd
```

---

## Expected Output

During simulation:

- Reset initializes all registers.
- Program Counter starts from 0.
- Instructions are fetched sequentially.
- ALU executes decoded operations.
- Results are written back into registers.
- Waveform file `risc.vcd` is generated.

---

## File Structure

```text
project/
│
├── risc_processor.v
├── README.md
├── risc.vcd
```

---

## Applications

- Computer Architecture Learning
- Digital Design Experiments
- FPGA Design Practice
- Processor Design Fundamentals
- Verilog HDL Training

---

## Future Enhancements

- Additional ALU Operations
- Branch Instructions
- Jump Instructions
- Pipeline Architecture
- Hazard Detection
- Interrupt Handling
- Cache Memory
- Multi-cycle Execution

---

## Author

8-Bit Advanced RISC Processor implemented using Verilog HDL for educational and simulation purposes.
