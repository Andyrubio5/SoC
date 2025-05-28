module InstructionMemory #(parameter ADD = 8) (
    input [31:0] Address,
    output [31:0] ReadData
);
    // Memoria de instrucciones
    reg [31:0] ROM [(2**ADD) - 1:0];

    // inicializacion de la memoria de instrucciones
    initial begin
        $readmemh("instructions.hex", ROM);
    end

    // Lectura de la memoria de instrucciones
    assign ReadData = ROM[Address >> 2]; 

endmodule