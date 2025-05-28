`timescale 1ns / 1ps

module Extend_tb;
    reg [31:7] extend_in;
    reg [1:0] ImmSrc;
    wire [31:0] ImmExt;
    
    // Instancia del módulo bajo prueba
    Extend uut (
        .extend_in(extend_in),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );
    
    initial begin
        $dumpfile("extend_wave.vcd");
        $dumpvars(0, Extend_tb);
        
        $display("=== Pruebas del módulo Extend ===");
        $display("Time\tImmSrc\textend_in\t\tImmExt\t\tTipo");
        $display("------------------------------------------------------------");
        
        // Test 1: I-type (ImmSrc = 00)
        // Ejemplo: ADDI con inmediato positivo
        extend_in = 25'h0123456; // bits [31:7] = 0x123456
        ImmSrc = 2'b00;
        #10;
        $display("%0t\t%b\t%h\t%h\tI-type (+)", $time, ImmSrc, extend_in, ImmExt);
        
        // Test 2: I-type con inmediato negativo
        extend_in = 25'h1FFF456; // bit 31 = 1 (negativo)
        ImmSrc = 2'b00;
        #10;
        $display("%0t\t%b\t%h\t%h\tI-type (-)", $time, ImmSrc, extend_in, ImmExt);
        
        // Test 3: S-type (ImmSrc = 01)
        // Ejemplo: SW con offset positivo
        extend_in = 25'h0123456; 
        ImmSrc = 2'b01;
        #10;
        $display("%0t\t%b\t%h\t%h\tS-type (+)", $time, ImmSrc, extend_in, ImmExt);
        
        // Test 4: S-type con offset negativo
        extend_in = 25'h1FFF456; 
        ImmSrc = 2'b01;
        #10;
        $display("%0t\t%b\t%h\t%h\tS-type (-)", $time, ImmSrc, extend_in, ImmExt);
        
        // Test 5: B-type (ImmSrc = 10)
        // Ejemplo: BEQ con offset positivo
        extend_in = 25'h0123456;
        ImmSrc = 2'b10;
        #10;
        $display("%0t\t%b\t%h\t%h\tB-type (+)", $time, ImmSrc, extend_in, ImmExt);
        
        // Test 6: B-type con offset negativo
        extend_in = 25'h1FFF456;
        ImmSrc = 2'b10;
        #10;
        $display("%0t\t%b\t%h\t%h\tB-type (-)", $time, ImmSrc, extend_in, ImmExt);
        
        // Test 7: J-type (ImmSrc = 11)
        // Ejemplo: JAL con offset positivo
        extend_in = 25'h0123456;
        ImmSrc = 2'b11;
        #10;
        $display("%0t\t%b\t%h\t%h\tJ-type (+)", $time, ImmSrc, extend_in, ImmExt);
        
        // Test 8: J-type con offset negativo
        extend_in = 25'h1FFF456;
        ImmSrc = 2'b11;
        #10;
        $display("%0t\t%b\t%h\t%h\tJ-type (-)", $time, ImmSrc, extend_in, ImmExt);
        
        $display("=== Fin de pruebas ===");
        $finish;
    end
    
    // Monitor para detectar cambios
    initial begin
        $monitor("Time=%0t: ImmSrc=%b, extend_in=%h, ImmExt=%h", 
                 $time, ImmSrc, extend_in, ImmExt);
    end
    
endmodule