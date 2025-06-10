module RISC_V_Pipeline_tb;

    reg clk = 0;
    reg reset = 1;

    // Clock generation
    always #5 clk = ~clk;

    // DUT
    RISC_V_Pipeline_Processor uut (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        // Reset inicial
        #10;
        reset = 0;

        // Simulación extendida
        #500;

        $stop;
    end

endmodule
