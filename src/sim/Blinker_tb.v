`timescale 10ns/1ns
`include "../hdl/Counter.v"
`include "../hdl/Clock.v"
`include "../hdl/Blinker.v"

/* commands to enter after running iverilog

rm *.out *.vcd && iverilog -o _.out Blinker_tb.v && vvp -v _.out && gtkwave *.vcd

notes

iverilog Display_Digits_tb.v # Defaults to a.out
vvp -v a.out
gtkwave Display_Digits_tb.vcd

*/

module Blinker_tb();

    reg clk;
    reg rst;
    wire blink;
    
    Blinker #(.BOARD_CLOCK_FREQUENCY_IN_HZ(100_000_000)) blinker_tb(.clk(clk), .rst(rst), .blink(blink));
    
    integer i = 0;
    
    initial begin
    
        $monitor("%100d\n", $time);
        $dumpfile("Blinker_tb.vcd");
        $dumpvars(0, Blinker_tb);
        
        clk = 0;
        rst = 1;
        #1;
        clk = 1;
        rst = 1;
        #8;
        clk = 0;
        rst = 0;
        #1;
        
        for (i=0; i<1000_000_000; i=i+1) begin
            clk <= !clk;
            #1;
        end
        
    end

endmodule
