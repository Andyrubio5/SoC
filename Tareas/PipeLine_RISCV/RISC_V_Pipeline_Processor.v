module RISC_V_Pipeline_Processor (
    input clk,
    input reset
);

// =====================
// Señales entre etapas
// =====================

// Instructions
wire [31:0] PC_IF, instruction_IF;
wire [31:0] PC_ID, instruction_ID;
wire [31:0] instruction_ID_EX;
wire [31:0] instruction_EX_MEM;
wire [31:0] instruction_MEM_WB;


// ID → ID_EX
wire [31:0] rs1_data_ID, rs2_data_ID, imm_ext_ID;
wire [4:0] rs1_ID, rs2_ID, rd_ID;
wire ALUSrc_ID, RegWrite_ID, MemWrite_ID;
wire [2:0] ALUControl_ID;
wire [1:0] ResultSrc_ID;

// ID_EX → EX
wire [31:0] rs1_data_EX, rs2_data_EX, imm_ext_EX, PC_EX;
wire [4:0] rs1_EX, rs2_EX, rd_EX;
wire ALUSrc_EX, RegWrite_EX, MemWrite_EX;
wire [2:0] ALUControl_EX;
wire [1:0] ResultSrc_EX;

// EX → EX_MEM
wire [31:0] ALUResult_EX, rs2_final_EX;
wire Zero_EX;

// EX_MEM → MEM
wire [31:0] ALUResult_MEM, rs2_MEM;
wire [4:0] rd_MEM;
wire MemWrite_MEM, RegWrite_MEM;
wire [1:0] ResultSrc_MEM;

// MEM → MEM_WB
wire [31:0] ReadData_MEM;
wire [4:0] rd_WB;
wire RegWrite_WB;
wire [1:0] ResultSrc_WB;
wire [31:0] ALUResult_WB, PC_plus4_WB;

// Forwarding
wire [1:0] ForwardA, ForwardB;
wire [31:0] WriteData_WB;

// =====================
// Instancias de módulos (se llenan después)
// =====================

// =====================
// FETCH STAGE
// =====================

IF_STAGE fetch (
    .clk(clk),
    .reset(reset),
    .PCSrc(PCSrc),
    .imm_ext(imm_ext_ID),
    .PC_out(PC_IF),
    .instruction(instruction_IF)
);

// =====================
// IF/ID REGISTER
// =====================
IF_ID if_id_reg (
    .clk(clk),
    .reset(reset),
    .PC_in(PC_IF),
    .instruction_in(instruction_IF),
    .PC_out(PC_ID),
    .instruction_out(instruction_ID)
);

// =====================
// DECODE STAGE
// =====================
ID_STAGE decode (
    .clk(clk),
    .reset(reset),
    .instruction(instruction_ID),
    .PC(PC_ID),
    .Zero(Zero_EX), // Requiere ALU Zero para PCSrc
    .rs1(rs1_ID),
    .rs2(rs2_ID),
    .rd(rd_ID),
    .rs1_data(rs1_data_ID),
    .rs2_data(rs2_data_ID),
    .imm_ext(imm_ext_ID),
    .ALUControl(ALUControl_ID),
    .MemWrite(MemWrite_ID),
    .RegWrite(RegWrite_ID),
    .ALUSrc(ALUSrc_ID),
    .ResultSrc(ResultSrc_ID),
    .PCSrc(PCSrc)
);

// =====================
// ID/EX REGISTER
// =====================
ID_EX id_ex_reg (
    .clk(clk),
    .reset(reset),
    .rs1_data_in(rs1_data_ID),
    .rs2_data_in(rs2_data_ID),
    .imm_ext_in(imm_ext_ID),
    .PC_in(PC_ID),
    .rs1_in(rs1_ID),
    .rs2_in(rs2_ID),
    .rd_in(rd_ID),
    .ALUControl_in(ALUControl_ID),
    .ALUSrc_in(ALUSrc_ID),
    .RegWrite_in(RegWrite_ID),
    .MemWrite_in(MemWrite_ID),
    .ResultSrc_in(ResultSrc_ID),

    .rs1_data_out(rs1_data_EX),
    .rs2_data_out(rs2_data_EX),
    .imm_ext_out(imm_ext_EX),
    .PC_out(PC_EX),
    .rs1_out(rs1_EX),
    .rs2_out(rs2_EX),
    .rd_out(rd_EX),
    .ALUControl_out(ALUControl_EX),
    .ALUSrc_out(ALUSrc_EX),
    .RegWrite_out(RegWrite_EX),
    .MemWrite_out(MemWrite_EX),
    .ResultSrc_out(ResultSrc_EX),
    .instruction_in(instruction_ID),
    .instruction_out(instruction_ID_EX)

);

