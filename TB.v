`timescale 1ns/1ns

module TB ();
    reg clk = 1'b0;
    reg rst = 1'b0;

    MIPS_Stack UUT(clk, rst);

    always #4 clk = ~clk;

    initial begin
        $readmemb("./TestOne.bin", UUT.datapath.Memory.file);
        $readmemb("./Data.mem", UUT.datapath.Memory.file, 16);
    end
endmodule