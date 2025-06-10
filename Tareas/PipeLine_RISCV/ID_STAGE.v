module ID_STAGE(
    input clk,
    input reset,
    input [31:0] instruction,
    input [31:0] PC,
    input Zero, // desde la ALU para control

    output [4:0] rs1,
    output [4:0] rs2,
    output [4:0] rd,
    output [31:0] rs1_data,
    output [31:0] rs2_data,
    output [31:0] imm_ext,
    output [2:0] ALUControl,
    output MemWrite,
    output RegWrite,
    output ALUSrc,
    output [1:0] ResultSrc,
    output PCSrc
);

    wire [6:0] opcode;
    wire [2:0] funct3;
    wire funct7bit;
    wire [1:0] ImmSrc;

    assign opcode = instruction[6:0];
    assign rd     = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1    = instruction[19:15];
    assign rs2    = instruction[24:20];
    assign funct7bit = instruction[30];

    register_file rf (
        .clk(clk),
        .A1(rs1),
        .A2(rs2),
        .A3(5'b0),       // sin escritura aquí
        .WE3(1'b0),
        .WD3(32'b0),
        .RD1(rs1_data),
        .RD2(rs2_data)
    );

    ControlUnit CU (
        .op(opcode),
        .funct3(funct3),
        .funct7(funct7bit),
        .clk(clk),
        .Zero(Zero),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ResultSrc(ResultSrc),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl),
        .PCSrc(PCSrc)
    );

    Extend EXT (
        .extend_in(instruction[31:7]),
        .ImmSrc(ImmSrc),
        .ImmExt(imm_ext)
    );

endmodule
