module Forwarding_Unit_tb;

    reg [4:0] rs1_EX, rs2_EX;
    reg [4:0] rd_MEM, rd_WB;
    reg RegWrite_MEM, RegWrite_WB;
    wire [1:0] ForwardA, ForwardB;

    Forwarding_Unit uut (
        .rs1_EX(rs1_EX),
        .rs2_EX(rs2_EX),
        .rd_MEM(rd_MEM),
        .rd_WB(rd_WB),
        .RegWrite_MEM(RegWrite_MEM),
        .RegWrite_WB(RegWrite_WB),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)
    );

    initial begin
        $display("Inicio del test de Forwarding_Unit...");

        // Caso 1: Sin hazards
        rs1_EX = 5'd1; rs2_EX = 5'd2;
        rd_MEM = 5'd0; rd_WB = 5'd0;
        RegWrite_MEM = 0; RegWrite_WB = 0;
        #10;

        // Caso 2: Hazard con MEM → EX (ForwardA)
        rs1_EX = 5'd10; rs2_EX = 5'd2;
        rd_MEM = 5'd10; rd_WB = 5'd0;
        RegWrite_MEM = 1; RegWrite_WB = 0;
        #10;

        // Caso 3: Hazard con MEM → EX (ForwardB)
        rs1_EX = 5'd1; rs2_EX = 5'd20;
        rd_MEM = 5'd20; rd_WB = 5'd0;
        RegWrite_MEM = 1; RegWrite_WB = 0;
        #10;

        // Caso 4: Hazard con WB → EX (ForwardA)
        rs1_EX = 5'd5; rs2_EX = 5'd3;
        rd_MEM = 5'd0; rd_WB = 5'd5;
        RegWrite_MEM = 0; RegWrite_WB = 1;
        #10;

        // Caso 5: MEM y WB coinciden, pero debe priorizar MEM (ForwardA = 01)
        rs1_EX = 5'd8;
        rd_MEM = 5'd8;
        rd_WB = 5'd8;
        RegWrite_MEM = 1;
        RegWrite_WB = 1;
        #10;

        $stop;
    end

endmodule
