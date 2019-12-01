module au_top(
    input wire clk,
    input wire rst_n,
    output wire [7:0] led,
    output wire [23:0] io_led,
    output wire [3:0] io_sel,
    output wire [7:0] io_seg,
    input wire usb_rx,
    output wire usb_tx
    );
    
    wire rst;
    wire clock_seconds_1;
    wire [3:0] seconds_1;
    wire [3:0] seconds_10;
    wire [3:0] minutes_1;
    
    wire [4:0] threshold;
    
    reset_debouncer reset_conditioner(.clk(clk), .in(!rst_n), .out(rst));
    
    
    // does not handle division in the inputs properly.
    Clock #(.BOARD_CLOCK_FREQUENCY_IN_HZ(100_000_000), .OUTPUT_CLOCK_PERIOD_IN_SECONDS(1)) one_second_clock(.clk(clk), .rst(rst), .clkOut(clock_seconds_1));
    
    assign threshold[1] = clock_seconds_1 & threshold[0];
    assign threshold[3] = clock_seconds_1 & threshold[0] & threshold[2];
    
    Counter #(.BASE(10)) counterSeconds1(.clk(clk), .rst(rst), .enable(clock_seconds_1), .numberIn(seconds_1[3:0]), .numberOut(seconds_1[3:0]), .threshold(threshold[0]));
    Counter #(.BASE(6)) counterSeconds10(.clk(clk), .rst(rst), .enable(threshold[1]), .numberIn(seconds_10[3:0]), .numberOut(seconds_10[3:0]), .threshold(threshold[2]));
    
    Counter #(.BASE(10)) counterMinutes1(.clk(clk), .rst(rst), .enable(threshold[3]), .numberIn(minutes_1[3:0]), .numberOut(minutes_1[3:0]), .threshold(threshold[4]));
    
    
    assign led [7:4] = seconds_10 [3:0];
    assign led [3:0] = seconds_1 [3:0];
    
    assign io_led [23:12] = 16'b1111_1111__1111;
    assign io_led [11:8] = minutes_1 [3:0];
    assign io_led [7:4] = seconds_10 [3:0];
    assign io_led [3:0] = seconds_1 [3:0];
    
    Display_Digits #(.NUMBER_OF_DIGITS(3)) display_digits(.clk(clk), .number({minutes_1[3:0], seconds_10[3:0], seconds_1[3:0]}), .io_sel(io_sel), .io_seg(io_seg));
    
    assign usb_tx = usb_rx;
    
endmodule
