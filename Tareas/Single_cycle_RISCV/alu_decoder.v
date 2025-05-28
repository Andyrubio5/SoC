module ALUDecoder(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input op5, funct7,
    output reg [2:0] ALUControl
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 3'b000; // add (para lw, sw)
        2'b01: ALUControl = 3'b001; // subtract (para beq)
        2'b10: begin
            case (funct3)
                3'b000: begin
                    if ({op5, funct7} == 2'b11) // sub
                        ALUControl = 3'b001;
                    else // add, addi
                        ALUControl = 3'b000;	
                end
                3'b010: ALUControl = 3'b101; // slt, slti
                3'b110: ALUControl = 3'b011; // or, ori
                3'b111: ALUControl = 3'b010; // and, andi
                default: ALUControl = 3'b000; // default (no debería ocurrir)
            endcase
        end
        default: ALUControl = 3'b000; // default (no debería ocurrir)
    endcase
end

endmodule