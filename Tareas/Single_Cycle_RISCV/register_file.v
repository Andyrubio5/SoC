// Descripción: Módulo de archivo de registros para un procesador RISC-V simple

module register_file (
    input clk,            // Reloj del sistema
    input [4:0] A1,       // Dirección de lectura 1 (RD1)
    input [4:0] A2,       // Dirección de lectura 2 (RD2)
    input [4:0] A3,       // Dirección de escritura (WD3)
    input WE3,            // Enable de escritura
    input [31:0] WD3,     // Dato a escribir
    output reg [31:0] RD1,    // Dato leído 1
    output reg [31:0] RD2     // Dato leído 2
);

    // Banco de 32 registros de 32 bits
    reg [31:0] registers [31:0];
	 
always @(posedge clk) begin
    if (WE3) begin
    end
end

// Inicialización y manejo de R0
integer i; // Declarar la variable fuera del bucle

initial begin
    for (i = 0; i < 32; i = i + 1) begin
        registers[i] = 32'b0;
    end
end

always @(posedge clk) begin
    if (WE3 && A3 != 0) begin  // No escribir en R0
        registers[A3] <= WD3;
    end
end

always @(*) begin
    RD1 = (A1 == 5'b00000) ? 32'b0 : registers[A1];  // R0 siempre 0
    RD2 = (A2 == 5'b00000) ? 32'b0 : registers[A2];  // R0 siempre 0
end


endmodule