module IF_STAGE (

    input clk, rst, PCSrc,
    input [31:0] PC_branch, 
    output [31:0] PC, instruction

);

wire [31:0] pc_next, pc_plus_4;

assign pc_next = PC + 32'd4; 


// Instancia de Program Counter
ProgramCounter pc_inst (
    .clk(clk),
    .rst(rst),
    .pc_next(pc_next),
    .pc(PC)
);


// Instancia de Instruction Memory
InstructionMemory ins_memory (
    .Address(PC),
    .ReadData(instruction)
);

endmodule 
