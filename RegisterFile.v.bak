module RegisterFile (
    clk,
    we,
    rs1,
    rs2,
    rd,
    rd_data,
    rs1_data,
    rs2_data
);
    input clk;
    input we;
    input [4:0] rs1, rs2, rd;
    input [31:0] rd_data;
    output [31:0] rs1_data, rs2_data;

    reg [31:0] regs [0:31];
    wire [31:0] rs1_data, rs2_data;

    assign rs1_data = regs[rs1];
    assign rs2_data = regs[rs2];

    always @(posedge clk) begin
        if (we && rd != 5'd0) begin
            regs[rd] <= rd_data;
        end
    end

    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            regs[i] = 32'b0;
    end
endmodule

