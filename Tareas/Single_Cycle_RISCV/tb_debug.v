// Testbench simple para debuggear el problema de memoria
module tb_debug;

reg clk, rst;
wire [31:0] pc_out, alu_result;

// Instancia del procesador
Single_Cycle_RISCV #(.WIDTH(32)) dut (
    .clk(clk),
    .rst(rst),
    .pc_out(pc_out),
    .alu_result(alu_result)
);

// Generación de reloj
always #5 clk = ~clk;

// Variables para contar ciclos
integer i;

// Monitoreo de escrituras a memoria
always @(posedge clk) begin
    if (!rst && dut.MemWrite) begin
        $display("ESCRITURA DETECTADA - Ciclo: %0d", $time/10);
        $display("  PC: %h", pc_out);
        $display("  Instrucción: %h", dut.instruction);
        $display("  Dirección: %h", alu_result);
        $display("  Dato: %h", dut.RD2);
        $display("  Opcode: %b", dut.instruction[6:0]);
    end
end

// Secuencia de prueba
initial begin
    // Inicialización
    clk = 0;
    rst = 1;
    
    // Reset
    #10;
    rst = 0;
    
    // Ejecutar 20 ciclos
    #200;
    
    // Mostrar contenido de memoria
    $display("\n=== CONTENIDO DE MEMORIA ===");
    for (i = 0; i < 64; i = i + 1) begin
        if (dut.data_mem.Data_mem[i] !== 32'h00000000) begin
            $display("Memoria[%02h] = %h", i, dut.data_mem.Data_mem[i]);
        end
    end
    
    // Mostrar registros finales
    $display("\n=== REGISTROS FINALES ===");
    $display("x1 (ra): %h", dut.rf.registers[1]);
    $display("x2 (sp): %h", dut.rf.registers[2]);
    $display("x3 (gp): %h", dut.rf.registers[3]);
    $display("x4 (tp): %h", dut.rf.registers[4]);
    $display("x5 (t0): %h", dut.rf.registers[5]);
    $display("x7 (t2): %h", dut.rf.registers[7]);
    $display("x9 (s1): %h", dut.rf.registers[9]);
    
    $finish;
end

endmodule