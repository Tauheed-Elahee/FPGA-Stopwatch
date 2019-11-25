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
    wire clock_seconds_10;
    wire [3:0] seconds_1;
    wire [3:0] seconds_10;
    
    wire slowClk;
    
    clkDivider slowDown(.clk(clk), .rst(rst), .clkOut(slowClk));
    
    reset_debouncer reset_conditioner(.clk(clk), .in(!rst_n), .out(rst));
    
    //clkDivider clkDivider(.clk(clk), .rst(rst), .clkOut(clock_seconds_1));
    
    
    // does not handle division in the inputs properly.
    Clock #(.BOARD_CLOCK_FREQUENCY_IN_HZ(100_000_000), .OUTPUT_CLOCK_PERIOD_IN_SECONDS(1)) one_second_clock(.clk(clk), .rst(rst), .clkOut(clock_seconds_1));
    Clock #(.BOARD_CLOCK_FREQUENCY_IN_HZ(100_000_000), .OUTPUT_CLOCK_PERIOD_IN_SECONDS(10)) ten_second_clock(.clk(clk), .rst(rst), .clkOut(clock_seconds_10));
    
    Counter #(.BASE(10)) counterSeconds1(.clk(clk), .rst(rst), .enable(clock_seconds_1), .numberIn(seconds_1[3:0]), .numberOut(seconds_1[3:0]));
    Counter #(.BASE(6)) counterSeconds10(.clk(clk), .rst(rst), .enable(clock_seconds_10), .numberIn(seconds_10[3:0]), .numberOut(seconds_10[3:0]));
    
    
    assign led [7:4] = seconds_10 [3:0];
    assign led [3:0] = seconds_1 [3:0];
    
    assign io_led [23:8] = 16'b1111_1111__1111_1111;
    assign io_led [7:4] = seconds_10 [3:0];
    assign io_led [3:0] = seconds_1 [3:0];
    
    Display_Digits #(.NUMBER_OF_DIGITS(2)) display_digits(.clk(slowClk), .number({seconds_10[3:0], seconds_1[3:0]}), .io_sel(io_sel), .io_seg(io_seg));
    
    /*
    // 0 is on and 1 is off
    assign io_sel [3:0] = 4'b1110;
    //assign io_seg [7:0] = 8'b0000_1111;
    wire [7:0] digit_high_1;
    BCD bcd_1(seconds_1[3:0], digit_high_1[7:0]);
    
    assign io_seg [7:0] = ~digit_high_1 [7:0];
    */
    assign usb_tx = usb_rx;
    
endmodule
