`timescale 10ns/1ns
`include "../hdl/Counter3.v "

/* commands to enter after running iverilog

rm *.out *.vcd && iverilog -o _.out Counter_tb.v && vvp -v _.out && gtkwave Counter3_tb.vcd

*/

module Counter3_tb();

    reg clk;
    reg rst;
    reg enable;
    reg up_down;
    reg [3:0] numberIn;
    reg [3:0] numberOut;
    
    

endmodule


