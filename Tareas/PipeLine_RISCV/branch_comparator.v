module branch_comparator #(
    parameter WIDTH = 32    // Ancho por defecto para registros de 32 bits
)(
    input  wire [WIDTH-1:0] rs1_data,     // Dato del primer registro fuente
    input  wire [WIDTH-1:0] rs2_data,     // Dato del segundo registro fuente
    input  wire [2:0] branch_type,        // Tipo de comparación
    output wire branch_taken              // Resultado de la comparación
);

    // Definición de tipos de branch
    localparam BEQ  = 3'b000;    // Branch if Equal
    localparam BNE  = 3'b001;    // Branch if Not Equal
    localparam BLT  = 3'b100;    // Branch if Less Than
    localparam BGE  = 3'b101;    // Branch if Greater or Equal
    localparam BLTU = 3'b110;    // Branch if Less Than Unsigned
    localparam BGEU = 3'b111;    // Branch if Greater or Equal Unsigned

    // Señales intermedias para las comparaciones
    wire equal = (rs1_data == rs2_data);
    wire less_than = $signed(rs1_data) < $signed(rs2_data);
    wire less_than_unsigned = rs1_data < rs2_data;

    // Lógica de comparación
    reg result;
    always @(*) begin
        case(branch_type)
            BEQ:  result = equal;
            BNE:  result = !equal;
            BLT:  result = less_than;
            BGE:  result = !less_than;
            BLTU: result = less_than_unsigned;
            BGEU: result = !less_than_unsigned;
            default: result = 1'b0;
        endcase
    end

    assign branch_taken = result;

endmodule