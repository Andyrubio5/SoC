`timescale 1ns / 1ps

module Single_Cycle_RISCV_tb;

    // Parámetros
    parameter WIDTH = 32;
    parameter CLK_PERIOD = 10; // 100MHz clock
    
    // Señales del testbench
    reg clk;
    reg rst;
    wire [WIDTH-1:0] pc_out;
    wire [WIDTH-1:0] alu_result;
    
    // Instancia del DUT (Device Under Test)
    Single_Cycle_RISCV #(
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .pc_out(pc_out),
        .alu_result(alu_result)
    );
    
    // Generación del clock
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // Proceso de estimulación
    initial begin
        // Inicialización de señales
        rst = 1;
        
        // Dump de ondas para visualización
        $dumpfile("single_cycle_riscv.vcd");
        $dumpvars(0, Single_Cycle_RISCV_tb);
        
        // Display de encabezados
        $display("=== Iniciando simulación del procesador RISC-V Single Cycle ===");
        $display("Tiempo\t| PC\t\t| ALU Result\t| Reset");
        $display("--------|---------------|---------------|------");
        
        // Reset inicial
        #(CLK_PERIOD * 2);
        rst = 0;
        $display("%0t\t| %h\t| %h\t| %b", $time, pc_out, alu_result, rst);
        
        // Ejecutar varias instrucciones
        repeat(20) begin
            @(posedge clk);
            #1; // Pequeño delay para estabilizar señales
            $display("%0t\t| %h\t| %h\t| %b", $time, pc_out, alu_result, rst);
        end
        
        // Test de reset durante ejecución
        $display("\n=== Test de Reset ===");
        rst = 1;
        #(CLK_PERIOD * 2);
        $display("%0t\t| %h\t| %h\t| %b", $time, pc_out, alu_result, rst);
        
        rst = 0;
        repeat(10) begin
            @(posedge clk);
            #1;
            $display("%0t\t| %h\t| %h\t| %b", $time, pc_out, alu_result, rst);
        end
        
        $display("\n=== Simulación completada ===");
        $finish;
    end
    
    // Monitor para detección de cambios importantes
    initial begin
        $monitor("Monitor - Tiempo: %0t, PC: %h, ALU: %h", $time, pc_out, alu_result);
    end
    
    // Verificación de funcionamiento básico
    always @(posedge clk) begin
        if (!rst) begin
            // Verificar que el PC incrementa correctamente (en múltiplos de 4)
            if (pc_out % 4 != 0) begin
                $display("ERROR: PC no alineado a 4 bytes en tiempo %0t: PC = %h", $time, pc_out);
            end
        end else begin
            // Verificar que el reset funciona
            if (pc_out != 0) begin
                $display("ERROR: PC no se resetea correctamente en tiempo %0t: PC = %h", $time, pc_out);
            end
        end
    end
    
    // Timeout de seguridad
    initial begin
        #10000; // 10 microsegundos
        $display("TIMEOUT: Simulación terminada por tiempo límite");
        $finish;
    end

endmodule