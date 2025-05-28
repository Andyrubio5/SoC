module ALU (
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
            3'b101: ALUResult = (SrcA < SrcB) ? 32'd1 : 32'd0; // SLT
            default: ALUResult = 32'b0;
        endcase
	 
    Zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;
	end
endmodule
