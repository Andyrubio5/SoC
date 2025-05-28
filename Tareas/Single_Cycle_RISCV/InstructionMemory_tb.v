`timescale 1ns / 1ps

module InstructionMemory_tb;
    // Parámetros del testbench
    parameter ADD = 8; // Mismo parámetro que el módulo
    
    // Señales del testbench
    reg [31:0] Address;
    wire [31:0] ReadData;
    integer i;
    
    // Instancia del módulo bajo prueba
    InstructionMemory #(.ADD(ADD)) uut (
        .Address(Address),
        .ReadData(ReadData)
    );
    
    initial begin
        $dumpfile("instruction_memory_wave.vcd");
        $dumpvars(0, InstructionMemory_tb);
        
        // Esperar a que la memoria se inicialice
        #5;
        
        $display("=== Prueba del módulo InstructionMemory ===");
        $display("Parámetro ADD = %0d (Memoria de %0d palabras)", ADD, 2**ADD);
        $display("Time\tAddress\t\tAddr>>2\tReadData\tHex");
        $display("-------------------------------------------------------");
        
        // Test 1: Direcciones alineadas (múltiplos de 4)
        $display("\n--- Prueba 1: Direcciones alineadas ---");
        for (i = 0; i < 20; i = i + 1) begin
            Address = i * 4; // Direcciones: 0, 4, 8, 12, 16, ...
            #10;
            $display("%0t\t%8h\t%3d\t%8h\t%h", 
                     $time, Address, Address>>2, ReadData, ReadData);
        end
        
        // Test 2: Direcciones específicas importantes
        $display("\n--- Prueba 2: Direcciones específicas ---");
        
        // Dirección 0 (primera instrucción)
        Address = 32'h00000000;
        #10;
        $display("PC=0x%h -> Instrucción=0x%h", Address, ReadData);
        
        // Dirección 4 (segunda instrucción)
        Address = 32'h00000004;
        #10;
        $display("PC=0x%h -> Instrucción=0x%h", Address, ReadData);
        
        // Dirección del medio
        Address = 32'h00000040; // Dirección 64 decimal
        #10;
        $display("PC=0x%h -> Instrucción=0x%h", Address, ReadData);
        
        // Última dirección válida
        Address = (2**ADD - 1) * 4;
        #10;
        $display("PC=0x%h -> Instrucción=0x%h (última dirección)", Address, ReadData);
        
        // Test 3: Verificar el comportamiento del shift
        $display("\n--- Prueba 3: Verificación del desplazamiento >>2 ---");
        Address = 32'h00000000; #10;
        $display("Address=0x%h -> Index=%0d -> Data=0x%h", Address, Address>>2, ReadData);
        
        Address = 32'h00000004; #10;
        $display("Address=0x%h -> Index=%0d -> Data=0x%h", Address, Address>>2, ReadData);
        
        Address = 32'h00000008; #10;
        $display("Address=0x%h -> Index=%0d -> Data=0x%h", Address, Address>>2, ReadData);
        
        // Test 4: Direcciones fuera de rango (opcional)
        $display("\n--- Prueba 4: Direcciones límite ---");
        Address = (2**ADD) * 4; // Fuera de rango
        #10;
        $display("Address=0x%h (fuera de rango) -> Data=0x%h", Address, ReadData);
        
        $display("\n=== Fin de pruebas ===");
        $finish;
    end
    
    // Monitor para cambios automáticos
    initial begin
        $monitor("Tiempo=%0t: Address=0x%h, ReadData=0x%h", 
                 $time, Address, ReadData);
    end
    
endmodule