// =====================
// FORWARDING UNIT
// =====================
Forwarding_Unit forward_unit (
    .rs1_EX(rs1_EX),
    .rs2_EX(rs2_EX),
    .rd_MEM(rd_MEM),
    .rd_WB(rd_WB),
    .RegWrite_MEM(RegWrite_MEM),
    .RegWrite_WB(RegWrite_WB),
    .ForwardA(ForwardA),
    .ForwardB(ForwardB)
);

// =====================
// EXECUTE STAGE
// =====================
EX_STAGE execute (
    .PC(PC_EX),
    .rs1_data(rs1_data_EX),
    .rs2_data(rs2_data_EX),
    .imm_ext(imm_ext_EX),
    .rs1(rs1_EX),
    .rs2(rs2_EX),
    .ALUSrc(ALUSrc_EX),
    .ALUControl(ALUControl_EX),
    .ForwardA(ForwardA),
    .ForwardB(ForwardB),
    .ALUResult_MEM(ALUResult_MEM),
    .WriteData_WB(WriteData_WB),
    .Zero(Zero_EX),
    .ALUResult(ALUResult_EX),
    .rs2_final(rs2_final_EX)
);

// =====================
// EX/MEM REGISTER
// =====================
EX_MEM ex_mem_reg (
    .clk(clk),
    .reset(reset),
    .ALUResult_in(ALUResult_EX),
    .rs2_data_in(rs2_final_EX),
    .rd_in(rd_EX),
    .MemWrite_in(MemWrite_EX),
    .RegWrite_in(RegWrite_EX),
    .ResultSrc_in(ResultSrc_EX),
    .ALUResult_out(ALUResult_MEM),
    .rs2_data_out(rs2_MEM),
    .rd_out(rd_MEM),
    .MemWrite_out(MemWrite_MEM),
    .RegWrite_out(RegWrite_MEM),
    .ResultSrc_out(ResultSrc_MEM),
    .instruction_in(instruction_ID_EX),
    .instruction_out(instruction_EX_MEM)

);

// =====================
// MEMORY STAGE
// =====================
data_memory data_mem (
    .clk(clk),
    .WE(MemWrite_MEM),
    .A(ALUResult_MEM),
    .WD(rs2_MEM),
    .RD(ReadData_MEM)
);

// =====================
// MEM/WB REGISTER
// =====================
MEM_WB mem_wb_reg (
    .clk(clk),
    .reset(reset),
    .ReadData_in(ReadData_MEM),
    .ALUResult_in(ALUResult_MEM),
    .PC_plus4_in(PC_EX + 4), // suponemos PC+4 viene de EX
    .rd_in(rd_MEM),
    .RegWrite_in(RegWrite_MEM),
    .ResultSrc_in(ResultSrc_MEM),
    .ReadData_out(/* opcional */),
    .ALUResult_out(ALUResult_WB),
    .PC_plus4_out(PC_plus4_WB),
    .rd_out(rd_WB),
    .RegWrite_out(RegWrite_WB),
    .ResultSrc_out(ResultSrc_WB),
    .instruction_in(instruction_EX_MEM),
    .instruction_out(instruction_MEM_WB)

);

// =====================
// WRITEBACK STAGE
// =====================
WB_STAGE write_back (
    .ResultSrc(ResultSrc_WB),
    .ALUResult(ALUResult_WB),
    .ReadData(ReadData_MEM), // se puede usar también ReadData_WB
    .PC_plus4(PC_plus4_WB),
    .WriteData(WriteData_WB)
);


endmodule
