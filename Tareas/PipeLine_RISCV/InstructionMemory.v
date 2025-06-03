module InstructionMemory #(parameter ADD = 8) (
    input [31:0] Address,
    output [31:0] ReadData
);
    reg [31:0] ROM[(2**ADD)-1:0];
    localparam INSTRUCTION_COUNT = 21;  // Cambia según tu .hex

    initial begin
        $readmemh("instructions.hex", ROM);
    end

    assign ReadData = (Address >> 2) < INSTRUCTION_COUNT ? ROM[Address >> 2] : 32'hXXXXXXXX;

endmodule
