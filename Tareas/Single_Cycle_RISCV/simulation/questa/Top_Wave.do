onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Clock
add wave -noupdate /Single_Cycle_RISCV_tb/clk
add wave -noupdate /Single_Cycle_RISCV_tb/rst
add wave -noupdate -divider Instruccion_PC
add wave -noupdate /Single_Cycle_RISCV_tb/dut/instruction
add wave -noupdate /Single_Cycle_RISCV_tb/dut/pc
add wave -noupdate -radix binary {/Single_Cycle_RISCV_tb/dut/instruction[6:0]}
add wave -noupdate -divider SeÃ±ales_de_control
add wave -noupdate /Single_Cycle_RISCV_tb/dut/RegWrite
add wave -noupdate /Single_Cycle_RISCV_tb/dut/ALUSrc
add wave -noupdate /Single_Cycle_RISCV_tb/dut/MemWrite
add wave -noupdate /Single_Cycle_RISCV_tb/dut/ResultSrc
add wave -noupdate /Single_Cycle_RISCV_tb/dut/PCSrc
add wave -noupdate -divider Extension_Inmediatos
add wave -noupdate -radix binary /Single_Cycle_RISCV_tb/dut/imm_src
add wave -noupdate /Single_Cycle_RISCV_tb/dut/imm_extend
add wave -noupdate -divider Registros
add wave -noupdate /Single_Cycle_RISCV_tb/dut/SrcA
add wave -noupdate /Single_Cycle_RISCV_tb/dut/SrcB
add wave -noupdate -divider ALU
add wave -noupdate /Single_Cycle_RISCV_tb/dut/alu_result
add wave -noupdate /Single_Cycle_RISCV_tb/dut/Zero
add wave -noupdate -radix binary /Single_Cycle_RISCV_tb/dut/ALUControl
add wave -noupdate -divider Memoria_de_Datos
add wave -noupdate /Single_Cycle_RISCV_tb/dut/ReadData
add wave -noupdate -radix hexadecimal /Single_Cycle_RISCV_tb/dut/data_mem/Data_mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40467 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 292
configure wave -valuecolwidth 112
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {89482 ps}
