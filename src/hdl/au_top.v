module au_top(
    input wire clk,
    input wire rst_n,
    input wire [23:0] io_dip,
    input wire [4:0] io_button,
    output wire [7:0] led,
    output wire [23:0] io_led,
    output wire [3:0] io_sel,
    output wire [7:0] io_seg,
    input wire usb_rx,
    output wire usb_tx
    );
    
    wire rst;
    
    debouncer reset_conditioner(  .clk(clk),
                                  .in(!rst_n),
                                  .out(rst)
                               );
    
    wire [15:0] number;
    
    
    CounterModule #(.NUMBER_OF_DIGITS(4), .NUMBER_OF_BITS_PER_DIGIT(4)) counterModule(.clk(clk), .rst(rst), .enable(io_dip[1]), .up_down(io_dip[0]), .number(number[15:0]));
    
    
    assign led [7:4] = number [7:4];
    assign led [3:0] = number [3:0];
    
    assign io_led [23] = io_dip[0];
    assign io_led [22] = io_dip[1];
    assign io_led [21] = io_button[0];
    assign io_led [20] = io_button[1];
    assign io_led [19] = io_button[2];
    assign io_led [18] = io_button[3];
    assign io_led [17] = io_button[4];
    //assign io_led [16] = |io_dip[23:2];
    Blinker #(.BOARD_CLOCK_FREQUENCY_IN_HZ(100_000_000), .OUTPUT_CLOCK_FREQUENCY_IN_HZ(10)) blinker(.clk(clk), .rst(rst), .blink(io_led[16]));
    
    
    assign io_led [15:12] = number [15:12];
    assign io_led [11:8] = number [11:8];
    assign io_led [7:4] = number [7:4];
    assign io_led [3:0] = number [3:0];
    
    // It works with 3 displays but not 4. It is the combined dark majic of Alchitry and Vivado that prevents good verilog from being implemented. IT IS VERY PICKY ABOUT REFRESH RATES
    Display_Digits #(   .NUMBER_OF_DIGITS(4),
                        .REFRESH_RATE_IN_HERTZ(72),
                        .BOARD_CLOCK_FREQUENCY_IN_HZ(100_000_000)
                    )
                    display_digits( .clk(clk),
                                    .number(number[15:0]),
                                    .set_mode(io_dip[2]),
                                    .io_sel(io_sel),
                                    .io_seg(io_seg)
                    );
    
    assign usb_tx = usb_rx;
    
endmodule
