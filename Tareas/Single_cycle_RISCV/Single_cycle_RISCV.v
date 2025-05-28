module Single_cycle_RISCV #(
    parameter WIDTH = 32
)(
    input  wire clk,
    input  wire rst,  // Reset activo alto
    output wire [WIDTH-1:0] pc_out,
    output wire [WIDTH-1:0] alu_result
);

// Wires declarations (igual que antes)
wire [WIDTH-1:0] pc_target, pc_plus_4, PcNext;
wire PCSrc;
wire [WIDTH-1:0] instruction, result, SrcA, RD2;
wire ALUSrc;
wire [WIDTH-1:0] imm_extend, SrcB, ReadData;
wire [1:0] imm_src;
wire [2:0] ALUControl;
wire [1:0] ALUOp;
wire Zero, MemWrite, ResultSrc, RegWrite;

// Program Counter con reset
reg [WIDTH-1:0] pc;
always @(posedge clk or posedge rst) begin
    if (rst) pc <= 0;
    else pc <= PcNext;
end

// Instruction Memory (verifica que pc esté alineado a 4 bytes)
instruction_memory insmemory(
    .pc(pc),
    .instruction(instruction)
);

// Debug: Monitorear instrucciones
initial begin
    $monitor("PC=%h Instr=%h", pc, instruction);
end

// Resto del datapath (igual que antes)
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

Extend extend (
    .extend_in(instruction[31:7]),
    .ImmSrc(imm_src),
    .ImmExt(imm_extend)
);

ALU alu (
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUControl(ALUControl),
    .ALUResult(alu_result),
    .Zero(Zero)
);

data_memory data_mem (
    .clk(clk),
    .WE(MemWrite),
    .A(alu_result),
    .WD(RD2),
    .RD(ReadData)
);

// Control Unit (sin clock!)
ControlUnit control_unit (
    .op(instruction[6:0]),
    .funct3(instruction[14:12]),
    .funct7(instruction[30]),
    .Zero(Zero),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .ImmSrc(imm_src),
    .ALUControl(ALUControl)
);

// Asignaciones continuas
assign result = ResultSrc ? ReadData : alu_result;
assign pc_plus_4 = pc + 4;
assign pc_target = pc + imm_extend;
assign PcNext = PCSrc ? pc_target : pc_plus_4;
assign pc_out = pc;
assign SrcB = ALUSrc ? imm_extend : RD2;

endmodule