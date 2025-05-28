module instruction_memory #(parameter N = 32) (
    input [N-1:0] pc,
    output reg [N-1:0] instruction
);
    reg [N-1:0] IMEM [0:255];
    integer i;

    initial begin
        // Inicializa toda la memoria con 0 (opcional)
        for (i = 0; i < 256; i = i + 1)
            IMEM[i] = 32'h00000000;

        // Carga el archivo con verificaciones
        $display("[IMEM] Intentando cargar instructions.hex...");
        $readmemh("instructions.hex", IMEM);
        
        // Depuración avanzada
        $display("[IMEM] Primeras 25 instrucciones cargadas:");
        for (i = 0; i < 25; i = i + 1)
            $display("IMEM[%0d] = %h", i, IMEM[i]);
        
    end

    always @(*) begin
        instruction = IMEM[pc[N-1:2]];
        // Depuración en tiempo real
        $display("[IMEM] PC=%h -> Inst=%h (index=%0d)", pc, instruction, pc[N-1:2]);
    end
endmodule