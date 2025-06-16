transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/RISC_V_Pipeline_Processor.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/Forwarding_Unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/MEM_WB.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/EX_MEM.V}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/ID_EX.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/IF_ID.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/WB_STAGE.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/EX_STAGE.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/ID_STAGE.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/register_file.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/Extend.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/data_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/alu_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/ControlUnit.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/main_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/IF_STAGE.v}

vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/PipeLine_RISCV/RISC_V_Pipeline_Processor_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  RISC_V_Pipeline_tb

add wave *
view structure
view signals
run -all
