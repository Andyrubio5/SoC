onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Global
add wave -noupdate -radix hexadecimal /RISC_V_Pipeline_tb/clk
add wave -noupdate -radix hexadecimal /RISC_V_Pipeline_tb/reset
add wave -noupdate -divider IF_STAGE
add wave -noupdate -label PC_IF -radix hexadecimal /RISC_V_Pipeline_tb/uut/PC_IF
add wave -noupdate -label instruction_IF -radix hexadecimal /RISC_V_Pipeline_tb/uut/instruction_IF
add wave -noupdate -label PCSrc -radix hexadecimal /RISC_V_Pipeline_tb/uut/PCSrc
add wave -noupdate -divider {IF_ID Register}
add wave -noupdate -label PC_ID -radix hexadecimal /RISC_V_Pipeline_tb/uut/PC_ID
add wave -noupdate -label instruction_ID -radix hexadecimal /RISC_V_Pipeline_tb/uut/instruction_ID
add wave -noupdate -divider ID_STAGE
add wave -noupdate -label instruction_ID -radix hexadecimal /RISC_V_Pipeline_tb/uut/instruction_ID
add wave -noupdate -label rs1_ID -radix hexadecimal /RISC_V_Pipeline_tb/uut/rs1_ID
add wave -noupdate -label rs2_ID -radix hexadecimal /RISC_V_Pipeline_tb/uut/rs2_ID
add wave -noupdate -label rd_ID -radix hexadecimal /RISC_V_Pipeline_tb/uut/rd_ID
add wave -noupdate -label rs1_data_ID -radix hexadecimal /RISC_V_Pipeline_tb/uut/rs1_data_ID
add wave -noupdate -label rs2_data_ID -radix hexadecimal /RISC_V_Pipeline_tb/uut/rs2_data_ID
add wave -noupdate -label imm_ext_ID -radix hexadecimal /RISC_V_Pipeline_tb/uut/imm_ext_ID
add wave -noupdate -label ALUControl_ID -radix hexadecimal /RISC_V_Pipeline_tb/uut/ALUControl_ID
add wave -noupdate -divider {ID_EX Register}
add wave -noupdate -label instruction_ID_EX -radix hexadecimal /RISC_V_Pipeline_tb/uut/instruction_ID_EX
add wave -noupdate -label rs1_data_EX -radix hexadecimal /RISC_V_Pipeline_tb/uut/rs1_data_EX
add wave -noupdate -label rs2_data_EX -radix hexadecimal /RISC_V_Pipeline_tb/uut/rs2_data_EX
add wave -noupdate -label imm_ext_EX -radix hexadecimal /RISC_V_Pipeline_tb/uut/imm_ext_EX
add wave -noupdate -label rd_EX -radix hexadecimal /RISC_V_Pipeline_tb/uut/rd_EX
add wave -noupdate -label ALUSrc_EX -radix hexadecimal /RISC_V_Pipeline_tb/uut/ALUSrc_EX
add wave -noupdate -label ALUControl_EX -radix hexadecimal /RISC_V_Pipeline_tb/uut/ALUControl_EX
add wave -noupdate -divider EX_STAGE
add wave -noupdate -label instruction_EX -radix hexadecimal /RISC_V_Pipeline_tb/uut/instruction_ID_EX
add wave -noupdate -label ForwardA -radix hexadecimal /RISC_V_Pipeline_tb/uut/ForwardA
add wave -noupdate -label ForwardB -radix hexadecimal /RISC_V_Pipeline_tb/uut/ForwardB
add wave -noupdate -label ALUResult_EX -radix hexadecimal /RISC_V_Pipeline_tb/uut/ALUResult_EX
add wave -noupdate -label Zero_EX -radix hexadecimal /RISC_V_Pipeline_tb/uut/Zero_EX
add wave -noupdate -label rs2_final_EX -radix hexadecimal /RISC_V_Pipeline_tb/uut/rs2_final_EX
add wave -noupdate -divider {EX_MEM Register}
add wave -noupdate -label instruction_EX_MEM -radix hexadecimal /RISC_V_Pipeline_tb/uut/instruction_EX_MEM
add wave -noupdate -label ALUResult_MEM -radix hexadecimal /RISC_V_Pipeline_tb/uut/ALUResult_MEM
add wave -noupdate -label rs2_MEM -radix hexadecimal /RISC_V_Pipeline_tb/uut/rs2_MEM
add wave -noupdate -label rd_MEM -radix hexadecimal /RISC_V_Pipeline_tb/uut/rd_MEM
add wave -noupdate -label MemWrite_MEM -radix hexadecimal /RISC_V_Pipeline_tb/uut/MemWrite_MEM
add wave -noupdate -label RegWrite_MEM -radix hexadecimal /RISC_V_Pipeline_tb/uut/RegWrite_MEM
add wave -noupdate -divider MEM_STAGE
add wave -noupdate -label instruction_MEM -radix hexadecimal /RISC_V_Pipeline_tb/uut/instruction_EX_MEM
add wave -noupdate -label ReadData_MEM -radix hexadecimal /RISC_V_Pipeline_tb/uut/ReadData_MEM
add wave -noupdate -divider {MEM_WB Register}
add wave -noupdate -label instruction_MEM_WB -radix hexadecimal /RISC_V_Pipeline_tb/uut/instruction_MEM_WB
add wave -noupdate -label ALUResult_WB -radix hexadecimal /RISC_V_Pipeline_tb/uut/ALUResult_WB
add wave -noupdate -label PC_plus4_WB -radix hexadecimal /RISC_V_Pipeline_tb/uut/PC_plus4_WB
add wave -noupdate -label rd_WB -radix hexadecimal /RISC_V_Pipeline_tb/uut/rd_WB
add wave -noupdate -label RegWrite_WB -radix hexadecimal /RISC_V_Pipeline_tb/uut/RegWrite_WB
add wave -noupdate -divider WB_STAGE
add wave -noupdate -label instruction_WB -radix hexadecimal /RISC_V_Pipeline_tb/uut/instruction_MEM_WB
add wave -noupdate -label WriteData_WB -radix hexadecimal /RISC_V_Pipeline_tb/uut/WriteData_WB
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
WaveRestoreZoom {0 ps} {525 ps}
