module EX_STAGE_tb;

    reg [31:0] PC;
    reg [31:0] rs1_data;
    reg [31:0] rs2_data;
    reg [31:0] imm_ext;
    reg [4:0] rs1, rs2;

    reg ALUSrc;
    reg [2:0] ALUControl;
    reg [1:0] ForwardA, ForwardB;
    reg [31:0] ALUResult_MEM, WriteData_WB;

    wire Zero;
    wire [31:0] ALUResult;
    wire [31:0] rs2_final;

    EX_STAGE uut (
        .PC(PC),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .imm_ext(imm_ext),
        .rs1(rs1),
        .rs2(rs2),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB),
        .ALUResult_MEM(ALUResult_MEM),
        .WriteData_WB(WriteData_WB),
        .Zero(Zero),
        .ALUResult(ALUResult),
        .rs2_final(rs2_final)
    );

    initial begin
        // ========== Caso 1: Normal sin forwarding ==========
        rs1_data = 32'h0000000A;  // 10
        rs2_data = 32'h00000005;  // 5
        imm_ext = 32'h00000003;   // 3
        ALUResult_MEM = 32'hFFFFFFFF;
        WriteData_WB = 32'h12345678;
        ForwardA = 2'b00;
        ForwardB = 2'b00;
        ALUSrc = 0;
        ALUControl = 3'b000; // ADD
        #10;

        // ========== Caso 2: ForwardA desde MEM ==========
        ForwardA = 2'b01;
        ALUResult_MEM = 32'h00000020;
        #10;

        // ========== Caso 3: ForwardB desde WB ==========
        ForwardA = 2'b00;
        ForwardB = 2'b10;
        WriteData_WB = 32'h00000004;
        #10;

        // ========== Caso 4: ALUSrc activo con immediate ==========
        ForwardB = 2'b00;
        ALUSrc = 1;
        imm_ext = 32'h00000002;
        #10;

        $stop;
    end

endmodule
