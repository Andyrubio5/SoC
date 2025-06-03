`timescale 1ns / 1ps

module alu_decoder_tb();

    // --- Señales de entrada ---
    // Para ALUDecoder
    reg [1:0] ALUOp;
    reg [2:0] funct3;
    reg op5, funct7;
    
    // Para ALU
    reg [31:0] SrcA, SrcB;
    
    // --- Señales de salida ---
    wire [2:0] ALUControl;  // Del ALUDecoder a la ALU
    wire Zero;              // Salida de la ALU
    wire [31:0] ALUResult;  // Salida de la ALU

    // --- Instanciar ambos módulos ---
    alu_decoder uut_decoder (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .op5(op5),
        .funct7(funct7),
        .ALUControl(ALUControl)
    );

    ALU alu (
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .Zero(Zero),
        .ALUResult(ALUResult)
    );

    // --- Bloque de pruebas ---
    initial begin
        // Valores iniciales
        ALUOp = 2'b00;
        funct3 = 3'b000;
        op5 = 0;
        funct7 = 0;
        SrcA = 32'd10;
        SrcB = 32'd5;

        // --- Caso 1: ADD (lw/sw) ---
        ALUOp = 2'b00;  // ADD
        #10;
        $display("Caso 1: ADD (lw/sw) -> ALUControl=%b, Resultado=%d, Zero=%b", 
                 ALUControl, ALUResult, Zero);

        // --- Caso 2: SUB (beq) ---
        ALUOp = 2'b01;  // SUB
        #10;
        $display("Caso 2: SUB (beq) -> ALUControl=%b, Resultado=%d, Zero=%b", 
                 ALUControl, ALUResult, Zero);

        // --- Caso 3: ADD (add/addi) ---
        ALUOp = 2'b10;
        funct3 = 3'b000;
        op5 = 0;
        funct7 = 0;
        #10;
        $display("Caso 3: ADD (add/addi) -> ALUControl=%b, Resultado=%d, Zero=%b", 
                 ALUControl, ALUResult, Zero);

        // --- Caso 4: SUB (sub) ---
        ALUOp = 2'b10;
        funct3 = 3'b000;
        op5 = 1;
        funct7 = 1;
        #10;
        $display("Caso 4: SUB (sub) -> ALUControl=%b, Resultado=%d, Zero=%b", 
                 ALUControl, ALUResult, Zero);

        // --- Caso 5: SLT (slt/slti) ---
        ALUOp = 2'b10;
        funct3 = 3'b010;
        #10;
        $display("Caso 5: SLT (slt) -> ALUControl=%b, Resultado=%d, Zero=%b", 
                 ALUControl, ALUResult, Zero);

        // --- Caso 6: OR (or/ori) ---
        ALUOp = 2'b10;
        funct3 = 3'b110;
        #10;
        $display("Caso 6: OR (or) -> ALUControl=%b, Resultado=%d, Zero=%b", 
                 ALUControl, ALUResult, Zero);

        // --- Caso 7: AND (and/andi) ---
        ALUOp = 2'b10;
        funct3 = 3'b111;
        #10;
        $display("Caso 7: AND (and) -> ALUControl=%b, Resultado=%d, Zero=%b", 
                 ALUControl, ALUResult, Zero);

        // --- Caso 8: Default (instrucción inválida) ---
        ALUOp = 2'b11;
        #10;
        $display("Caso 8: Default (inválido) -> ALUControl=%b, Resultado=%d, Zero=%b", 
                 ALUControl, ALUResult, Zero);

        $finish;
    end

endmodule