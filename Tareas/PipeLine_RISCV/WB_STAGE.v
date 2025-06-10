module WB_STAGE (
    input [1:0] ResultSrc,         // Selección del dato a escribir
    input [31:0] ALUResult,        // Resultado desde ALU
    input [31:0] ReadData,         // Dato leído desde memoria
    input [31:0] PC_plus4,         // PC + 4 (para instrucciones como jal)
    input [4:0] rd_in,             // Registro destino
    input RegWrite_in,             // Habilitación de escritura

    output [31:0] WriteData,       // Dato a escribir al banco de registros
    output RegWrite_out,           // Passthrough
    output [4:0] rd_out            // Passthrough
);

    // Multiplexor para seleccionar qué escribir
    assign WriteData = (ResultSrc == 2'b00) ? ALUResult  :
                       (ResultSrc == 2'b01) ? ReadData   :
                       (ResultSrc == 2'b10) ? PC_plus4   :
                       32'b0;

    assign rd_out = rd_in;
    assign RegWrite_out = RegWrite_in;

endmodule
