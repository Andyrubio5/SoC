# ✦ PIPELINE Processor ✦
Means that the circuit allows multiple intructions to be processed in parallel. 

## Objective 
A 32-bit RISC-V processor implementation with 5-stage pipeline in Verilog HDL, designed for educational and research purposes in computer architecture.


## Proyect Structure
```
Pipeline_RISCV/
├── README.md
├── src/
│   ├── top.v
│   ├── stages/
│   │   ├── IF.v
│   │   ├── ID.v
│   │   ├── EX.v
│   │   ├── MEM.v
│   │   └── WB.v
│   ├── pipeline_registers/
│   │   ├── IF_ID.v
│   │   ├── ID_EX.v
│   │   ├── EX_MEM.v
│   │   └── MEM_WB.v
│   ├── components/
│   │   ├── RegFile.v
│   │   ├── ALU.v
│   │   ├── ControlUnit.v
│   │   ├── ImmGen.v
│   │   ├── DataMemory.v
│   │   ├── InstructionMemory.v
│   │   └── HazardUnit.v
│   └── instructions.hex
├── testbench/
│   └── pipeline_tb.v
├── docs/
│   ├── README.md
│   ├── pipeline-architecture.md
│   ├── stages/
│   │   ├── instruction-fetch.md
│   │   ├── instruction-decode.md
│   │   ├── execute.md
│   │   ├── memory-access.md
│   │   └── write-back.md
│   ├── hazards/
│   │   ├── data-hazards.md
│   │   ├── control-hazards.md
│   │   └── forwarding.md
│   └── images/
│       ├── pipeline-diagram.png
│       ├── datapath.png
│       └── control-signals.png
└── .gitignore
```

### 🟊 5-Stage Pipeline
```
IF (Instruction Fetch) → ID (Instruction Decode) → EX (Execute) → MEM (Memory) → WB (Write Back)
```

###  🟊 Main Components
- **Datapath**: Main data path with pipeline registers
- **Control Unit**: Centralized control unit
- **ALU**: 32-bit arithmetic-logic unit
- **Register File**: 32-register bank of 32 bits each
- **Memory**: Separate instruction and data memories
- **Hazard Unit**: Hazard detection and handling 

## RISC-V Pipeline Documentation

Documentation for the 5-stage pipelined RISC-V processor. This section provides detailed information about the architecture, each pipeline stage, hazard handling, and visual resources.

### 🟊 Architecture
- [Pipeline Overview](pipeline-architecture.md)

### 🟊 Pipeline Stages
- [Instruction Fetch (IF)](IF_Stage.md)
- [Instruction Decode (ID)](C:\Users\andyq\Documents\QuartusProjects\Architecture_code\SoC\Tareas\PipeLine_RISCV\Documentation\ID_Stage.md)
- [Execute (EX)](C:\Users\andyq\Documents\QuartusProjects\Architecture_code\SoC\Tareas\PipeLine_RISCV\Documentation\EX_Stage.md)
- [Memory Access (MEM)](C:\Users\andyq\Documents\QuartusProjects\Architecture_code\SoC\Tareas\PipeLine_RISCV\Documentation\MEM_Stage.md)
- [Write Back (WB)](C:\Users\andyq\Documents\QuartusProjects\Architecture_code\SoC\Tareas\PipeLine_RISCV\Documentation\WB_Stage.md)

### 🟊 Hazard Handling
- [Data Hazards](hazards/data-hazards.md)
- [Control Hazards](hazards/control-hazards.md)
- [Forwarding](hazards/forwarding.md)

