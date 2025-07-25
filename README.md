## 🔐 About AES-128 Algorithm

AES (Advanced Encryption Standard) is a symmetric block cipher standardized by NIST. It encrypts 128-bit data blocks using a 128-bit key and involves:

1. **Key Expansion**: Generates round keys from the cipher key.
2. **Initial Round**:
   - AddRoundKey
3. **9 Main Rounds**:
   - SubBytes
   - ShiftRows
   - MixColumns
   - AddRoundKey
4. **Final Round**:
   - SubBytes
   - ShiftRows
   - AddRoundKey

This project implements the AES-128 variant, which includes 10 rounds of transformation.

## 📘 What is RTL?

**RTL (Register-Transfer Level)** is a design abstraction used in digital circuit design that describes the flow of data between registers and the logical operations performed on that data. At the RTL level, hardware behavior is modeled in terms of:

- **Registers** (storage elements like flip-flops)
- **Combinational logic** (like adders, multiplexers, etc.)
- **Clock-driven behavior** (synchronous systems)

RTL design is typically written in **Hardware Description Languages (HDLs)** such as VHDL or Verilog and is used to synthesize hardware on FPGAs or ASICs.

---
## 🧠 RTL Design Overview
The design follows a **modular RTL architecture** using **VHDL**, where each AES step is implemented as an independent module:

- Each module has been tested individually using its dedicated **testbench**.
- The top-level control is done via a **Finite State Machine (FSM)** in `Final.vhd`, orchestrating the AES encryption flow.
- The architecture separates **data path** (SubBytes, MixColumns...) from the **control logic** (FSM), making it scalable and maintainable.

The design is suitable for FPGA implementation and has been simulated in [Tool Name] (e.g., ModelSim/Vivado).

# AES Project in VHDL
This project implements the **AES-128 encryption algorithm** using VHDL.

## 🗂️ Folder Structure

AES_Projet/
│
├── Main/ # Main AES modules (SubBytes, ShiftRows, MixColumns, etc.)
├── Testbench/ # Testbenches for individual AES components
├── README.md # This file

markdown
Copier
Modifier

## ⚙️ Modules Implemented

- `SubByte.vhd`
- `ShiftRows.vhd`
- `MixColumns.vhd`
- `AddRoundKey.vhd`
- `Key_Expansion.vhd`
- `Final.vhd` — top-level FSM

## 🧪 Testbenches

Each module has a corresponding testbench:
- `ShiftRowsTB.vhd`
- `Mix_ColumnsTB.vhd`
- `Final_TB.vhd`
- ...

## ✅ Status

✅ Modules tested and working  
🚧 Final integration in progress

## 👨‍💻 Author

Soufiane Bouchda  
[GitHub: @Sbouchda](https://github.com/Sbouchda)