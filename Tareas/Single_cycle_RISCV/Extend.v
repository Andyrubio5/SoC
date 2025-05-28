module Extend (
    input [31:7] extend_in,
    input [1:0] ImmSrc,
    output reg [31:0] ImmExt
);
    
    always @(*) begin
        case (ImmSrc)
            2'b00: // I-type
                ImmExt = {{20{extend_in[31]}}, extend_in[31:20]};
            2'b01: // S-type
                ImmExt = {{20{extend_in[31]}}, extend_in[31:25], extend_in[11:7]};
            2'b10: // B-type
                ImmExt = {{20{extend_in[31]}}, extend_in[7], extend_in[30:25], extend_in[11:8], 1'b0};
            2'b11: // J-type
                ImmExt = {{12{extend_in[31]}}, extend_in[19:12], extend_in[20], extend_in[30:21], 1'b0};
            default:
                ImmExt = 32'h00000000;
        endcase
    end
    
endmodule