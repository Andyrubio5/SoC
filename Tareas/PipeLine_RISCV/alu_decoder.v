module alu_decoder(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input op5,
    input funct7, // este es solo el bit 30 en realidad
    output reg [2:0] ALUControl
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 3'b000; // lw, sw => ADD
        2'b01: ALUControl = 3'b001; // beq => SUB
        2'b10: begin
            case (funct3)
                3'b000: begin
                    if (funct7 == 1'b1) // si bit 30 es 1 => sub
                        ALUControl = 3'b001;
                    else                // si bit 30 es 0 => add/addi
                        ALUControl = 3'b000;
                end
                3'b010: ALUControl = 3'b101; // slt/slti
                3'b110: ALUControl = 3'b011; // or/ori
                3'b111: ALUControl = 3'b010; // and/andi
                default: ALUControl = 3'b000; // default a ADD
            endcase
        end
        default: ALUControl = 3'b000; // default a ADD
    endcase
end

endmodule
