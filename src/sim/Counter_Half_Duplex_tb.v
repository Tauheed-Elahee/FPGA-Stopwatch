`timescale 10ns/1ns
`include "../hdl/Counter_Half_Duplex.v"

/* commands to enter after running iverilog

rm *.out *.vcd && iverilog -o _.out Counter_Half_Duplex_tb.v && vvp -v _.out && gtkwave *.vcd

*/

module Counter_tb();

    reg clk;  // clock
    reg rst;  // reset
    reg enable;
    reg up_down;
    reg set;
    wire [3:0] number;
    reg [3:0] set_number;
    
    assign number = (set)? set_number:'bz;
    
    Counter_Half_Duplex /*#(.EXPOSE_NUMBER(1))*/ dut(.clk(clk),
                .rst(rst),
                .enable(enable),
                .up_down(up_down),
                .set(set),
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
        set = 0;
        #1;
        clk = 1;
        #1;
        clk = 0;
        rst = 0;
        
        for (num_cycles=0; num_cycles<22; num_cycles=num_cycles+1) begin
            #1;
            clk = ~clk;
        end
        
        set = 1;
        set_number = 4'd5;
        #1;
        clk = 1;
        #1;
        clk = 0;
        set = 0;
        
        for (num_cycles=0; num_cycles<22; num_cycles=num_cycles+1) begin
            #1;
            clk = ~clk;
        end
        
    end

endmodule
