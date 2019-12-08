`timescale 10ns/1ns
`include "../hdl/Counter.v"

/* commands to enter after running iverilog

rm *.out *.vcd && iverilog -o _.out Counter_tb.v && vvp -v _.out && gtkwave *.vcd

*/

module Counter_tb();

    reg clk;  // clock
    reg rst;  // reset
    reg enable;
    reg [3:0] numberIn;
    wire [3:0] numberOut;
    
    Counter dut(.clk(clk),
                .rst(rst),
                .enable(enable),
                .numberIn(numberIn[3:0]),
                .numberOut(numberOut[3:0])
                );
    
    integer num_cycles = 0;
    
    initial begin
    
        $monitor("%64d\n", num_cycles);
        $dumpfile("Counter_tb.vcd");
        $dumpvars(0, Counter_tb);
        
        clk = 0;
        rst = 0;
        enable = 1;
        numberIn = 4'd0;
        
        for (num_cycles=0; num_cycles<22; num_cycles=num_cycles+1) begin
            #1;
            clk = ~clk;
            numberIn <= numberOut;
        end
        
    end

endmodule
