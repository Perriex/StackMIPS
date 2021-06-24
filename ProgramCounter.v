`timescale 1ns/1ns

module programCounter(clk, nextAddr, currAddr, PCL);
input [4:0] nextAddr;
input clk, PCL;
output reg [4:0] currAddr = 0;
	always@(posedge clk)begin
		if (PCL)
			currAddr <= nextAddr;
	end
endmodule