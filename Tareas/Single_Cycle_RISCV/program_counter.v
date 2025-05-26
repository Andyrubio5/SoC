module program_counter # (parameter N =32)(
	input clk,
	input [N-1:0] pc_next,

	output reg [N-1:0] pc
	);


always @(posedge clk)
	begin
		pc <= pc_next;

	end

endmodule