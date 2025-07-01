module DMEM (
    clk,
    addr,
    write_data,
    mem_read,
    mem_write,
    read_data
);
    input clk;
    input [31:0] addr;
    input [31:0] write_data;
    input mem_read;
    input mem_write;
    output [31:0] read_data;

    reg [31:0] memory [0:255];
    reg [31:0] read_data_internal;

    assign read_data = (mem_read) ? read_data_internal : 32'b0;

    always @(*) begin
        read_data_internal = memory[addr[9:2]];
    end

    always @(posedge clk) begin
        if (mem_write) begin
            memory[addr[9:2]] <= write_data;
        end
    end
endmodule

