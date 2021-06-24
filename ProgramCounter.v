`timescale 1ns/1ns

module programCounter(clk, nextAddr, currAddr);
input [4:0] nextAddr;
input clk;
output reg [4:0] currAddr;
	always@(posedge clk)begin
		currAddr <= nextAddr;
	end
endmodule