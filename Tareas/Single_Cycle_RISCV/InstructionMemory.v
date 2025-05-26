module InstructionMemory (
    input wire [31:0] Address,
    output wire [31:0] ReadData
);

    reg [31:0] ROM [10000:0];

    // Carga de instrucciones desde archivo
    initial begin
        $readmemh("instructions.txt", ROM);
    end

    assign ReadData = ROM[Address[15:2]];

endmodule