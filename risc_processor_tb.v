//============================= TESTBENCH ======================================
module risc_processor_tb;
    reg clk,rst;

    risc_processor_top dut(clk,rst);

    initial clk=0;
    always #5 clk=~clk;

    initial begin
        $dumpfile("risc.vcd");
        $dumpvars(0,risc_processor_tb);

        rst=1;
        #20 rst=0;

        #200;
        $finish;
    end
endmodule



