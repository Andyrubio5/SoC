module Single_cycle_RISCV #(
    parameter WIDTH = 32
)(
    input clk,                    // Clock signal
	 input rst,
    output [WIDTH-1:0] pc_out,     // Program counter output
    output [WIDTH-1:0] alu_result  // ALU result output	
);

// Wire declarations
wire [WIDTH-1:0] pc_target;          // Target address for branch or jump
wire [WIDTH-1:0] pc_plus_4;          // PC + 4 for next instruction
wire PCSrc;                          // PC source control
wire [WIDTH-1:0] PcNext;            // Next PC value
wire [WIDTH-1:0] instruction;       // Instruction fetched from memory
wire [WIDTH-1:0] result;            // Result for register writeback
wire [WIDTH-1:0] SrcA;              // ALU source A
wire [WIDTH-1:0] RD2;               // Register data 2
wire ALUSrc;                        // ALU source control
wire [WIDTH-1:0] imm_extend;        // Extended immediate
wire [WIDTH-1:0] SrcB;              // ALU source B
wire [1:0] imm_src;                 // Immediate source control
wire [2:0] ALUControl;              // ALU control signals
wire [1:0] ALUOp;                   // ALU operation
wire Zero;                          // Zero flag from ALU
wire MemWrite;                      // Memory write control
wire ResultSrc;                     // Result source control
wire [WIDTH-1:0] ReadData;          // Data read from memory
wire RegWrite;                      // Register write control

// Program Counter
reg [WIDTH-1:0] pc;

// PC Update
always @(posedge clk) begin
    pc <= PcNext;
end

// Next PC logic
assign PcNext = PCSrc ? pc_target : pc_plus_4;
assign pc_out = pc;

// Instruction Memory
InstructionMemory insmemory(
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
    .ALUControl(ALUControl),  // Now only driven by Control Unit
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
    .clk(clk),              // Add missing clk connection
    .Zero(Zero),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .ImmSrc(imm_src),
    .ALUControl(ALUControl)  // Remove extra comma
);

// PC calculations
assign pc_plus_4 = pc + 4;
assign pc_target = pc + imm_extend;

endmodule
