module IF_ID_tb;

    reg clk = 0;
    reg reset;
    reg [31:0] PC_in;
    reg [31:0] instruction_in;
    wire [31:0] PC_out;
    wire [31:0] instruction_out;

    // Instancia del módulo bajo prueba
    IF_ID uut (
        .clk(clk),
        .reset(reset),
        .PC_in(PC_in),
        .instruction_in(instruction_in),
        .PC_out(PC_out),
        .instruction_out(instruction_out)
    );

    // Generador de reloj
    always #5 clk = ~clk;

    initial begin
        // Inicialización
        reset = 1;
        PC_in = 32'h00000000;
        instruction_in = 32'h00000000;
        #10;

        // Salida debe estar en cero por reset
        reset = 0;

        // Ciclo 1: cargar instrucción y PC
        PC_in = 32'h00000004;
        instruction_in = 32'h00500093; // addi x1, x0, 5
        #10;

        // Ciclo 2: cargar siguiente instrucción
        PC_in = 32'h00000008;
        instruction_in = 32'h002081b3; // add x3, x1, x2
        #10;

        // Reset para limpiar registros
        reset = 1;
        #10;

        reset = 0;
        PC_in = 32'h0000000C;
        instruction_in = 32'h0000a283; // lw x5, 0(x1)
        #10;

        $stop;
    end

endmodule
