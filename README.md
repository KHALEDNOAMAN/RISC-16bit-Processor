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

## 🤝 Contributing
Contributions are welcome! Please open an issue or submit a pull request.

## 📄 License
This project is licensed under the MIT License.
