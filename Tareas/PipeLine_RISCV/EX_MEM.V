module EX_MEM (
    input clk,
    input reset,

    input [31:0] ALUResult_in,
    input [31:0] rs2_data_in,
    input [4:0] rd_in,

    input MemWrite_in,
    input RegWrite_in,
    input [1:0] ResultSrc_in,
    input [31:0] instruction_in,

    output reg [31:0] instruction_out,
    output reg [31:0] ALUResult_out,
    output reg [31:0] rs2_data_out,
    output reg [4:0] rd_out,

    output reg MemWrite_out,
    output reg RegWrite_out,
    output reg [1:0] ResultSrc_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            instruction_out <= 0;
            ALUResult_out <= 0;
            rs2_data_out <= 0;
            rd_out <= 0;

            MemWrite_out <= 0;
            RegWrite_out <= 0;
            ResultSrc_out <= 0;
        end else begin
            instruction_out <= instruction_in;
            ALUResult_out <= ALUResult_in;
            rs2_data_out <= rs2_data_in;
            rd_out <= rd_in;

            MemWrite_out <= MemWrite_in;
            RegWrite_out <= RegWrite_in;
            ResultSrc_out <= ResultSrc_in;
        end
    end

endmodule
