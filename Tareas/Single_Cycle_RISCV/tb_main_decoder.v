`timescale 1ns / 1ps

module tb_main_decoder;
  // señales de estímulo
  reg        clk;
  reg  [6:0] op;
  // salidas del main_decoder
  wire       Jump;
  wire       Branch;
  wire       MemWrite;
  wire       ALUSrc;
  wire       RegWrite;
  wire [1:0] ResultSrc;
  wire [1:0] ImmSrc;
  wire [1:0] ALUOp;

  // lista de instrucciones .hex a probar
  reg [31:0] instructions [0:20];
  integer    i;

  // Instancia del main_decoder
  main_decoder uut (
    .op(op),
    .clk(clk),
    .jump(Jump),
    .branch(Branch),
    .mem_write(MemWrite),
    .alu_src(ALUSrc),
    .reg_write(RegWrite),
    .result_src(ResultSrc),
    .imm_src(ImmSrc),
    .alu_op(ALUOp)
  );

  // Generador de reloj
  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    // Cargar las 21 instrucciones
    instructions[0]  = 32'h00500113;
    instructions[1]  = 32'h00C00193;
    instructions[2]  = 32'hFF718393;
    instructions[3]  = 32'h0023E233;
    instructions[4]  = 32'h0041F2B3;
    instructions[5]  = 32'h004282B3;
    instructions[6]  = 32'h02728863;
    instructions[7]  = 32'h0041A233;
    instructions[8]  = 32'h00020463;
    instructions[9]  = 32'h00000293;
    instructions[10] = 32'h0023A233;
    instructions[11] = 32'h005203B3;
    instructions[12] = 32'h402383B3;
    instructions[13] = 32'h0471AA23;
    instructions[14] = 32'h06002103;
    instructions[15] = 32'h005104B3;
    instructions[16] = 32'h008001EF;
    instructions[17] = 32'h00100113;
    instructions[18] = 32'h00910133;
    instructions[19] = 32'h0221A023;
    instructions[20] = 32'h00210063;

    // Pequeño retardo para estabilizar
    #10;

    // Cabecera de la tabla
    $display("| Instruction  | Opcode  | RegWrite | ALUSrc | MemWrite | ResultSrc | Branch | ALUOp |");
    $display("|--------------|---------|----------|--------|----------|-----------|--------|-------|");

    // Para cada instrucción:
    for (i = 0; i < 21; i = i + 1) begin
      // Extraer los 7 bits menos significativos
      op = instructions[i][6:0];
      #10;  // un ciclo de reloj

      $display("| 0x%08h | %07b |    %b     |   %b    |    %b     |     %b      |   %b    |  %b   |",
               instructions[i],
               op,
               RegWrite,
               ALUSrc,
               MemWrite,
               ResultSrc,
               Branch,
               ALUOp
      );
    end

    $finish;
  end
endmodule
