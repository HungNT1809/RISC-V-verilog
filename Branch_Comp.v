module Branch_Comp (
    rs1,
    rs2,
    branch,
    zero
);
    input [31:0] rs1;
    input [31:0] rs2;
    input branch;
    output zero;

    reg zero;

    always @(*) begin
        if (branch && (rs1 == rs2))
            zero = 1'b1;
        else
            zero = 1'b0;
    end
endmodule

