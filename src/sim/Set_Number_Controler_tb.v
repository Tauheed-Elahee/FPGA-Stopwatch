`timescale 10ns/1ns
`include "../hdl/EdgeDetector.v"

/* commands to enter after running iverilog

rm *.out *.vcd && iverilog -o _.out Set_Number_Controler_tb.v && vvp -v _.out && gtkwave *.vcd

notes

iverilog Display_Digits_tb.v # Defaults to a.out
vvp -v a.out
gtkwave Display_Digits_tb.vcd

*/

module Set_Number_Controler_tb();

    reg clk;
    reg rst;
    reg signal;
    wire edgeDetected;
    
    EdgeDetector edgedetector_tb (.clk(clk), .rst(rst), .signal(signal), .detected(edgeDetected));
    
    integer i = 0;
    
    initial begin
    
        $monitor("%100d\n", $time);
        $dumpfile("Set_Number_Controler_tb.vcd");
        $dumpvars(0, Set_Number_Controler_tb);
        
        clk = 0;
        rst = 1;
        signal = 0;
        #1;
        clk = 1;
        rst = 1;
        #8;
        clk = 0;
        rst = 0;
        #1;
        
        for (i=0; i<100; i=i+1) begin
            clk <= !clk;
            signal <= (i%10)? signal:~signal;
            #1;
        end
        
    end

endmodule
