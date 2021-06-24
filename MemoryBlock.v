`timescale 1ns/1ns

module MemoryBlock (clk, addr, write, read, writeData, readData);
    input clk, write, read;
    input [4:0] addr;
    input [7:0] writeData, readData;

    reg [7:0] file [31:0];
    assign readData = read ? file[addr] : readData;

    always @(posedge clk) begin
        if(write)
            file[addr] <= writeData;
    end
endmodule
