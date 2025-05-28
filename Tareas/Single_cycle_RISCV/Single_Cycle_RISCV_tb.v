module Single_Cycle_RISCV_tb;

    // Parámetros
    parameter CLK_PERIOD = 10;
    parameter MEM_SIZE = 1024;
    parameter SIM_TIME = 500;

    // Señales
    reg clk = 0;
    reg rst = 1;
    wire [31:0] pc_out;
    wire [31:0] alu_result;

    // Variables para bucles (declaradas fuera de los bloques)
    integer i, j;

    // Instancia del procesador
    Single_cycle_RISCV dut (
        .clk(clk),
        .rst(rst),
        .pc_out(pc_out),
        .alu_result(alu_result)
    );

    // Generador de reloj
    always #(CLK_PERIOD/2) clk = ~clk;

    // Procedimiento de inicialización y simulación
    initial begin
        // Inicio de simulación
        $display("\n=== Inicio de Simulación ===");
        $display("Hora | PC       | Instrucción | ALU Result");
        $display("-----------------------------------------");

        // Reset inicial
        #(CLK_PERIOD*2) rst = 0;
        $display("[%0t] Reset liberado", $time);

        // Espera para ejecución
        #(SIM_TIME - CLK_PERIOD*2);

        // Volcado de memoria completa
        $display("\n=== Volcado de Memoria de Instrucciones ===");
        for (i = 0; i < MEM_SIZE; i = i + 1) begin
            if (dut.insmemory.IMEM[i] !== 32'b0) begin
                $display("IMEM[%4d] = %h", i, dut.insmemory.IMEM[i]);
            end
        end

        // Volcado de registros
        $display("\n=== Volcado de Registros ===");
        for (j = 0; j < 32; j = j + 1) begin
            if (dut.rf.registers[j] !== 32'b0) begin
                $display("x%2d = %h", j, dut.rf.registers[j]);
            end
        end

        // Finalización
        $display("\n=== Simulación completada ===");
        $finish;
    end

    // Monitor de ejecución en tiempo real
    always @(posedge clk) begin
        if (!rst) begin
            $display("[%0t] %h | %h | %h", 
                    $time, pc_out, dut.instruction, alu_result);
        end
    end

endmodule