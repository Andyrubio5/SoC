module ID_EX_tb;

    reg clk = 0;
    reg reset;

    reg [31:0] PC_in;
    reg [31:0] rs1_data_in;
    reg [31:0] rs2_data_in;
    reg [31:0] imm_ext_in;
    reg [4:0] rd_in, rs1_in, rs2_in;
    reg ALUSrc_in;
    reg [2:0] ALUControl_in;
    reg RegWrite_in;
    reg MemWrite_in;
    reg [1:0] ResultSrc_in;

    wire [31:0] PC_out, rs1_data_out, rs2_data_out, imm_ext_out;
    wire [4:0] rd_out, rs1_out, rs2_out;
    wire ALUSrc_out, RegWrite_out, MemWrite_out;
    wire [2:0] ALUControl_out;
    wire [1:0] ResultSrc_out;

    // Instancia del módulo
    ID_EX uut (
        .clk(clk),
        .reset(reset),
        .PC_in(PC_in),
        .rs1_data_in(rs1_data_in),
        .rs2_data_in(rs2_data_in),
        .imm_ext_in(imm_ext_in),
        .rd_in(rd_in),
        .rs1_in(rs1_in),
        .rs2_in(rs2_in),
        .ALUSrc_in(ALUSrc_in),
        .ALUControl_in(ALUControl_in),
        .RegWrite_in(RegWrite_in),
        .MemWrite_in(MemWrite_in),
        .ResultSrc_in(ResultSrc_in),
        .PC_out(PC_out),
        .rs1_data_out(rs1_data_out),
        .rs2_data_out(rs2_data_out),
        .imm_ext_out(imm_ext_out),
        .rd_out(rd_out),
        .rs1_out(rs1_out),
        .rs2_out(rs2_out),
        .ALUSrc_out(ALUSrc_out),
        .ALUControl_out(ALUControl_out),
        .RegWrite_out(RegWrite_out),
        .MemWrite_out(MemWrite_out),
        .ResultSrc_out(ResultSrc_out)
    );

    always #5 clk = ~clk;

    initial begin
        // Reset inicial
        reset = 1;
        #10;

        reset = 0;

        // Valores de prueba
        PC_in = 32'h00000010;
        rs1_data_in = 32'h0000000A;
        rs2_data_in = 32'h00000014;
        imm_ext_in = 32'h00000004;
        rd_in = 5'd3;
        rs1_in = 5'd1;
        rs2_in = 5'd2;
        ALUSrc_in = 1;
        ALUControl_in = 3'b000;
        RegWrite_in = 1;
        MemWrite_in = 0;
        ResultSrc_in = 2'b00;
        #10;

        // Reset de nuevo para probar limpieza
        reset = 1;
        #10;

        $stop;
    end
endmodule
