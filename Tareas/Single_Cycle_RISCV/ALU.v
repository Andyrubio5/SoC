module ALU(
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [2:0] ALUControl,
    output reg Zero,
    output reg [31:0] ALUResult
);

    always @(*) begin
        case (ALUControl)
            3'b000: ALUResult = SrcA + SrcB;      // Add
            3'b001: ALUResult = SrcA - SrcB;      // Subtract
            3'b010: ALUResult = SrcA & SrcB;      // AND
            3'b011: ALUResult = SrcA | SrcB;      // OR
            3'b101: ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 32'd1 : 32'd0;
            default: ALUResult = 32'b0;
        endcase

        if (ALUResult == 32'b0) begin
            Zero = 1'b1;
        end else begin
            Zero = 1'b0;
        end
    end

endmodule
