module Forwarding_Unit (
    input [4:0] rs1_EX,
    input [4:0] rs2_EX,
    input [4:0] rd_MEM,
    input [4:0] rd_WB,
    input RegWrite_MEM,
    input RegWrite_WB,

    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
);

    always @(*) begin
        // Default: no forwarding
        ForwardA = 2'b00;
        ForwardB = 2'b00;

        // EX hazard (MEM stage result → EX)
        if (RegWrite_MEM && (rd_MEM != 0) && (rd_MEM == rs1_EX))
            ForwardA = 2'b01;

        if (RegWrite_MEM && (rd_MEM != 0) && (rd_MEM == rs2_EX))
            ForwardB = 2'b01;

        // MEM hazard (WB stage result → EX)
        if (RegWrite_WB && (rd_WB != 0) &&
            !(RegWrite_MEM && (rd_MEM != 0) && (rd_MEM == rs1_EX)) &&
            (rd_WB == rs1_EX))
            ForwardA = 2'b10;

        if (RegWrite_WB && (rd_WB != 0) &&
            !(RegWrite_MEM && (rd_MEM != 0) && (rd_MEM == rs2_EX)) &&
            (rd_WB == rs2_EX))
            ForwardB = 2'b10;
    end

endmodule
