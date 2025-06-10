module EX_STAGE (
    input [31:0] rs1_data,       // Primer operando de la ALU
    input [31:0] rs2_data,       // Segundo operando si ALUSrc = 0
    input [31:0] imm_ext,        // Segundo operando si ALUSrc = 1
    input [2:0] ALUControl,      // Señal de operación ALU
    input ALUSrc,                // Selección de operando B
    input [4:0] rd_in,           // Registro destino (passthrough)
    input [31:0] PC_in,          // Passthrough opcional
    input [31:0] instruction,    // Passthrough opcional

    output [31:0] ALUResult,     // Resultado de la ALU
    output Zero,                 // Bandera para branch
    output [31:0] rs2_data_out,  // Passthrough para etapa MEM
    output [4:0] rd_out,         // Passthrough hacia WB
    output [31:0] PC_out,        // Passthrough si se usa
    output [31:0] instruction_out
);

    wire [31:0] SrcB;

    assign SrcB = (ALUSrc) ? imm_ext : rs2_data;

    ALU alu_unit (
        .SrcA(rs1_data),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .Zero(Zero),
        .ALUResult(ALUResult)
    );

    // Passthroughs
    assign rs2_data_out = rs2_data;
    assign rd_out = rd_in;
    assign PC_out = PC_in;
    assign instruction_out = instruction;

endmodule
