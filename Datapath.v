`timescale 1ns/1ns

module Datapath(clk, LorD, read, write, StackSrc, tos, push, pop, RegDst,LA , LB, Ain, Bin, ALUop, next, jump, opcode, PCL, LR);
	input clk, LorD, read, write, StackSrc, tos, push, pop, RegDst, LA, LB, Ain, Bin, next, jump, PCL, LR;
	input [1:0] ALUop;
	output[2:0] opcode;
	
	wire[7:0] regA;

	wire decide;
	DecideMuxPC instDecide(regA, next, jump, decide);
	

	wire[7:0] outALU;


	wire[7:0] IR;
	wire[4:0] nextAddr;
	Mux#(5) mux0(decide, IR[4:0], outALU[4:0], nextAddr );
	

	wire[4:0] currAddr;
	programCounter PC(clk, nextAddr, currAddr, PCL);


	wire[4:0] selectLorD;
	Mux#(5) mux1(LorD, IR[4:0], currAddr, selectLorD );
	
	
	wire[7:0] readData;
	MemoryBlock Memory(clk, selectLorD, write, read, regA, readData);

	EnRegister IRreg(clk, readData, IR, LR);

	assign opcode = IR[7:5];

	wire[7:0] regALU;
	
	wire[7:0] selectStackSrc;
	Mux#(8) mux2(StackSrc, readData, regALU, selectStackSrc );


	wire[7:0] outStack;
	Stack stack(clk, selectStackSrc, outStack, tos, push, pop);

	wire[7:0] regB;

	EnRegister Areg(clk, outStack, regA, LA);
	EnRegister Breg(clk, outStack, regB, LB);

	wire[7:0] selectAin;
	Mux#(8) mux3(Ain, regA, {{3{currAddr[4]}}, currAddr} , selectAin );
 

	wire[7:0] selectBin;
	Mux#(8) mux4(Bin, 8'b00000001, regB, selectBin );


	ALU instALU(selectAin, selectBin, ALUop, outALU);


	EnRegister ALUreg(clk, outALU, regALU, 1'b1);

endmodule
