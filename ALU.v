module ALU (
    src1,
    src2,
    alu_control,
    result,
    zero
);
    input [31:0] src1;
    input [31:0] src2;
    input [3:0] alu_control;
    output [31:0] result;
    output zero;

    reg [31:0] result;
    wire zero;

    assign zero = (result == 32'b0);

    always @(*) begin
        case (alu_control)
            4'b0000: result = src1 & src2;
            4'b0001: result = src1 | src2;
            4'b0010: result = src1 + src2;
            4'b0110: result = src1 - src2;
            4'b0111: result = ($signed(src1) < $signed(src2)) ? 32'b1 : 32'b0;
            4'b1100: result = ~(src1 | src2);
            default: result = 32'b0;
        endcase
    end
endmodule

