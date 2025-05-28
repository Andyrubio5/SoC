`timescale 1ns / 1ps

module Single_Cycle_RISCV_tb;

    localparam WIDTH = 32;
    localparam CLK_PERIOD = 10;
    localparam NUM_INSTRUCTIONS = 21;

    reg clk;
    reg rst;
    integer j;

    // Instancia del procesador
    Single_Cycle_RISCV #(
        .WIDTH(WIDTH)
    ) uut (   // Cambié a `uut` para que coincida con tu bloque always
        .clk(clk),
        .rst(rst),
        .pc_out(),       
        .alu_result()
    );

    // Generador de reloj
    always #(CLK_PERIOD/2) clk = ~clk;

    // Test principal
    initial begin
        $display("\n===> Iniciando simulacion del procesador RISC-V...");
        $dumpfile("riscv.vcd");
        $dumpvars(0, Single_Cycle_RISCV_tb);

        clk = 0;
        rst = 1;
        #(CLK_PERIOD);
        rst = 0;

        repeat (NUM_INSTRUCTIONS) @(posedge clk);

        if (uut.instruction === 32'hxxxxxxxx || ^uut.instruction === 1'bx) begin
            $display("\n*** Fin del programa: Instruccion no valida detectada ***");
            $display("PC: 0x%h | Instruction: 0x%h", uut.pc, uut.instruction);
        end

        $display("\n==== Memoria de datos (0x000 a 0x00F) ====");
        for (j = 0; j < 16; j = j + 1) begin
            $display("Data_mem[0x%03h] = 0x%08h", j, uut.data_mem.memory[j]);
        end

        $finish;
    end

    // Monitoreo por ciclo
    always @(posedge clk) begin
        $display("PC: 0x%h | Inst: 0x%h | ALU: 0x%h", uut.pc, uut.instruction, uut.alu_result);
        $display("RegWrite: %b | MemWrite: %b | ALUSrc: %b | ResultSrc: %b", 
                  uut.RegWrite, uut.MemWrite, uut.ALUSrc, uut.ResultSrc);
        $display("ImmExt: 0x%h | ImmSrc: %b", uut.imm_extend, uut.imm_src);
        $display("PCSrc: %b | PcNext: 0x%h\n", uut.PCSrc, uut.PcNext);
    end

endmodule
