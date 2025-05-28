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


    always @(*) 
    begin
        RD1 = registers[A1];  // Lectura del registro A1
        RD2 = registers[A2];  // Lectura del registro A2
    end

    always@(posedge clk)
    begin
        if (WE3) begin
            registers[A3] <= WD3;  // Escritura en el registro A3
        end
    end


endmodule