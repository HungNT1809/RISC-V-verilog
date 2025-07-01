module ALU_decoder (
    funct3,
    funct7,
    alu_op,
    alu_control
);
    input [2:0] funct3;
    input       funct7;
    input [1:0] alu_op;
    output [3:0] alu_control;

    reg [3:0] alu_control;

    always @(*) begin
        case (alu_op)
            2'b00: alu_control = 4'b0010;
            2'b01: alu_control = 4'b0110;
            2'b10: begin
                case (funct3)
                    3'b000: alu_control = (funct7 == 1'b1) ? 4'b0110 : 4'b0010;
                    3'b111: alu_control = 4'b0000;
                    3'b110: alu_control = 4'b0001;
                    3'b010: alu_control = 4'b0111;
                    default: alu_control = 4'b0000;
                endcase
            end
            default: alu_control = 4'b0000;
        endcase
    end
endmodule

