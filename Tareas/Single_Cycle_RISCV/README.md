# Procesador RISC-V de Ciclo Único

Este proyecto implementa un procesador RISC-V de 32 bits con arquitectura de ciclo único, siguiendo la especificación RV32I. Es una herramienta educativa diseñada para comprender los fundamentos de la arquitectura de computadoras y el diseño de procesadores.

## Características

- **Arquitectura**: Ciclo único (Single-Cycle)
- **ISA**: RISC-V RV32I (Base Integer Instruction Set)
- **Lenguaje de descripción**: Verilog
- **Componentes principales**:
  - Unidad de Control
  - Unidad Aritmético-Lógica (ALU)
  - Banco de Registros
  - Memoria de Instrucciones y Datos
  - Unidad de Control de Flujo

## Estructura del Proyecto

- `src/`: Contiene los módulos Verilog que definen la arquitectura del procesador.
- `testbench/`: Incluye los bancos de pruebas para verificar el funcionamiento de cada módulo y del procesador completo.
- `programs/`: Programas de prueba escritos en ensamblador RISC-V para validar la ejecución de instrucciones.

## Instrucciones Implementadas

El procesador soporta un subconjunto de instrucciones de la especificación RV32I, incluyendo:

- **Tipo R**: `ADD`, `SUB`, `AND`, `OR`, `XOR`, `SLL`, `SRL`, `SRA`
- **Tipo I**: `ADDI`, `ANDI`, `ORI`, `XORI`, `LW`, `LH`, `LB`
- **Tipo S**: `SW`, `SH`, `SB`
- **Tipo B**: `BEQ`, `BNE`
- **Tipo U**: `LUI`, `AUIPC`
- **Tipo J**: `JAL`

