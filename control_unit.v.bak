module control_unit (
    opcode,
    alu_op,
    alu_src,
    mem_to_reg,
    reg_write,
    mem_read,
    mem_write,
    branch,
    jump,
    pc_src
);
    input [6:0] opcode;
    output [1:0] alu_op;
    output [1:0] alu_src;
    output mem_to_reg;
    output reg_write;
    output mem_read;
    output mem_write;
    output branch;
    output jump;
    output [1:0] pc_src;

    reg [1:0] alu_op;
    reg [1:0] alu_src;
    reg mem_to_reg;
    reg reg_write;
    reg mem_read;
    reg mem_write;
    reg branch;
    reg jump;
    reg [1:0] pc_src;

    always @(*) begin
        alu_op      = 2'b00;
        alu_src     = 2'b00;
        mem_to_reg  = 1'b0;
        reg_write   = 1'b0;
        mem_read    = 1'b0;
        mem_write   = 1'b0;
        branch      = 1'b0;
        jump        = 1'b0;
        pc_src      = 2'b00;

        case (opcode)
            7'b0110011: begin
                alu_op      = 2'b10;
                alu_src     = 2'b00;
                reg_write   = 1'b1;
            end

            7'b0010011: begin
                alu_op      = 2'b10;
                alu_src     = 2'b01;
                reg_write   = 1'b1;
            end

            7'b0000011: begin
                alu_op      = 2'b00;
                alu_src     = 2'b01;
                mem_to_reg  = 1'b1;
                reg_write   = 1'b1;
                mem_read    = 1'b1;
            end

            7'b0100011: begin
                alu_op      = 2'b00;
                alu_src     = 2'b01;
                mem_write   = 1'b1;
            end

            7'b1100011: begin
                alu_op      = 2'b01;
                branch      = 1'b1;
                pc_src      = 2'b01;
            end

            7'b1101111: begin
                alu_src     = 2'b01;
                reg_write   = 1'b1;
                jump        = 1'b1;
                pc_src      = 2'b01;
            end

            7'b1100111: begin
                alu_src     = 2'b01;
                reg_write   = 1'b1;
                jump        = 1'b1;
                pc_src      = 2'b10;
            end

            7'b0110111,
            7'b0010111: begin
                alu_src     = 2'b01;
                reg_write   = 1'b1;
            end

            default: begin
                // gi? m?c ??nh
            end
        endcase
    end
endmodule

