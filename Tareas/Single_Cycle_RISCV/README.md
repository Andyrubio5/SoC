# Procesador Single Cycle RISCV

Este proyecto implementa una arquitectura de  un microprocesador RISCV que ejecuta la instruccion en un solo ciclo (Single Cycle) de reloj. 

## Características

- **Arquitectura**: Ciclo único (Single-Cycle)
- **ISA**: RISC-V RV32I (Base Integer Instruction Set)
- **Lenguaje de descripción**: Verilog
- **Bloques**:
  -Program Counter
  -Instruction Memory
  -Register File
  -Immediate Generator 
  -ALU Control
  -ALU
  -Control Unit
  -Data Memory


## Estructura del Proyecto

- `src/`: Contiene los módulos Verilog que definen la arquitectura del procesador.
- `testbench/`: Incluye los bancos de pruebas para verificar el funcionamiento de cada módulo y del procesador completo.
- `programs/`: Programas de prueba escritos en ensamblador RISC-V para validar la ejecución de instrucciones.

## Instrucciones Implementadas

El procesador soporta un subconjunto de instrucciones encontrados en el archivo "instructions.hex"

| .hex instruction | op      | instruction        | RegWrite | AluSrc | MemWrite | ResultSrc | Branch | ALUOP |
|------------------|---------|--------------------|----------|--------|-----------|------------|--------|--------|
| `00500113`       | 0010011 | AddI x2, x0, 5     |    1     |   1    |     0     |     0      |   0    |   10   |
| `00C00193`       | 0010011 | AddI x3, x0, 12    |    1     |   1    |     0     |     0      |   0    |   10   |
| `FF718393`       | 0010011 | AddI x7, x3, -9    |    1     |   1    |     0     |     0      |   0    |   10   |
| `0023E233`       | 0110011 | OR x4, x7, x2      |    1     |   0    |     0     |     0      |   0    |   10   |
| `0041F2B3`       | 0110011 | AND x5, x3, x4     |    1     |   0    |     0     |     0      |   0    |   10   |
| `004282B3`       | 0110011 | ADD x5, x5, x4     |    1     |   0    |     0     |     0      |   0    |   10   |
| `02728863`       | 1100011 | BEQ x5, x7, offset |    0     |   0    |     0     |     0      |   1    |   01   |
| `0041A233`       | 0100011 | SW x4, 0(x3)       |    0     |   1    |     1     |     0      |   0    |   00   |
| `00020463`       | 1100011 | BEQ x4, x0, offset |    0     |   0    |     0     |     0      |   1    |   01   |
| `00000293`       | 0010011 | AddI x5, x0, 0     |    1     |   1    |     0     |     0      |   0    |   10   |

