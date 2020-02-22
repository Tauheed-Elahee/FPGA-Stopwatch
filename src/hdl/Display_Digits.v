module Display_Digits #(
      parameter NUMBER_OF_DIGITS = 1,
      parameter REFRESH_RATE_IN_HERTZ = 500,
      parameter BOARD_CLOCK_FREQUENCY_IN_HZ = 100_000_000
    )
    (
      input wire clk,  // clock
      input wire [((NUMBER_OF_DIGITS*4)-1):0] number,  // reset
      input wire set_mode,
      output wire [3:0] io_sel,
      output wire [7:0] io_seg
    );
  
  
  
  localparam NUMBER_OF_CLOCK_CYCLES_PER_REFRESH = BOARD_CLOCK_FREQUENCY_IN_HZ / REFRESH_RATE_IN_HERTZ / NUMBER_OF_DIGITS;
  
  
  wire [63:0] display_refresh_clock_counter;
  wire display_refresh_clock;
  wire [63:0] count;
  wire [3:0] selected_number;
  wire an;
  wire an_blink;

  /* Combinational Logic */
  
  // Cannot have EXPOSE_NUMBER parameter be set for some reason. It is the black majic of Alchitry. It works fine in Vivado.
  Counter #(.BASE(NUMBER_OF_CLOCK_CYCLES_PER_REFRESH), .NUMBER_OF_BITS(64)) refresh_rate_generator(.clk(clk), .rst(1'b0), .enable(1'b1), .up_down(1), .numberIn(display_refresh_clock_counter), .numberOut(display_refresh_clock_counter), .threshold(display_refresh_clock)); // 2^20 = 1048576
  
  Counter #(.BASE(NUMBER_OF_DIGITS), .NUMBER_OF_BITS(64)) number_selector(.clk(display_refresh_clock), .rst(1'b0), .enable(1'b1), .up_down(1), .numberIn(count), .numberOut(count));
  
  assign an_on = 1;
  Blinker #(.BOARD_CLOCK_FREQUENCY_IN_HZ(100_000_000), .OUTPUT_CLOCK_FREQUENCY_IN_HZ(10)) blinker(.clk(clk), .rst(rst), .blink(an_blink));
  assign an = (set_mode)? an_blink:1;
  
  assign io_sel[3:0] = ~(an << count);
  assign selected_number[3] = number[(count*4)+3];
  assign selected_number[2] = number[(count*4)+2];
  assign selected_number[1] = number[(count*4)+1];
  assign selected_number[0] = number[(count*4)+0];
  
  BCD_n bcd(.number(selected_number[3:0]), .digit_n(io_seg[6:0]));
  assign io_seg[7] = (count == 2)? 1'b0:1'b1;
  
endmodule
