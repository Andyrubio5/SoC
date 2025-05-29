module Single_Cycle_RISCV #(
    parameter WIDTH = 32
)(
    input clk,
    input rst,
    output [WIDTH-1:0] pc_out,
    output [WIDTH-1:0] alu_result
);

// Wire declarations
wire [WIDTH-1:0] pc_target;
wire [WIDTH-1:0] pc_plus_4;
wire PCSrc;
wire [WIDTH-1:0] PcNext;
wire [WIDTH-1:0] instruction;
wire [WIDTH-1:0] result;
wire [WIDTH-1:0] SrcA;
wire [WIDTH-1:0] RD2;
wire ALUSrc;
wire [WIDTH-1:0] imm_extend;
wire [WIDTH-1:0] SrcB;
wire [1:0] imm_src;
wire [2:0] ALUControl;
wire [1:0] ALUOp;
wire Zero;
wire MemWrite;
wire ResultSrc;
wire [WIDTH-1:0] ReadData;
wire RegWrite;

// Program Counter
reg [WIDTH-1:0] pc;

// Para detectar bucles (debugging)
reg [WIDTH-1:0] prev_pc, prev_pc2;

// PC Update
always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc <= 0;
        prev_pc <= 0;
        prev_pc2 <= 0;
    end else begin
        prev_pc2 <= prev_pc;
        prev_pc <= pc;
        pc <= PcNext;
    end
end

// Next PC logic - usando assign (más limpio)
assign PcNext = PCSrc ? pc_target : pc_plus_4;
assign pc_out = pc;

// Instruction Memory
InstructionMemory #(.ADD(8)) insmemory(
    .Address(pc),
    .ReadData(instruction)
);

// Register File
register_file rf (
    .clk(clk),
    .A1(instruction[19:15]),
    .A2(instruction[24:20]),
    .A3(instruction[11:7]),
    .WE3(RegWrite),
    .WD3(result),
    .RD1(SrcA),
    .RD2(RD2)
);

// Immediate Extension
assign SrcB = ALUSrc ? imm_extend : RD2;

Extend extend (
    .extend_in(instruction[31:7]),
    .ImmSrc(imm_src),
    .ImmExt(imm_extend)
);

// ALU
ALU alu (
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUControl(ALUControl),
    .ALUResult(alu_result),
    .Zero(Zero)
);

// Data Memory
data_memory data_mem (
    .clk(clk),
    .WE(MemWrite),
    .A(alu_result),
    .WD(RD2),
    .RD(ReadData)
);

// Result Multiplexer
assign result = ResultSrc ? ReadData : alu_result;

// Control Unit
ControlUnit control_unit (
    .op(instruction[6:0]),
    .funct3(instruction[14:12]),
    .funct7(instruction[30]),
    .clk(clk),
    .Zero(Zero),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .ImmSrc(imm_src),
    .ALUControl(ALUControl)
);

// PC calculations
assign pc_plus_4 = pc + 4;
assign pc_target = pc + imm_extend;

endmodule