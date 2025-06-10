module MEM_WB (
    input clk,
    input reset,

    input [31:0] ReadData_in,
    input [31:0] ALUResult_in,
    input [31:0] PC_plus4_in,
    input [4:0] rd_in,
    input RegWrite_in,
    input [1:0] ResultSrc_in,

    output reg [31:0] ReadData_out,
    output reg [31:0] ALUResult_out,
    output reg [31:0] PC_plus4_out,
    output reg [4:0] rd_out,
    output reg RegWrite_out,
    output reg [1:0] ResultSrc_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ReadData_out <= 0;
            ALUResult_out <= 0;
            PC_plus4_out <= 0;
            rd_out <= 0;
            RegWrite_out <= 0;
            ResultSrc_out <= 0;
        end else begin
            ReadData_out <= ReadData_in;
            ALUResult_out <= ALUResult_in;
            PC_plus4_out <= PC_plus4_in;
            rd_out <= rd_in;
            RegWrite_out <= RegWrite_in;
            ResultSrc_out <= ResultSrc_in;
        end
    end

endmodule
