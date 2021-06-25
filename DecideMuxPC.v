`timescale 1ns/1ns

module DecideMuxPC(tos_Stack, next, jump, decide);
	input next, jump;
	input[7:0] tos_Stack;
	output decide;

	assign decide = next || (~jump && |tos_Stack);

endmodule