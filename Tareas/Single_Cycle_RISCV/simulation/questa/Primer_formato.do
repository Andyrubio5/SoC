onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Clock
add wave -noupdate /tb_main_decoder/clk
add wave -noupdate -divider {Intruction Number}
add wave -noupdate -radix decimal /tb_main_decoder/i
add wave -noupdate -divider Opcode
add wave -noupdate -radix binary /tb_main_decoder/op
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_main_decoder/RegWrite
add wave -noupdate /tb_main_decoder/ALUSrc
add wave -noupdate /tb_main_decoder/MemWrite
add wave -noupdate -radix binary /tb_main_decoder/ResultSrc
add wave -noupdate /tb_main_decoder/Branch
add wave -noupdate /tb_main_decoder/Jump
add wave -noupdate -radix binary /tb_main_decoder/ImmSrc
add wave -noupdate -divider ALUOp
add wave -noupdate -radix binary /tb_main_decoder/ALUOp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {214878 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 197
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
WaveRestoreZoom {189644 ps} {218279 ps}
