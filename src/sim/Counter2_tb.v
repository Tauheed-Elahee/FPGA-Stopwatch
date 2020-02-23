`timescale 10ns/1ns
`include "../hdl/Counter2.v"

/* commands to enter after running iverilog

rm *.out *.vcd && iverilog -o _.out Counter2_tb.v && vvp -v _.out && gtkwave *.vcd

*/

module Counter_tb();

    reg clk;  // clock
    reg rst;  // reset
    reg enable;
    reg up_down;
    wire [3:0] number;
    
    Counter2 dut(.clk(clk),
                .rst(rst),
                .enable(enable),
                .up_down(up_down),
                .number(number[3:0])
                );
    
    integer num_cycles = 0;
    
    initial begin
    
        $monitor("%64d\n", num_cycles);
        $dumpfile("Counter_tb.vcd");
        $dumpvars(0, Counter_tb);
        
        clk = 0;
        rst = 1;
        enable = 1;
        up_down = 1;
        #1;
        clk = 1;
        #1;
        clk = 0;
        rst = 0;
        
        for (num_cycles=0; num_cycles<22; num_cycles=num_cycles+1) begin
            #1;
            clk = ~clk;
        end
        
    end

endmodule
