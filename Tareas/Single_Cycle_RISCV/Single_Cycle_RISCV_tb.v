`timescale 1ns / 1ps

module Single_Cycle_RISCV_tb;

    // Parámetros
    parameter WIDTH = 32;
    parameter CLK_PERIOD = 10;

    // Entradas
    reg clk;
    reg rst;

    // Salidas del procesador
    wire [WIDTH-1:0] pc_out;
    wire [WIDTH-1:0] alu_result;

    // Instanciar el procesador (ajusta el nombre si es necesario)
    Single_cycle_RISCV #(
        .WIDTH(WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .pc_out(pc_out),
        .alu_result(alu_result)
    );

    // Generación de reloj
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Bloque de prueba
    integer j;
    initial begin
        $display("\n===== Simulación del procesador RISC-V - Híbrido =====");

        // Inicialización
        rst = 1;
        #20;
        rst = 0;

        // Esperar algunos ciclos de ejecución
        #(CLK_PERIOD * 30);

        $display("\n==== Estado final de señales clave ====");
        $display("PC Final: 0x%h", pc_out);
        $display("Instruccion final: 0x%h", uut.instruction);
        $display("Resultado ALU: 0x%h", alu_result);
        $display("RegWrite: %b", uut.RegWrite);
        $display("MemWrite: %b", uut.MemWrite);

        // Dump de memoria de datos
        $display("\n==== Memoria de datos (primeros 64 bytes) ====");
        for (j = 0; j < 16; j = j + 1) begin
            $display("Data_mem[0x%03h] = 0x%08h", j, uut.data_mem.memory[j]);
        end

        $display("\n===== Simulación finalizada =====");
        $finish;
    end

    // Monitoreo en tiempo real
    initial begin
        $monitor("Tiempo=%0t | PC=0x%h | Inst=0x%h | ALU=0x%h | RegWrite=%b | MemWrite=%b",
            $time, pc_out, uut.instruction, alu_result, uut.RegWrite, uut.MemWrite);
    end

endmodule
