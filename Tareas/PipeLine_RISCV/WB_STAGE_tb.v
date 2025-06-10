module WB_STAGE_tb;

    reg [1:0] ResultSrc;
    reg [31:0] ALUResult;
    reg [31:0] ReadData;
    reg [31:0] PC_plus4;
    reg [4:0] rd_in;
    reg RegWrite_in;

    wire [31:0] WriteData;
    wire RegWrite_out;
    wire [4:0] rd_out;

    WB_STAGE uut (
        .ResultSrc(ResultSrc),
        .ALUResult(ALUResult),
        .ReadData(ReadData),
        .PC_plus4(PC_plus4),
        .rd_in(rd_in),
        .RegWrite_in(RegWrite_in),
        .WriteData(WriteData),
        .RegWrite_out(RegWrite_out),
        .rd_out(rd_out)
    );

    initial begin
        $display("Inicio del test de WB_STAGE...");

        // Caso 1: Resultado de la ALU
        ResultSrc = 2'b00;
        ALUResult = 32'hAAAA0001;
        ReadData = 32'h00000000;
        PC_plus4 = 32'h00000000;
        rd_in = 5'd10;
        RegWrite_in = 1;
        #10;

        // Caso 2: Resultado de la memoria (lw)
        ResultSrc = 2'b01;
        ALUResult = 32'h00000000;
        ReadData = 32'h12345678;
        PC_plus4 = 32'h00000000;
        rd_in = 5'd11;
        RegWrite_in = 1;
        #10;

        // Caso 3: Resultado PC + 4 (jal)
        ResultSrc = 2'b10;
        ALUResult = 32'h00000000;
        ReadData = 32'h00000000;
        PC_plus4 = 32'h00000020;
        rd_in = 5'd1;
        RegWrite_in = 1;
        #10;

        // Caso 4: RegWrite = 0 (no debe escribirse aunque haya dato)
        ResultSrc = 2'b00;
        ALUResult = 32'hFFFFFFFF;
        RegWrite_in = 0;
        rd_in = 5'd5;
        #10;

        $stop;
    end

endmodule
