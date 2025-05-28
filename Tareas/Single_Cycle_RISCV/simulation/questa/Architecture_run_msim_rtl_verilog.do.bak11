transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV/Single_Cycle_RISCV.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV/register_file.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV/Extend.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV/data_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV/alu_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV/ControlUnit.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV/main_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV/InstructionMemory.v}

vlog -vlog01compat -work work +incdir+C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV {C:/Users/andyq/Documents/QuartusProjects/Architecture_code/SoC/Tareas/Single_Cycle_RISCV/Single_Cycle_RISCV_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  Single_Cycle_RISCV_tb

add wave *
view structure
view signals
run -all
