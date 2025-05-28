module data_memory #(
    parameter DATA_WIDTH = 32
)(
    input [31:0] A, WD,
    input clk, WE,
    output wire [31:0] RD
);

    // Memory array
    reg [DATA_WIDTH-1:0] Data_mem [1023:0];

    // Initialize memory
    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1) begin
            Data_mem[i] = {DATA_WIDTH{1'b0}};
        end
    end

    // Combinational read
    assign RD = Data_mem[A[9:0]];

    // Sequential write
    always @(posedge clk) begin
        if (WE) begin
            Data_mem[A[9:0]] <= WD;
        end
    end

endmodule