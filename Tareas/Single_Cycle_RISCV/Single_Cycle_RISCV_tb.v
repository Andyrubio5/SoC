`timescale 1ns / 1ps

module Single_Cycle_RISCV_tb;

    localparam WIDTH = 32;
    localparam CLK_PERIOD = 10;
    localparam NUM_INSTRUCTIONS = 21;

    reg clk;
    reg rst;
    integer j;
    integer error_count = 0;

    // Instancia del procesador
    Single_Cycle_RISCV #(
        .WIDTH(WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .pc_out(),       
        .alu_result()
    );

    // Generador de reloj
    always #(CLK_PERIOD/2) clk = ~clk;

    // Función para verificar registros
    task check_register;
        input [4:0] reg_num;
        input [31:0] expected_value;
        begin
            if (uut.rf.registers[reg_num] !== expected_value) begin
                $display("ERROR: x%0d = 0x%h (esperado: 0x%h)", 
                        reg_num, uut.rf.registers[reg_num], expected_value);
                error_count = error_count + 1;
            end
        end
    endtask

    // Función para verificar memoria
    task check_memory;
        input [31:0] address;
        input [31:0] expected_value;
        begin
            if (uut.data_mem.Data_mem[address[9:0]] !== expected_value) begin
                $display("ERROR: Mem[0x%h] = 0x%h (esperado: 0x%h)", 
                        address, uut.data_mem.Data_mem[address[9:0]], expected_value);
                error_count = error_count + 1;
            end
        end
    endtask

    // Test principal
    initial begin
        $display("\n===> Iniciando simulacion del procesador RISC-V...");

        // Inicialización
        clk = 0;
        rst = 1;
        #(CLK_PERIOD*2);
        rst = 0;

        // Verificación paso a paso
        @(posedge clk); // Instrucción 1: addi x2, x0, 5
        check_register(2, 32'h5);
        
        @(posedge clk); // Instrucción 2: addi x3, x0, 12
        check_register(3, 32'hC);
        
        @(posedge clk); // Instrucción 3: addi x7, x3, -9
        check_register(7, 32'h3);
        
        @(posedge clk); // Instrucción 4: or x4, x7, x2
        check_register(4, 32'h7);
        
        @(posedge clk); // Instrucción 5: and x5, x3, x4
        check_register(5, 32'h4);
        
        @(posedge clk); // Instrucción 6: add x5, x5, x4
        check_register(5, 32'hB);
        
        @(posedge clk); // Instrucción 7: beq x5, x7, 0x30 (no toma el branch)
        check_register(5, 32'hB); // Verifica que no modificó registros
        
        @(posedge clk); // Instrucción 8: slt x4, x3, x4
        check_register(4, 32'h0);
        
        @(posedge clk); // Instrucción 9: beq x4, x0, 0x28 (toma el branch)
        // Verifica que PC saltó correctamente
        
        @(posedge clk); // Instrucción 10: slt x4, x5, x3 (en 0x28)
        check_register(4, 32'h1);
        
        @(posedge clk); // Instrucción 11: add x7, x4, x5
        check_register(7, 32'hC);
        
        @(posedge clk); // Instrucción 12: sub x7, x7, x4
        check_register(7, 32'hB);
        
        @(posedge clk); // Instrucción 13: sw x7, 84(x3)
        check_memory(32'h60, 32'hB); // 12 + 84 = 96 (0x60)
        
        @(posedge clk); // Instrucción 14: lw x2, 96(x0)
        check_register(2, 32'hB);
        
        @(posedge clk); // Instrucción 15: add x9, x2, x5
        check_register(9, 32'h16);
        
        @(posedge clk); // Instrucción 16: jal x3, 0x48
        check_register(3, 32'h44); // PC + 4 = 0x40 + 4 = 0x44
        
        @(posedge clk); // Instrucción 17: add x2, x2, x9 (en 0x48)
        check_register(2, 32'h21);
        
        @(posedge clk); // Instrucción 18: sw x2, 32(x3)
        check_memory(32'h64, 32'h21); // 0x44 + 32 = 0x64
        
        // Verificación final
        $display("\n==== Verificacion final de registros ====");
        check_register(0, 32'h0);   // x0 siempre cero
        check_register(2, 32'h21);  // x2
        check_register(3, 32'h44);  // x3
        check_register(4, 32'h1);   // x4
        check_register(5, 32'hB);   // x5
        check_register(7, 32'hB);   // x7
        check_register(9, 32'h16);  // x9
        
        $display("\n==== Memoria de datos con valores diferentes de cero ====");
        for (j = 0; j < 1024; j = j + 1) begin
            if (uut.data_mem.Data_mem[j] !== 32'h00000000) begin
                $display("Data_mem[0x%03h] = 0x%08h", j, uut.data_mem.Data_mem[j]);
            end
        end
        
        if (error_count == 0) begin
            $display("\nTEST PASSED: Todas las verificaciones fueron exitosas!");
        end else begin
            $display("\nTEST FAILED: Se encontraron %0d errores", error_count);
        end
        
        $finish;
    end

    // Monitoreo detallado por ciclo
    always @(posedge clk) begin
        $display("\n=== Ciclo %0d ===", $time/CLK_PERIOD);
        $display("PC: 0x%h | Inst: 0x%h | ALU: 0x%h", 
                uut.pc, uut.instruction, uut.alu_result);
        $display("RegWrite: %b | MemWrite: %b | ALUSrc: %b | ResultSrc: %b", 
                uut.RegWrite, uut.MemWrite, uut.ALUSrc, uut.ResultSrc);
        $display("ImmExt: 0x%h | ImmSrc: %b", uut.imm_extend, uut.imm_src);
        $display("PCSrc: %b | PcNext: 0x%h", uut.PCSrc, uut.PcNext);
        
        // Debug adicional de registros
        $display("Registros: x2=0x%h, x3=0x%h, x4=0x%h, x5=0x%h, x7=0x%h",
                uut.rf.registers[2],
                uut.rf.registers[3],
                uut.rf.registers[4],
                uut.rf.registers[5],
                uut.rf.registers[7]);
    end

endmodule