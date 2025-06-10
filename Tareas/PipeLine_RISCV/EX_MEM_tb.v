module EX_MEM_tb;

    reg clk = 0;
    reg reset;

    reg [31:0] ALUResult_in;
    reg [31:0] rs2_data_in;
    reg [4:0] rd_in;
    reg MemWrite_in;
    reg RegWrite_in;
    reg [1:0] ResultSrc_in;

    wire [31:0] ALUResult_out;
    wire [31:0] rs2_data_out;
    wire [4:0] rd_out;
    wire MemWrite_out;
    wire RegWrite_out;
    wire [1:0] ResultSrc_out;

    // Instanciar el módulo bajo prueba
    EX_MEM uut (
        .clk(clk),
        .reset(reset),
        .ALUResult_in(ALUResult_in),
        .rs2_data_in(rs2_data_in),
        .rd_in(rd_in),
        .MemWrite_in(MemWrite_in),
        .RegWrite_in(RegWrite_in),
        .ResultSrc_in(ResultSrc_in),
        .ALUResult_out(ALUResult_out),
        .rs2_data_out(rs2_data_out),
        .rd_out(rd_out),
        .MemWrite_out(MemWrite_out),
        .RegWrite_out(RegWrite_out),
        .ResultSrc_out(ResultSrc_out)
    );

    always #5 clk = ~clk;

    initial begin
        // Ciclo 0: Reset
        reset = 1;
        ALUResult_in = 32'h00000000;
        rs2_data_in = 32'h00000000;
        rd_in = 5'd0;
        MemWrite_in = 0;
        RegWrite_in = 0;
        ResultSrc_in = 2'b00;
        #10;

        // Ciclo 1: Datos válidos
        reset = 0;
        ALUResult_in = 32'hDEADBEEF;
        rs2_data_in = 32'hCAFEBABE;
        rd_in = 5'd10;
        MemWrite_in = 1;
        RegWrite_in = 1;
        ResultSrc_in = 2'b01;
        #10;

        // Ciclo 2: Reset nuevamente
        reset = 1;
        #10;

        $stop;
    end
endmodule
