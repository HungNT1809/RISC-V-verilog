module IMEM (
    addr,
    instr
);
    input [31:0] addr;
    output [31:0] instr;

    reg [31:0] memory [0:255];
    wire [31:0] instr;

    assign instr = memory[addr[9:2]];

    initial begin
        memory[0] = 32'h00000293; // addi x5, x0, 0
        memory[1] = 32'h00100313; // addi x6, x0, 1
        memory[2] = 32'h0062b3b3; // add x7, x5, x6
        memory[3] = 32'h0072a023; // sw x7, 0(x5)
        memory[4] = 32'h00000013; // nop
    end
endmodule

