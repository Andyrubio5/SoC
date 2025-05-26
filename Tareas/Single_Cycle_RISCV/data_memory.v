module data_memory(
    input [31:0] A, WD,
    input clk, WE,
    output reg [31:0] RD
);

    // Memory array
    reg [31:0] memory [10000:0]; // 256 words of 32 bits each

    always @(posedge clk) begin
        if (WE) begin
            memory[A] <= WD; // Store data in memory
        end
        RD <= memory[A]; // Read data from memory
    end
    
endmodule