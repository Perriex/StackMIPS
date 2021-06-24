
module MIPS_Stack(input clk, rst);


	wire[2:0] opcode;
	wire[1:0] ALUop;
	wire next, jump, PCL, LorD, MR, MW, LR, StackSrc, ToS, Push, Pop, LA, LB, Ain, Bin, RegDst;

	Datapath datapath(clk, LorD, MR, MW, StackSrc, ToS, Push, Pop, RegDst, LA , LB, Ain, Bin, ALUop, next, jump, opcode);
	
	Controller controller(opcode,clk, rst, next, jump, PCL, LorD, MR, MW, LR, StackSrc, RegDst, ToS, Push, Pop, LA, LB, Ain, Bin, ALUop);

endmodule