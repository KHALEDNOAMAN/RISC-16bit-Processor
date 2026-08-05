<div align="center">

# 🖥️ 16-Bit RISC Processor

**A fully functional 16-bit RISC processor designed in Verilog HDL with complete datapath, control unit, ALU, register file, and memory subsystems.**

[![Verilog](https://img.shields.io/badge/Verilog-HDL-blue?style=for-the-badge)](https://en.wikipedia.org/wiki/Verilog)
[![Icarus Verilog](https://img.shields.io/badge/Icarus-Verilog-orange?style=for-the-badge)](http://iverilog.icarus.com/)
[![ModelSim](https://img.shields.io/badge/ModelSim-Intel_FPGA-0071C5?style=for-the-badge)](https://www.intel.com/content/www/us/en/software-kit/750666/modelsim-intel-fpgas-standard-edition-software-version-20-1-1.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

*Computer Organization Course Project*

</div>

---

## 🏗️ Architecture

```
                        ┌─────────────────────────────────────┐
                        │         16-Bit RISC Processor        │
                        │                                     │
  ┌──────────┐     ┌────┴────┐     ┌──────────┐     ┌───────┐│
  │Instruction│────►│ Control │────►│ Datapath │◄───►│  Data ││
  │  Memory   │     │  Unit   │     │   Unit   │     │Memory ││
  └──────────┘     └─────────┘     └────┬─────┘     └───────┘│
                                        │                     │
                              ┌─────────┼─────────┐          │
                              │         │         │          │
                         ┌────┴───┐ ┌───┴──┐ ┌───┴────┐     │
                         │Register│ │ ALU  │ │  ALU   │     │
                         │  File  │ │      │ │Control │     │
                         │ 8×16b  │ │16-bit│ │  Unit  │     │
                         └────────┘ └──────┘ └────────┘     │
                        └─────────────────────────────────────┘
```

---

## 📦 Modules

| Module | File | Description |
|--------|------|-------------|
| **Processor** | `Processor.v` | Top-level module connecting Datapath + Control Unit |
| **Datapath** | `Datapath.v` | PC, register file, ALU, muxes, sign-extend, memory interface |
| **Control Unit** | `ControlUnit.v` | Decodes opcode → generates control signals (reg_dst, alu_src, mem_read, etc.) |
| **ALU** | `ALU.v` | 16-bit ALU with ADD, SUB, NOT, SHL, SHR, AND, OR, XOR, SLT operations |
| **ALU Control** | `ALUControlUnit.v` | Maps opcode + alu_op to 4-bit ALU control signal |
| **Register File** | `RegisterFile.v` | 8 × 16-bit general-purpose registers with dual read, single write |
| **Instruction Memory** | `InstructionMemory.v` | ROM storing program instructions (loaded from `.prog` file) |
| **Data Memory** | `DataMemory.v` | RAM for load/store operations (loaded from `.data` file) |
| **Parameters** | `Parameter.v` | Compile-time constants (memory sizes, filenames, simulation time) |
| **Testbench** | `Testbench.v` | Test harness with clock generation and VCD waveform dump |

---

## 🔧 Instruction Set Architecture (ISA)

### Instruction Format (16-bit)

```
R-Type:  [opcode(4)] [rs(3)] [rt(3)] [rd(3)]  [func(3)]
I-Type:  [opcode(4)] [rs(3)] [rt(3)] [immediate(6)]
J-Type:  [opcode(4)] [address(12)]
```

### Supported Instructions

| Opcode | Instruction | Type | Operation |
|--------|-------------|------|-----------|
| `0000` | LW | I | Load word from memory |
| `0001` | SW | I | Store word to memory |
| `0010` | ADD | R | rd = rs + rt |
| `0011` | SUB | R | rd = rs - rt |
| `0100` | NOT | R | rd = ~rs |
| `0101` | SHL | R | rd = rs << rt |
| `0110` | SHR | R | rd = rs >> rt |
| `0111` | AND | R | rd = rs & rt |
| `1000` | OR | R | rd = rs \| rt |
| `1001` | SLT | R | rd = (rs < rt) ? 1 : 0 |
| `1011` | BEQ | I | Branch if rs == rt |
| `1100` | BNE | I | Branch if rs != rt |
| `1101` | JUMP | J | PC = address |
| `1110` | XOR | R | rd = rs ^ rt |

---

## 🧪 ALU Operations

| ALU Control | Operation | Description |
|-------------|-----------|-------------|
| `0000` | ADD | a + b |
| `0001` | SUB | a - b |
| `0010` | NOT | ~a |
| `0011` | SHL | a << b |
| `0100` | SHR | a >> b |
| `0101` | AND | a & b |
| `0110` | OR | a \| b |
| `0111` | SLT | (a < b) ? 1 : 0 |
| `1000` | XOR | a ^ b |

---

## 🚀 Simulation

### Using Icarus Verilog
```bash
# Compile
iverilog -o risc_tb Testbench.v

# Run simulation
vvp risc_tb

# View waveforms
gtkwave RISC_16_bit.vcd
```

### Using ModelSim
```bash
vlib work
vlog *.v
vsim -do "run -all" Testbench
```

### Test Files
| File | Purpose |
|------|---------|
| `test/test.prog` | Program instructions (binary) |
| `test/test.data` | Initial data memory values |
| `test/test_data_result.txt` | Expected output after execution |

---

## 📊 Control Signals

| Instruction | reg_dst | alu_src | mem_to_reg | reg_write | mem_read | mem_write | beq | bne | alu_op | jump |
|-------------|---------|---------|------------|-----------|----------|-----------|-----|-----|--------|------|
| LW | 0 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 10 | 0 |
| SW | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 10 | 0 |
| R-Type | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 00 | 0 |
| BEQ | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 01 | 0 |
| BNE | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 01 | 0 |
| JUMP | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 00 | 1 |

---

## 📁 Project Structure

```
├── ALU.v                    # Arithmetic Logic Unit
├── ALUControlUnit.v         # ALU control decoder
├── ControlUnit.v            # Main control unit
├── DataMemory.v             # Data memory (RAM)
├── Datapath.v               # Complete datapath
├── InstructionMemory.v      # Instruction memory (ROM)
├── Parameter.v              # Global parameters
├── Processor.v              # Top-level module
├── RegisterFile.v           # Register file (8×16)
├── Testbench.v              # Testbench with clock
└── test/
    ├── test.prog            # Program binary
    ├── test.data            # Initial data
    └── test_data_result.txt # Expected results
```

---

## 📝 License
MIT License — see [LICENSE](LICENSE) file.

<div align="center">

Built by [Khaled Noaman](https://github.com/KHALEDNOAMAN) — Computer Engineering Student 🚀

</div>
