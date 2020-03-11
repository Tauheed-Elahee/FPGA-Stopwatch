`timescale  1ns/1ns
`include "../source/au_top.v"
`include "../source/BCD_n.v"
`include "../source/Clock.v"
`include "../source/Counter.v"
`include "../source/Display_Digits.v"
`include "../source/reset_debouncer.v"

/* commands to enter after running iverilog

rm *.out *.vcd && iverilog -o _.out top_tb.v && vvp -v _.out && gtkwave *.vcd

*/

// TODO: Need to fix this sim to figure out what is going on with Set_Number module

module top_tb();

    // inputs
    reg clk,
        rst_n,
        usb_rx;
    
    // outputs
    wire [7:0] led;
    wire [23:0] io_led;
    wire [3:0] io_sel;
    wire [7:0] io_seg;
    wire usb_tx;
    
    au_top dut( .clk(clk),
                .rst_n(rst_n),
                .led(led[7:0]),
                .io_led(io_led[23:0]),
                .io_sel(io_sel[3:0]),
                .io_seg(io_seg),
                .usb_rx(usb_rx),
                .usb_tx(usb_tx)
               );
    
    integer num_cycles = 0;
    integer repitions = 0;
    
    initial begin
    
        $monitor("%64d\n", num_cycles);
        $dumpfile("top_dut.vcd");
        $dumpvars(0, top_tb);
        
        clk = 0;
        rst_n = 0;
        usb_rx = 0;
        
        for (repitions=0; repitions<5; repitions=repitions+1) begin
        
        #1000000000;
        
        for (num_cycles=0; num_cycles<5000; num_cycles = num_cycles+1) begin
            if(!(num_cycles%5)) clk = ~clk;
            #1;
        end
        
        end
        
        $finish;
    
    end

endmodule
