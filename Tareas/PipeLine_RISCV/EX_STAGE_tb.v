module EX_STAGE_tb;
    reg [31:0] rs1_data;
    reg [31:0] rs2_data;
    reg [31:0] imm_ext;
    reg [2:0] ALUControl;
    reg ALUSrc;
    reg [4:0] rd_in;
    reg [31:0] PC_in;
    reg [31:0] instruction;

    wire [31:0] ALUResult;
    wire Zero;
    wire [31:0] rs2_data_out;
    wire [4:0] rd_out;
    wire [31:0] PC_out;
    wire [31:0] instruction_out;

    EX_STAGE uut (
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .imm_ext(imm_ext),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .rd_in(rd_in),
        .PC_in(PC_in),
        .instruction(instruction),
        .ALUResult(ALUResult),
        .Zero(Zero),
        .rs2_data_out(rs2_data_out),
        .rd_out(rd_out),
        .PC_out(PC_out),
        .instruction_out(instruction_out)
    );

    initial begin
        $display("Starting EX_STAGE test...");

        // Caso 1: addi x1, x0, 5
        rs1_data = 32'd0;
        rs2_data = 32'd0;          // ignorado
        imm_ext = 32'd5;
        ALUSrc = 1;                // usar inmediato
        ALUControl = 3'b000;       // suma
        rd_in = 5'd1;
        PC_in = 32'd0;
        instruction = 32'h00500093;
        #10;

        // Caso 2: add x3, x1, x2
        rs1_data = 32'd10;
        rs2_data = 32'd20;
        imm_ext = 32'd0;           // ignorado
        ALUSrc = 0;                // usar rs2
        ALUControl = 3'b000;       // suma
        rd_in = 5'd3;
        PC_in = 32'd4;
        instruction = 32'h002081b3;
        #10;

        // Caso 3: sw x2, 0(x1)
        rs1_data = 32'd100;
        rs2_data = 32'd55;
        imm_ext = 32'd0;
        ALUSrc = 1;                // usar inmediato
        ALUControl = 3'b000;       // suma (calcular dirección)
        rd_in = 5'd0;              // sin uso en sw
        PC_in = 32'd8;
        instruction = 32'h0020a023;
        #10;

        // Caso 4: lw x5, 0(x1)
        rs1_data = 32'd200;
        rs2_data = 32'd0;          // ignorado
        imm_ext = 32'd4;
        ALUSrc = 1;                // usar inmediato
        ALUControl = 3'b000;       // suma (calcular dirección)
        rd_in = 5'd5;
        PC_in = 32'd12;
        instruction = 32'h0000a283;
        #10;

        $stop;
    end
endmodule
