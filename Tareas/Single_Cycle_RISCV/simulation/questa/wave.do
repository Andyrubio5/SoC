onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Fetch Stage}
add wave -noupdate -radix hexadecimal /Single_Cycle_RISCV_tb/uut/pc
add wave -noupdate -radix hexadecimal /Single_Cycle_RISCV_tb/uut/instruction
add wave -noupdate -divider {Control Unit}
add wave -noupdate -radix binary /Single_Cycle_RISCV_tb/uut/RegWrite
add wave -noupdate -radix binary /Single_Cycle_RISCV_tb/uut/MemWrite
add wave -noupdate -radix binary /Single_Cycle_RISCV_tb/uut/ALUSrc
add wave -noupdate -radix binary /Single_Cycle_RISCV_tb/uut/ResultSrc
add wave -noupdate -radix binary /Single_Cycle_RISCV_tb/uut/PCSrc
add wave -noupdate -radix binary /Single_Cycle_RISCV_tb/uut/imm_src
add wave -noupdate -divider {ALU & Execution}
add wave -noupdate -radix hexadecimal /Single_Cycle_RISCV_tb/uut/alu_result
add wave -noupdate -radix hexadecimal /Single_Cycle_RISCV_tb/uut/imm_extend
add wave -noupdate -divider {Next PC Calculation}
add wave -noupdate -radix hexadecimal /Single_Cycle_RISCV_tb/uut/PcNext
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
WaveRestoreZoom {0 ps} {1 ns}
