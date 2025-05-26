module Extend (
    input [31:7] extend_in,
    input [1:0] ImmSrc,
    output reg [31:0] ImmExt
);
reg [11:0] aux_extend;
    always @(*) begin
        case (ImmSrc)
            // I-type 
            2'b00: aux_extend = extend_in[31:20];
            
            // S-type 
            2'b01: aux_extend = {extend_in[31:25], extend_in[11:7]};
            
            // B-type 
            2'b10: aux_extend = {extend_in[31], extend_in[7], extend_in[30:25], extend_in[11:8]};
            
            // J-type 
            2'b11: aux_extend = {extend_in[31], extend_in[19:12], extend_in[20], extend_in[30:21]};

            default: aux_extend = 32'b0; // Default case to avoid latches
            
        endcase
        
        if (ImmSrc == 2'b11) // J-type
            ImmExt = {{11{extend_in[31]}}, extend_in[31], extend_in[19:12], extend_in[20], extend_in[30:21]};
        else    
            ImmExt = {20{aux_extend[11]}}; 
    end

endmodule