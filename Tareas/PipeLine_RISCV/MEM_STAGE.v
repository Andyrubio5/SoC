module MEM_STAGE (
    input clk,
    input MemWrite,                     // Control de escritura
    input [1:0] ResultSrc,              // Para determinar si usar ReadData en WB
    input [31:0] ALUResult,             // Dirección (o resultado)
    input [31:0] rs2_data,              // Dato a escribir si es sw
    input [4:0] rd_in,                  // Registro destino

    output [31:0] ReadData,             // Dato leído si es lw
    output [31:0] ALUResult_out,        // Resultado de ALU para passthrough
    output [4:0] rd_out                 // rd passthrough
);

    // Instancia de la memoria
    data_memory mem (
        .clk(clk),
        .WE(MemWrite),
        .A(ALUResult),
        .WD(rs2_data),
        .RD(ReadData)
    );

    // Passthroughs
    assign ALUResult_out = ALUResult;
    assign rd_out = rd_in;

endmodule
