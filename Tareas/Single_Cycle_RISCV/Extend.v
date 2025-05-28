module Extend (
    input [31:7] extend_in,
    input [1:0] ImmSrc,
    output reg [31:0] ImmExt
);
    always @(*) begin
        case (ImmSrc)
            // I-type
            2'b00: ImmExt = {{20{extend_in[31]}}, extend_in[31:20]};

            // S-type
            2'b01: ImmExt = {{20{extend_in[31]}}, extend_in[31:25], extend_in[11:7]};

            // B-type (branch)
            2'b10: ImmExt = {{19{extend_in[31]}}, extend_in[31], extend_in[7],
                             extend_in[30:25], extend_in[11:8], 1'b0};

            // J-type (jump)
            2'b11: ImmExt = {{11{extend_in[31]}}, extend_in[31], extend_in[19:12],
                             extend_in[20], extend_in[30:21], 1'b0};

            default: ImmExt = 32'b0;
        endcase
    end
endmodule
