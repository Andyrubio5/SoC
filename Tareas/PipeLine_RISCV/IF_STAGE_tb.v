`timescale 1ns / 1ps

module IF_STAGE_tb;

  // Señales clásicas
  reg clk;
  reg reset;
  wire [31:0] PC;
  wire [31:0] instruction;

  // Instancia del módulo a probar
  IF_STAGE dut (
    .clk(clk),
    .rst(reset),
    .PC(PC),
    .instruction(instruction)
  );

  // Generador de reloj: 10ns ciclo
  always #5 clk = ~clk;

  initial begin
    $display("=== Test IF_stage ===");

    // Inicialización
    clk = 0;
    reset = 1;

    #10;
    reset = 0;

    // Ejecutar varios ciclos y mostrar PC e instrucción
    repeat (5) begin
      #10;
      $display("Tiempo = %0t ns | PC = %0h | Instruction = %0h", $time, PC, instruction);
    end

    $finish;
  end

endmodule
