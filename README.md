# 16-Bit RISC Processor

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![Verilog](https://img.shields.io/badge/Language-Verilog-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## 🖥️ Overview
An educational 16-Bit RISC Processor designed in Verilog with ALU, Control Unit, Register File, Data Memory, and Instruction Memory. Simulated using Icarus Verilog and ModelSim.

## ✨ Features
- **5-Stage Pipeline:** Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), Write Back (WB).
- **16 Registers:** Fast on-chip register file.
- **ALU Operations:** ADD, SUB, AND, OR, SHL, SHR.
- **Hazard Detection & Data Forwarding:** Ensures smooth pipeline operation without unnecessary stalls.
- **Branch Prediction:** Basic branching logic.
- **Memory-Mapped I/O:** Simple interfacing.

## 🏗️ Architecture

```text
       +----+    +----+    +----+    +-----+    +----+
-----> | IF | -> | ID | -> | EX | -> | MEM | -> | WB | ----->
       +----+    +----+    +----+    +-----+    +----+
          |         |         |         |          |
      Inst Mem   Reg File    ALU     Data Mem   Reg File
```

## 📖 Instruction Set

| Type   | Opcode | Description |
|--------|--------|-------------|
| R-Type | 0000   | ALU Ops     |
| I-Type | 0001   | Load/Store  |
| J-Type | 0010   | Jump/Branch |

## 🛠️ Tech Stack
- Verilog
- Icarus Verilog
- GTKWave
- ModelSim

## 🚀 Simulation Instructions
1. Clone the repository.
2. Compile using Icarus Verilog: `iverilog -o cpu_tb cpu_tb.v`
3. Run simulation: `vvp cpu_tb`

## 📊 Waveform Analysis
Open the generated `.vcd` file in GTKWave:
`gtkwave cpu_waveform.vcd`

## 📁 Project Structure
- `src/` - Verilog source files
- `tb/` - Testbenches
- `docs/` - Documentation

## 🗺️ Roadmap
- [ ] Add Cache Memory
- [ ] Interrupt Handling
- [ ] Memory Management Unit (MMU)

## 🤝 
---

## How It Works

### Pipeline Stages
1. **IF (Instruction Fetch)**: PC → Instruction Memory → IR
2. **ID (Instruction Decode)**: IR → Control Unit + Register File read
3. **EX (Execute)**: ALU performs operation, branch target calculated
4. **MEM (Memory Access)**: Load/Store from Data Memory
5. **WB (Write Back)**: Result written to Register File

### Hazard Handling
- **Data Hazards**: Resolved via forwarding (EX→EX, MEM→EX)
- **Control Hazards**: Branch prediction with 1-cycle penalty on mispredict
- **Structural Hazards**: Separate instruction and data memories (Harvard)

---

## Screenshots & Demo

### Waveform Output (GTKWave)
```
Time    0ns   10ns  20ns  30ns  40ns  50ns  60ns
CLK     ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐
        │ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └
PC      │ 00 │ 02 │ 04 │ 06 │ 08 │ 0A │
IR      │NOP │ADD │SUB │AND │LD  │ST  │
ALU_out │ 00 │ 07 │ 03 │ 05 │ -- │ -- │
RegW    │ 0  │ 1  │ 1  │ 1  │ 1  │ 0  │
```

### Example Program
```assembly
; Calculate sum of 1+2+3
LOAD  R1, #1      ; R1 = 1
LOAD  R2, #2      ; R2 = 2
ADD   R3, R1, R2  ; R3 = 3
LOAD  R4, #3      ; R4 = 3
ADD   R5, R3, R4  ; R5 = 6 (result)
STORE R5, [0x10]  ; Store to memory
```

### Running the Simulation
```bash
iverilog -o cpu_tb testbench/cpu_tb.v src/*.v
vvp cpu_tb
gtkwave cpu_tb.vcd    # View waveforms
```


Contributing
Contributions are welcome! Please open an issue or submit a pull request.

## 📄 License
This project is licensed under the MIT License.
