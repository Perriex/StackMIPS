`timescale 1ns/1ns

module Stack (clk, din, dout, tos, push, pop);
    
    input push, pop, tos, clk;
    input [7:0] din;

    output reg [7:0] dout;
    
    reg [7:0] file[31:0];
    reg [4:0] top = 0;

    always @(posedge clk) begin
        if(push) begin
            top <= top + 1;
            file[top] <= din;
        end
        if(pop)
            top <= top - 1;
    end

    assign dout = tos ? file[top - 1] : {8{1'bz}};
endmodule
