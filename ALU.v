`timescale 1ns/1ns

module ALU (lop, rop, op, result);
    input [1:0] op;
    input [7:0] lop, rop;
    output [7:0] result;

    parameter Add = 2'b00, Sub = 2'b01, And = 2'b10, Not = 2'b11;

    assign result = op == Add ? lop + rop :
                    op == Sub ? rop - lop ://lop is A
                    op == And ? lop & rop :
		    op == ~lop;
endmodule