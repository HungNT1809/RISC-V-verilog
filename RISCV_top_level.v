module RISCV_Single_Cycle (
    clk,
    rst_n,
    Instruction_out_top
);

    input clk;
    input rst_n;
    output [31:0] Instruction_out_top;

    wire [31:0] pc, next_pc, instr;
    wire [4:0] rs1, rs2, rd;
    wire [31:0] reg_data1, reg_data2, write_data;
    wire [31:0] imm_ext;
    wire [3:0] alu_control;
    wire [31:0] alu_result;
    wire alu_zero;

    wire [1:0] alu_src;
    wire mem_to_reg, reg_write, mem_read, mem_write, branch, jump;
    wire [1:0] pc_src;

    wire [1:0] alu_op;
    wire [31:0] alu_src2;
    wire [31:0] mem_out;

    // Instruction memory
    IMEM IMEM_inst (
        .addr(pc),
        .instr(instr)
    );

    // Program Counter
    Program_Counter pc_reg (
        .clk(clk),
        .reset(~rst_n),
        .next_pc(next_pc),
        .pc(pc)
    );

    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign rd  = instr[11:7];

    // Register File
    RegisterFile regfile (
        .clk(clk),
        .we(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .rd_data(write_data),
        .rs1_data(reg_data1),
        .rs2_data(reg_data2)
    );

    // Immediate Generator
    Imm_Gen immgen (
        .instr(instr),
        .imm_out(imm_ext)
    );

    // ALU Decoder
    ALU_decoder alu_dec (
        .funct3(instr[14:12]),
        .funct7(instr[30]),
        .alu_op(alu_op),
        .alu_control(alu_control)
    );

    // Control Unit
    control_unit ctrl (
        .opcode(instr[6:0]),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .jump(jump),
        .pc_src(pc_src)
    );

    // ALU source mux
    assign alu_src2 = (alu_src == 2'b00) ? reg_data2 :
                      (alu_src == 2'b01) ? imm_ext : 32'b0;

    // ALU
    ALU alu (
        .src1(reg_data1),
        .src2(alu_src2),
        .alu_control(alu_control),
        .result(alu_result),
        .zero(alu_zero)
    );

    // Branch comparator
    Branch_Comp branch_comp (
        .rs1(reg_data1),
        .rs2(reg_data2),
        .branch(branch),
        .zero(alu_zero)
    );

    // Data memory
    DMEM DMEM_inst (
        .clk(clk),
        .addr(alu_result),
        .write_data(reg_data2),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .read_data(mem_out)
    );

    // Write-back mux
    assign write_data = mem_to_reg ? mem_out : alu_result;

    // Next PC logic
    assign next_pc = (pc_src == 2'b00) ? pc + 4 :
                     (pc_src == 2'b01) ? pc + imm_ext :
                     (pc_src == 2'b10) ? reg_data1 + imm_ext : 32'b0;

endmodule

