`timescale 1ns/1ns

module Datapath(clk, LorD, read, write, StackSrc, tos, push, pop, RegDst,LA , LB, Ain, Bin, ALUop, next, jump, opcode);
	input clk, LorD, read, write, StackSrc, tos, push, pop, RegDst, LA, LB, Ain, Bin, ALUop, next, jump;
	output[2:0] opcode;
	
	reg[7:0] regA;

	wire decide;
	DecideMuxPC instDecide(regA, next, jump, decide);
	

	wire[7:0] outALU;


	reg[7:0] IR;
	wire[4:0] nextAddr;
	Mux#(4) mux0(decide, IR[4:0], outALU, nextAddr );
	

	wire[4:0] currAddr;
	programCounter PC(clk, nextAddr, currAddr);


	wire[4:0] selectLorD;
	Mux#(4) mux1(LorD, IR[4:0], currAddr, selectLorD );
	
	
	wire[7:0] readData;
	MemoryBlock Memory(clk, selectLorD, write, read, regA, readData);

	
	assign IR = readData;
	

	assign opcode = IR[7:5];

	reg[7:0] regALU;
	
	wire[4:0] selectStackSrc;
	Mux#(4) mux2(StackSrc, readData, regALU, selectStackSrc );


	wire[7:0] outStack;
	Stack stack(clk, selectStackSrc, outStack, tos, push, pop);


	reg[7:0] outForA, outForB;
	always@(outStack)begin
		if(RegDst) outForA = outStack;
		else  outForB = outStack;
	end


	reg[7:0] regB;
	assign regA = LA ? outForA : regA;
	assign regA = LB ? outForB : regB;
	

	wire[4:0] selectAin;
	Mux#(7) mux3(StackSrc, regA, currAddr, selectAin );


	wire[4:0] selectBin;
	Mux#(7) mux4(StackSrc, 8'b00000001, regB, selectBin );


	ALU instALU(selectAin, selectBin, ALUop, outALU);


	assign regALU = outALU;


endmodule
