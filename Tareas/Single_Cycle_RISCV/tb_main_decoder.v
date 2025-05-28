`timescale 1ns / 1ps

module tb_main_decoder();

    // Inputs
    reg [6:0] op;
    reg clk;
    
    // Outputs
    wire branch;
    wire jump;
    wire mem_write;
    wire alu_src;
    wire reg_write;
    wire [1:0] result_src;
    wire [1:0] imm_src;
    wire [1:0] alu_op;
    
    // Instantiate the Unit Under Test (UUT)
    main_decoder uut (
        .op(op),
        .clk(clk),
        .branch(branch),
        .jump(jump),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .result_src(result_src),
        .imm_src(imm_src),
        .alu_op(alu_op)
    );
    
    // Clock generation
    always #1 clk = ~clk;
    
    initial begin
        clk = 0;

        $display("\n===== Testbench Main Decoder =====");
        $display(" Time |  op     | Instr | regW | memW | aluS | resS | immS | aluOP | brch | jump ");
        $display("------------------------------------------------------------------------");

        // Caso 1: lw
        op = 7'b0000011;
        #2;
        print_signals("lw");

        // Caso 2: sw
        op = 7'b0100011;
        #2;
        print_signals("sw");

        // Caso 3: r-type
        op = 7'b0110011;
        #2;
        print_signals("rtype");

        // Caso 4: beq
        op = 7'b1100011;
        #2;
        print_signals("beq");

        // Caso 5: itype
        op = 7'b0010011;
        #2;
        print_signals("itype");

        // Caso 6: jal
        op = 7'b1101111;
        #2;
        print_signals("jal");

        // Fin de simulación
        $finish;
    end

    task print_signals(input [15*8:1] instr_name);
        $display(" %4t | %b | %s |   %b   |   %b   |   %b   |  %b  |  %b  |  %b   |  %b   |  %b",
            $time, op, instr_name, reg_write, mem_write, alu_src,
            result_src, imm_src, alu_op, branch, jump);
    endtask

endmodule
