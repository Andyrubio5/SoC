module main_decoder(
    input [6:0] op,
    input clk,
    output reg branch,
                jump,
                mem_write,
                alu_src,
                reg_write,
    output reg [1:0] result_src,
                      imm_src,
                      alu_op
); 


localparam op_lw    = 7'b0000011;  // Load word
localparam op_sw    = 7'b0100011;  // Store word
localparam op_rtype = 7'b0110011;  // R-type operations
localparam op_beq   = 7'b1100011;  // Branch equal
localparam op_itype = 7'b0010011;  // I-type operations
localparam op_jal   = 7'b1101111;  // Jump and link

reg [1:0] active_state;

// Control logic based on opcode
always @(*) begin
    // Default values
    branch = 1'b0;
    jump = 1'b0;
    mem_write = 1'b0;
    alu_src = 1'b0;
    reg_write = 1'b0;
    result_src = 2'b00;
    imm_src = 2'b00;
    alu_op = 2'b00;
    
    case(op)
        op_lw: begin         // Load word
            reg_write = 1'b1;
            alu_src = 1'b1;
            mem_write = 1'b0;
            result_src = 2'b01;  // From memory
            alu_op = 2'b00;      // Addition
            branch = 1'b0;
            jump = 1'b0;
            imm_src = 2'b00;     // I-type
        end
        
        op_sw: begin         // Store word
            reg_write = 1'b0;
            alu_src = 1'b1;
            mem_write = 1'b1;
            result_src = 2'bxx;  // Don't care
            alu_op = 2'b00;      // Addition
            branch = 1'b0;
            jump = 1'b0;
            imm_src = 2'b01;     // S-type
        end
        
        op_rtype: begin      // R-type
            reg_write = 1'b1;
            alu_src = 1'b0;
            mem_write = 1'b0;
            result_src = 2'b00;  // From ALU
            alu_op = 2'b10;      // Depends on funct field
            branch = 1'b0;
            jump = 1'b0;
            imm_src = 2'bxx;     // Don't care
        end
        
        op_beq: begin        // Branch equal
            reg_write = 1'b0;
            alu_src = 1'b0;
            mem_write = 1'b0;
            result_src = 2'bxx;  // Don't care
            alu_op = 2'b01;      // Subtraction
            branch = 1'b1;
            jump = 1'b0;
            imm_src = 2'b10;     // B-type
        end
        
        op_itype: begin      // I-type ALU
            reg_write = 1'b1;
            alu_src = 1'b1;
            mem_write = 1'b0;
            result_src = 2'b00;  // From ALU
            alu_op = 2'b11;      // I-type ALU operations
            branch = 1'b0;
            jump = 1'b0;
            imm_src = 2'b00;     // I-type
        end
        
        op_jal: begin        // Jump and link
            reg_write = 1'b1;
            alu_src = 1'bx;      // Don't care
            mem_write = 1'b0;
            result_src = 2'b10;  // PC + 4
            alu_op = 2'bxx;      // Don't care
            branch = 1'b0;
            jump = 1'b1;
            imm_src = 2'b11;     // J-type
        end
        
        default: begin       // Default case
            reg_write = 1'b0;
            alu_src = 1'b0;
            mem_write = 1'b0;
            result_src = 2'b00;
            alu_op = 2'b00;
            branch = 1'b0;
            jump = 1'b0;
            imm_src = 2'b00;
        end
    endcase
end

endmodule