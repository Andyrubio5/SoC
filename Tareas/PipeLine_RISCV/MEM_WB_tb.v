module MEM_WB_tb;

    reg clk = 0;
    reg reset;

    reg [31:0] ReadData_in;
    reg [31:0] ALUResult_in;
    reg [31:0] PC_plus4_in;
    reg [4:0] rd_in;
    reg RegWrite_in;
    reg [1:0] ResultSrc_in;

    wire [31:0] ReadData_out;
    wire [31:0] ALUResult_out;
    wire [31:0] PC_plus4_out;
    wire [4:0] rd_out;
    wire RegWrite_out;
    wire [1:0] ResultSrc_out;

    MEM_WB uut (
        .clk(clk),
        .reset(reset),
        .ReadData_in(ReadData_in),
        .ALUResult_in(ALUResult_in),
        .PC_plus4_in(PC_plus4_in),
        .rd_in(rd_in),
        .RegWrite_in(RegWrite_in),
        .ResultSrc_in(ResultSrc_in),
        .ReadData_out(ReadData_out),
        .ALUResult_out(ALUResult_out),
        .PC_plus4_out(PC_plus4_out),
        .rd_out(rd_out),
        .RegWrite_out(RegWrite_out),
        .ResultSrc_out(ResultSrc_out)
    );

    always #5 clk = ~clk;

    initial begin
        // Reset inicial
        reset = 1;
        #10;

        reset = 0;
        ReadData_in = 32'h12345678;
        ALUResult_in = 32'hABCD0001;
        PC_plus4_in = 32'h00000020;
        rd_in = 5'd5;
        RegWrite_in = 1;
        ResultSrc_in = 2'b01;
        #10;

        // Activar reset de nuevo
        reset = 1;
        #10;

        $stop;
    end

endmodule
