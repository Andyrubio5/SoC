module Extend_tb;
    reg [31:7] extend_in;
    reg [1:0] ImmSrc;
    wire [31:0] ImmExt;

    Extend uut (.*);

    initial begin
        $dumpfile("extend_wave.vcd");
        $dumpvars(0, Extend_tb);
        
        // I-type (ADDI)
        instr = 32'h00500113; ImmSrc = 2'b00; #10;
        $display("I-type: %h", ImmExt);  // Debe mostrar 00000005
        
        // S-type (SW)
        instr = 32'h00C00193; ImmSrc = 2'b01; #10;
        $display("S-type: %h", ImmExt);  // Debe mostrar 0000000C
        
        // B-type (BEQ)
        instr = 32'hFF718393; ImmSrc = 2'b10; #10;
        $display("B-type: %h", ImmExt);  // Debe mostrar FFFFFFF8
        
        $finish;
    end
endmodule