`timescale 10ns/1ns

`include "../hdl/BCD.v"
`include "../hdl/BCD_n.v"
`include "../hdl/Counter.v"
`include "../hdl/Clock.v"
`include "../hdl/Display_Digits.v"

/* commands to enter after running iverilog

rm *.out *.vcd && iverilog -o _.out Display_Digits_tb.v && vvp -v _.out && gtkwave *.vcd

notes

iverilog Display_Digits_tb.v # Defaults to a.out
vvp -v a.out
gtkwave Display_Digits_tb.vcd

*/

// Cannot do simulation due to the inablity to reset unknown values to 0.

module Display_Digits_tb();
    
    // inputs
    reg clk;
    reg [3:0] seconds_1;
    reg [3:0] seconds_10;
    reg [3:0] minutes_1;
    
    // outputs
    wire [3:0] io_sel;
    wire [7:0] io_seg;
    
    
    Display_Digits #(.NUMBER_OF_DIGITS(3), .REFRESH_RATE_IN_HERTZ(10), .BOARD_CLOCK_FREQUENCY_IN_HZ(60)) dut (.clk(clk), .number({minutes_1[3:0], seconds_10[3:0], seconds_1[3:0]}), .io_sel(io_sel), .io_seg(io_seg));
    
    integer i = 0;
    
    initial begin
        
        $monitor("t=%3d:\tseconds_1=%4d, seconds_10=%4d, io_sel=%4b, io_seg=%8b\n", $time, seconds_1[3:0], seconds_10[3:0], io_sel[3:0], io_seg[7:0]);
        $dumpfile("Display_Digits_tb.vcd");
        $dumpvars(0, Display_Digits_tb);
    
        clk = 0;
        seconds_1[3:0] = 4'd0;
        seconds_10[3:0] = 4'd0;
        minutes_1[3:0] = 4'd0;
        
        for(i=0; i<30000; i=i+1) begin
            #1;
            clk = ~clk;
            if(!(i%60)) seconds_1[3:0] = ((0 <= seconds_1[3:0]) && (seconds_1[3:0] < 9))? (seconds_1[3:0] + 1):4'b0;
            if(!(i%600)) seconds_10[3:0] = ((0 <= seconds_1[3:0]) && (seconds_10[3:0] < 5))? (seconds_10[3:0] + 1):4'b0;
            if(!(i%6000)) minutes_1[3:0] = ((0 <= minutes_1[3:0]) && (minutes_1[3:0] < 9))? (minutes_1[3:0] + 1):4'b0;
        end
        $finish;
    
    end
    
endmodule
