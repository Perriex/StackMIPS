`timescale 1ns/1ns
module Mux#(parameter n)(s, a, b, c );

	input s ;
	input[n:0] a,b;
	output[n:0] c;	
	assign c = s ? b : a;

endmodule