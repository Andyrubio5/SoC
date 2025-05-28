`timescale 1ns / 1ps

module InstructionMemory_tb;

    // Señales
    reg [31:0] Address;
    wire [31:0] ReadData;

    // Instancia del módulo de memoria de instrucciones
    InstructionMemory #(.ADD(8)) uut (
        .Address(Address),
        .ReadData(ReadData)
    );

    // Test
    integer i;
    initial begin
        $display("==== Test de InstructionMemory ====");

        // Leer 10 direcciones distintas
        for (i = 0; i < 21; i = i + 1) begin
            Address = i * 4;  // acceso alineado a palabra
            #5;
            $display("Address = 0x%h | Instruction = 0x%08h", Address, ReadData);
        end

        $display("==== Fin del test ====");
        $finish;
    end

endmodule
