module MEM_STAGE_tb;

    reg clk = 0;
    reg MemWrite;
    reg [1:0] ResultSrc;
    reg [31:0] ALUResult;
    reg [31:0] rs2_data;
    reg [4:0] rd_in;

    wire [31:0] ReadData;
    wire [31:0] ALUResult_out;
    wire [4:0] rd_out;

    // Instanciar el módulo bajo prueba
    MEM_STAGE uut (
        .clk(clk),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .ALUResult(ALUResult),
        .rs2_data(rs2_data),
        .rd_in(rd_in),
        .ReadData(ReadData),
        .ALUResult_out(ALUResult_out),
        .rd_out(rd_out)
    );

    always #5 clk = ~clk;

    initial begin
        $display("Inicio del test de MEM_STAGE...");

        // Caso 1: Escritura (sw x2, 0(x1)) → escribir 0xABCD1234 en la dirección 20
        MemWrite = 1;
        ALUResult = 32'd20;
        rs2_data = 32'hABCD1234;
        rd_in = 5'd0;          // no se usa
        #10;

        // Caso 2: Lectura (lw x5, 0(x1)) → leer desde dirección 20 (debe dar 0xABCD1234)
        MemWrite = 0;
        ALUResult = 32'd20;
        rs2_data = 32'b0;
        rd_in = 5'd5;
        #10;

        $stop;
    end

endmodule
