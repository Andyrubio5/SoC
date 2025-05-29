module data_memory #(parameter DATA_WIDTH = 32) (
    input clk,         // Clock signal
    input WE,          // Write Enable signal (1 = write, 0 = read)
    input [DATA_WIDTH-1:0] A,    
    input [DATA_WIDTH-1:0] WD,  
    output [DATA_WIDTH-1:0] RD   
);

reg [DATA_WIDTH-1:0] Data_mem [1023:0];


// Añadir debug
always @(posedge clk) begin
    if (WE) begin
        $display("Memory Write - Time: %0t Addr: %h Data: %h", $time, A, WD);
    end
end

integer i;
initial begin
    for (i = 0; i < 1024; i = i + 1) begin
        Data_mem[i] = 32'h00000000;
    end
end


assign RD = Data_mem[A[9:0]];

always @(posedge clk) begin
    if (WE) begin
        Data_mem[A[9:0]] <= WD;
    end
end

endmodule