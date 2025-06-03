`timescale 1ns / 1ps

module data_memory_tb();

    parameter CLK_PERIOD = 10;
    reg [31:0] A, WD;
    reg clk, WE;
    wire [31:0] RD;

    data_memory uut (.A(A), .WD(WD), .clk(clk), .WE(WE), .RD(RD));

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    initial begin
        // Inicializacion
        A = 0; WD = 0; WE = 0;
        #100;
        
        // Test 1: Escritura y lectura basica
        $display("\nTest 1: Escritura y lectura basica");
        A = 32'h4; WD = 32'h12345678; WE = 1;
        #CLK_PERIOD;
        WE = 0;
        if (RD === 32'h12345678)
            $display("  PASS: Lectura correcta (0x%h)", RD);
        else
            $display("  FAIL: Esperaba 0x12345678, obtuvo 0x%h", RD);
        
        // Test 2: Multiples escrituras
        $display("\nTest 2: Multiples escrituras");
        A = 32'h8; WD = 32'hABCDEF01; WE = 1;
        #CLK_PERIOD;
        A = 32'hC; WD = 32'h55AA55AA;
        #CLK_PERIOD;
        WE = 0;
        
        A = 32'h8; #1;
        if (RD === 32'hABCDEF01)
            $display("  PASS: Dato en 0x8 correcto (0x%h)", RD);
            
        A = 32'hC; #1;
        if (RD === 32'h55AA55AA)
            $display("  PASS: Dato en 0xC correcto (0x%h)", RD);
        
        // Test 3: Lectura de direccion no escrita
        $display("\nTest 3: Lectura de direccion no escrita");
        A = 32'h10; #1;
        if (RD === 32'h0)
            $display("  PASS: Dato no escrito es 0 (0x%h)", RD);
        
        // Test 4: Comportamiento en flanco de reloj
        $display("\nTest 4: Comportamiento en flanco de reloj");
        A = 32'h14; WD = 32'hDEADBEEF; WE = 1;
        #(CLK_PERIOD-1);
        if (RD !== 32'hDEADBEEF)
            $display("  PASS: Dato no cambia antes del flanco");
        else
            $display("  FAIL: Dato cambio antes del flanco");
        
        #1; // Flanco de reloj
        #(CLK_PERIOD-1);
        if (RD === 32'hDEADBEEF)
            $display("  PASS: Dato actualizado despues del flanco");
        
        // Test 5: Cambio de direccion
        $display("\nTest 5: Cambio de direccion");
        A = 32'h8; #1;
        if (RD === 32'hABCDEF01)
            $display("  PASS: Lectura inmediata correcta");
        
        A = 32'hC; #1;
        if (RD === 32'h55AA55AA)
            $display("  PASS: Cambio de direccion correcto");
        
        $display("\nSimulacion completada");
        $finish;
    end
endmodule