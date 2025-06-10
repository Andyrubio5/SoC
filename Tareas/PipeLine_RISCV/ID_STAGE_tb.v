module ID_STAGE_tb;
    reg clk = 0;
    reg reset = 0;
    reg [31:0] instruction;
    reg [31:0] PC = 32'h00000000;
    reg Zero = 0;

    wire [4:0] rs1, rs2, rd;
    wire [31:0] rs1_data, rs2_data, imm_ext;
    wire [2:0] ALUControl;
    wire MemWrite, RegWrite, ALUSrc, PCSrc;
    wire [1:0] ResultSrc;

    ID_STAGE uut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .PC(PC),
        .Zero(Zero),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .imm_ext(imm_ext),
        .ALUControl(ALUControl),
        .MemWrite(MemWrite),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .ResultSrc(ResultSrc),
        .PCSrc(PCSrc)
    );

    always #5 clk = ~clk;

initial begin
    // Inicializar registros
    uut.rf.registers[1] = 32'd10;  // x1
    uut.rf.registers[2] = 32'd20;  // x2
	 

    // Instrucción 1: addi x1, x0, 5
    PC = 0;
    instruction = 32'h00500093;
    #10;

    // Instrucción 2: add x3, x1, x2
    PC = 4;
    instruction = 32'h002081b3;
    #10;

    // Instrucción 3: sw x2, 0(x1)
    PC = 8;
    instruction = 32'h0020a023;
    #10;
	 
	 // Instrucción 4: lw x5, 0(x1)
	 PC = 12;
	 instruction = 32'h0000a283;
	 #10;


    $stop;
end

endmodule
