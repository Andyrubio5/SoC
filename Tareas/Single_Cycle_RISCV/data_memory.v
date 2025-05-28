module data_memory (
    input [31:0] A,         // Dirección de acceso
    input [31:0] WD,        // Dato a escribir
    input clk,              // Reloj
    input WE,               // Write Enable
    output reg [31:0] RD    // Dato leído
);

    // Memoria de 1024 palabras de 32 bits (4KB)
    reg [31:0] memory [0:1023];

    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1)
            memory[i] = 32'b0;
    end

    // Escritura sincrónica: solo si WE está activo
    always @(posedge clk) begin
        if (WE && A[11:2] < 1024) begin
            memory[A[11:2]] <= WD; // acceso alineado a palabra (4 bytes)
        end
    end

    // Lectura combinacional con protección de rango
    always @(*) begin
        if (A[11:2] < 1024)
            RD = memory[A[11:2]];
        else
            RD = 32'b0; // valor por defecto si la dirección es inválida
    end

endmodule
