onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {=== FETCH/EXECUTE ===}
add wave -noupdate -radix hexadecimal /Single_Cycle_RISCV_tb/uut/pc
add wave -noupdate -radix hexadecimal /Single_Cycle_RISCV_tb/uut/instruction
add wave -noupdate -radix hexadecimal /Single_Cycle_RISCV_tb/uut/alu_result
add wave -noupdate -radix hexadecimal /Single_Cycle_RISCV_tb/uut/PcNext
add wave -noupdate -divider {=== CONTROL ===}
add wave -noupdate /Single_Cycle_RISCV_tb/uut/RegWrite
add wave -noupdate /Single_Cycle_RISCV_tb/uut/MemWrite
add wave -noupdate /Single_Cycle_RISCV_tb/uut/ALUSrc
add wave -noupdate /Single_Cycle_RISCV_tb/uut/ResultSrc
add wave -noupdate /Single_Cycle_RISCV_tb/uut/PCSrc
add wave -noupdate /Single_Cycle_RISCV_tb/uut/Zero
add wave -noupdate -radix binary /Single_Cycle_RISCV_tb/uut/imm_src
add wave -noupdate -radix binary /Single_Cycle_RISCV_tb/uut/ALUControl
add wave -noupdate -divider {=== ALU INPUTS ===}
add wave -noupdate -radix hexadecimal /Single_Cycle_RISCV_tb/uut/SrcA
add wave -noupdate -radix hexadecimal /Single_Cycle_RISCV_tb/uut/SrcB
add wave -noupdate -radix hexadecimal /Single_Cycle_RISCV_tb/uut/imm_extend
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {225750 ps}
