`timescale 1ns/1ns
module Controller(opcode,clk, rst, next, jump, PCL, LorD, MR, MW, LR, StackSrc,RegDst,
		ToS, Push, Pop, LA, LB, Ain, Bin, ALUop);
	input[2:0] opcode;
	input rst, clk;
	output reg next, jump, PCL, LorD, MR, MW, LR, StackSrc, 
		ToS, Push, Pop, LA, LB, Ain, Bin, RegDst;
	output reg[1:0] ALUop;

	reg[3:0] ps = 0, ns = 0;

	
parameter [3:0]
	IF = 0, ID = 1, RTYPE = 2, PUSH = 3, POP = 4, JZ = 5, JUMP = 6, SP = 7,
	ALU = 8, Save = 9;

	always@(ps,opcode)begin
		case(ps)
			IF    : ns = ID;
			ID    : ns = 	opcode == 3'b011 ? Save ://Not
					opcode == 3'b100 ? PUSH :
					opcode == 3'b101 ? POP  :
					opcode == 3'b110 ? JUMP :
					opcode == 3'b111 ? JZ   : RTYPE;
			RTYPE : ns = SP  ;
			PUSH  : ns = 0   ;
			POP   : ns = 0   ;
			JZ    : ns = 0   ;
			JUMP  : ns = 0   ;
			SP    : ns = ALU ;
			ALU   : ns = Save;
			Save  : ns = 0   ;
			default: ns = 0;
		endcase
	end

	always@(posedge clk,posedge rst)begin
		if(rst)
			ps <= IF;
		else
			ps <= ns;
	end

	always@(ps)begin
	{next, jump, PCL, LorD, MR, MW, LR, RegDst,
		StackSrc, ToS, Push, Pop, LA, LB, Ain, Bin,
		ALUop} = 0;
		case(ps)
			IF    : begin next = 1; PCL = 1; LorD = 1; MR = 1; LR = 1; Ain = 1; Bin = 0; ALUop=0;	end
			ID    : begin ToS = 1; RegDst=0; LA = 1;  						end
			RTYPE : begin Pop = 1; ALUop = 3; 							end
			PUSH  : begin MR = 1; LorD = 0; Push = 1; StackSrc = 0;  				end
			POP   : begin MW = 1; LorD = 0; Pop = 1;  						end
			JZ    : begin jump = 0; next = 1; PCL = 1;  						end
			JUMP  : begin jump = 1; next = 0; PCL = 1;  						end
			SP    : begin Pop = 1; ToS = 1; RegDst = 1; LB = 1;  					end
			ALU   : begin Ain = 0; Bin = 1; ALUop = opcode[1:0];  					end
			Save  : begin StackSrc = 1; Push = 1;  							end
		endcase
	end

endmodule