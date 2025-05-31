module ControlUnit(
    input [6:0] op,
    input [2:0] funct3,
    input funct7,
    input clk,
    input Zero,         // Zero flag input
    output MemWrite,    // Habilitación de escritura en memoria
    output ALUSrc,      // Selección de entrada ALU
    output RegWrite,    // Habilitación de escritura en registro
    output [1:0] ResultSrc, // Selección de fuente de resultado
    output [1:0] ImmSrc,    // Selección de tipo de inmediato
    output [2:0] ALUControl, // Control de operación ALU
    output PCSrc        // PCSrc output
);
    // Señales internas
    wire Branch;        // Branch signal
    wire Jump;          // Jump signal
    wire [1:0] ALUOp;   // ALUOp como señal interna (no como salida)
    
    // PCSrc logic - corregida para incluir Jump
    assign PCSrc = (Branch & Zero) | Jump; 
    
    // Instancia del Main Decoder
    main_decoder main_decoder_inst(
        .op(op),
        .clk(clk),
        .jump(Jump),        
        .branch(Branch), 
        .mem_write(MemWrite),
        .alu_src(ALUSrc),
        .reg_write(RegWrite),
        .result_src(ResultSrc),
        .imm_src(ImmSrc),
        .alu_op(ALUOp)      // ALUOp es generado por main_decoder
    );
    
    // Instancia del ALU Decoder
    alu_decoder alu_decoder_inst(
        .ALUOp(ALUOp),      // ALUOp es usado como entrada para alu_decoder
        .funct3(funct3),
        .op5(op[5]),        // bit 5 del opcode
        .funct7(funct7),    // bit 30 de funct7 (funct7[5])
        .ALUControl(ALUControl)
    );
    
endmodule