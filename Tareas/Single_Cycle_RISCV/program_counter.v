module program_counter #(parameter N =32)(
    input clk,
    input reset,  // Añadir señal de reset
    input [N-1:0] pc_next,
    output reg [N-1:0] pc
);

always @(posedge clk or posedge reset) begin
    if (reset) pc <= 32'b0;
    else pc <= pc_next;
end

endmodule 