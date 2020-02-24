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
    
    wire [15:0] number;
    
    wire rst;
    wire buttonTop;
    wire buttonCentre;
    wire buttonBottom;
    wire buttonLeft;
    wire buttonRight;
    
    wire up;
    wire down;
    wire left;
    wire right;
    
    wire set;
    
    wire [3:0] an;
    
    debouncer reset_conditioner(  .clk(clk),
                                  .in(!rst_n),
                                  .out(rst)
                               );
    
    debouncer up_conditioner(  .clk(clk),
                                  .in(io_button[0]),
                                  .out(buttonTop)
                               );
    
    debouncer centre_conditioner(  .clk(clk),
                                  .in(io_button[1]),
                                  .out(buttonCentre)
                               );
    
    debouncer down_conditioner(  .clk(clk),
                                  .in(io_button[2]),
                                  .out(buttonBottom)
                               );
    
    debouncer left_conditioner(  .clk(clk),
                                  .in(io_button[3]),
                                  .out(buttonLeft)
                               );
    
    debouncer right_conditioner(  .clk(clk),
                                  .in(io_button[4]),
                                  .out(buttonRight)
                               );
    
    Set_Number_Controler set_number_controler (.clk(clk), .rst(rst), .buttonUp(buttonTop), .buttonCentre(buttonCentre), .buttonDown(buttonBottom), .buttonLeft(buttonLeft), .buttonRight(buttonRight), .up(up), .set(set), .down(down), .left(left), .right(right));
    
    Set_Number #(.NUMBER_OF_DIGITS(4), .NUMBER_OF_BITS_PER_DIGIT(4)) set_number (.clk(clk), .rst(rst), .set(set), .up(up), .down(down), .left(left), .right(right), .number(number), .an(an));
    
    CounterModule #(.NUMBER_OF_DIGITS(4), .NUMBER_OF_BITS_PER_DIGIT(4)) counterModule(.clk(clk), .rst(rst), .enable(io_dip[1]), .up_down(io_dip[0]), .set(0), .number(number[15:0]));
    
    
    assign io_led [23] = io_dip[0];
    assign io_led [22] = io_dip[1];
    assign io_led [21] = io_button[0]; // top
    assign io_led [20] = io_button[1]; // centre
    assign io_led [19] = io_button[2]; // buttom
    assign io_led [18] = io_button[3]; // left
    assign io_led [17] = io_button[4]; // right
    assign io_led [16] = set;
    //Blinker #(.BOARD_CLOCK_FREQUENCY_IN_HZ(100_000_000), .OUTPUT_CLOCK_FREQUENCY_IN_HZ(10)) blinker(.clk(clk), .rst(rst), .blink(io_led[16]));
    
    
    assign led [7:4] = number [7:4];
    assign led [3:0] = number [3:0];
    
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
                                    .an(an),
                                    .io_sel(io_sel),
                                    .io_seg(io_seg)
                    );
    
    assign usb_tx = usb_rx;
    
endmodule
