`timescale 10ns/1ns
`include "../src/hdl/Clock.v"
`include "../src/hdl/Counter.v"

/* commands to enter after running iverilog

rm *.out *.vcd && iverilog -o _.out Clock_tb.v && vvp -v _.out && gtkwave *.vcd

notes

iverilog Display_Digits_tb.v # Defaults to a.out
vvp -v a.out
gtkwave Display_Digits_tb.vcd

*/

module Clock_tb();

    reg clk;
    reg rst;
    wire clkOut;
    wire [3:0] number;
    
    Clock #(.BOARD_CLOCK_FREQUENCY_IN_HZ(10), .OUTPUT_CLOCK_PERIOD_IN_SECONDS(1)) clock_tb(.clk(clk), .rst(rst), .clkOut(clkOut));
    
    Counter counter(.clk(clk), .rst(rst), .enable(clkOut), .numberIn(number), .numberOut(number));
    
    integer i = 0;
    
    initial begin
    
        $monitor("%100d\n", $time);
        $dumpfile("Clock_tb.vcd");
        $dumpvars(0, Clock_tb);
        
        clk = 0;
        rst = 0;
        #1;
        rst = 1;
        #1;
        rst = 0;
        
        for (i=0; i<100; i=i+1) begin
            #1;
            clk = ~clk;
        end
    
    end

endmodule
