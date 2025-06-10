module IF_STAGE (
    input clk,
    input reset,
    input PCSrc,
    input [31:0] imm_ext,
    output reg [31:0] PC_out,
    output [31:0] instruction
);

    reg [31:0] instr_mem [0:1023];

    // Inicializar memoria de instrucciones
    initial begin
        $readmemh("instructions.hex", instr_mem);
    end

    wire [31:0] PC_next;

    assign PC_next = PC_out + 4;

    assign instruction = instr_mem[PC_out[11:2]];  // Word-aligned access

    always @(posedge clk or posedge reset) begin
        if (reset)
            PC_out <= 32'b0;
        else if (PCSrc)
            PC_out <= PC_out + imm_ext;  // PC-relative branch
        else
            PC_out <= PC_next;
    end

endmodule
