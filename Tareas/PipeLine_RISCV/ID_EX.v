module ID_EX (
    input clk,
    input reset,

    input [31:0] PC_in,
    input [31:0] rs1_data_in,
    input [31:0] rs2_data_in,
    input [31:0] imm_ext_in,
    input [4:0] rd_in,
    input [4:0] rs1_in,
    input [4:0] rs2_in,

    input ALUSrc_in,
    input [2:0] ALUControl_in,
    input RegWrite_in,
    input MemWrite_in,
    input [1:0] ResultSrc_in,

    output reg [31:0] PC_out,
    output reg [31:0] rs1_data_out,
    output reg [31:0] rs2_data_out,
    output reg [31:0] imm_ext_out,
    output reg [4:0] rd_out,
    output reg [4:0] rs1_out,
    output reg [4:0] rs2_out,

    output reg ALUSrc_out,
    output reg [2:0] ALUControl_out,
    output reg RegWrite_out,
    output reg MemWrite_out,
    output reg [1:0] ResultSrc_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC_out <= 0;
            rs1_data_out <= 0;
            rs2_data_out <= 0;
            imm_ext_out <= 0;
            rd_out <= 0;
            rs1_out <= 0;
            rs2_out <= 0;

            ALUSrc_out <= 0;
            ALUControl_out <= 0;
            RegWrite_out <= 0;
            MemWrite_out <= 0;
            ResultSrc_out <= 0;
        end else begin
            PC_out <= PC_in;
            rs1_data_out <= rs1_data_in;
            rs2_data_out <= rs2_data_in;
            imm_ext_out <= imm_ext_in;
            rd_out <= rd_in;
            rs1_out <= rs1_in;
            rs2_out <= rs2_in;

            ALUSrc_out <= ALUSrc_in;
            ALUControl_out <= ALUControl_in;
            RegWrite_out <= RegWrite_in;
            MemWrite_out <= MemWrite_in;
            ResultSrc_out <= ResultSrc_in;
        end
    end

endmodule
