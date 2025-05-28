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
    always begin
        
        
        #1 clk = ~clk;
    end
    
    initial begin
        clk = 0;
        #10;
        // Initialize Inputs
        op = 0;
        
        // Wait for global reset
        #10;
        
        // Test case 1: Load Word (LW)
        op = 7'b0000011;
        #10;
        
        // Test case 2: Store Word (SW)
        op = 7'b0100011;
        #10;
        
        // Test case 3: R-type
        op = 7'b0110011;
        #10;
        
        // Test case 4: Branch Equal (BEQ)
        op = 7'b1100011;
        #10;
        
        // Test case 5: I-type ALU
        op = 7'b0010011;
        #10;
        
        // Test case 6: Jump and Link (JAL)
        op = 7'b1101111;
        #10;
        
        // Finish simulation
        $finish;
    end
    
endmodule