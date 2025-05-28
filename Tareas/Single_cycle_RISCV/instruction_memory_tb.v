`timescale 1ns / 1ps
module instruction_memory_tb;
    reg [31:0] pc;
    wire [31:0] instruction;

    instruction_memory uut (
        .pc(pc),
        .instruction(instruction)
    );

    initial begin
        $dumpfile("imem_wave.vcd");
        $dumpvars(0, instruction_memory_tb);
        
        pc = 0;
        #10;
        
        // Verifica las primeras 4 instrucciones
        $display("PC=%h -> Instr=%h", pc, instruction);
        pc = pc + 4;
        #10;
        
        $display("PC=%h -> Instr=%h", pc, instruction);
        pc = pc + 4;
        #10;
        
        $display("PC=%h -> Instr=%h", pc, instruction);
        pc = pc + 4;
        #10;
        
        $display("PC=%h -> Instr=%h", pc, instruction);
        $finish;
    end
endmodule