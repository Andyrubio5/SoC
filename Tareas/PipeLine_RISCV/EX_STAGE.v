module EX_STAGE (
    input [31:0] PC,
    input [31:0] rs1_data,
    input [31:0] rs2_data,
    input [31:0] imm_ext,
    input [4:0] rs1,
    input [4:0] rs2,

    input ALUSrc,
    input [2:0] ALUControl,
    input [1:0] ForwardA,
    input [1:0] ForwardB,
    input [31:0] ALUResult_MEM,
    input [31:0] WriteData_WB,

    output Zero,
    output [31:0] ALUResult,
    output [31:0] rs2_final
);

    wire [31:0] SrcA, SrcB, ALU_in_B;

    // ===== Multiplexor SrcA =====
    assign SrcA = (ForwardA == 2'b00) ? rs1_data :
                  (ForwardA == 2'b01) ? ALUResult_MEM :
                  (ForwardA == 2'b10) ? WriteData_WB :
                  32'b0;

    // ===== Multiplexor rs2 =====
    assign rs2_final = (ForwardB == 2'b00) ? rs2_data :
                       (ForwardB == 2'b01) ? ALUResult_MEM :
                       (ForwardB == 2'b10) ? WriteData_WB :
                       32'b0;

    // ===== ALU second operand =====
    assign SrcB = ALUSrc ? imm_ext : rs2_final;

    // ===== ALU Module =====
    ALU alu (
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .Zero(Zero),
        .ALUResult(ALUResult)
    );

endmodule
