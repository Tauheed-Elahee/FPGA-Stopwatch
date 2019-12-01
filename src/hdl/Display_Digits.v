module Display_Digits (
    clk,
    number,
    io_sel,
    io_seg
  );
  
  parameter NUMBER_OF_DIGITS = 1;
  
  input wire clk;  // clock
  input wire [((NUMBER_OF_DIGITS*4)-1):0] number;  // reset
  output wire [3:0] io_sel;
  output wire [7:0] io_seg;

  wire [63:0] display_refresh_clock_counter;
  wire display_refresh_clock;
  wire [63:0] count;
  wire [3:0] selected_number;

  /* Combinational Logic */
  Counter #(.BASE(500_000), .NUMBER_OF_NYBLES(16)) refresh_rate_generator(.clk(clk), .rst(1'b0), .enable(1'b1), .numberIn(display_refresh_clock_counter), .numberOut(display_refresh_clock_counter)); // 2^20 = 1048576
  
  assign display_refresh_clock = (|display_refresh_clock_counter)? 0:1;
  
  Counter #(.BASE(NUMBER_OF_DIGITS), .NUMBER_OF_NYBLES(16)) number_selector(.clk(display_refresh_clock), .rst(1'b0), .enable(1'b1), .numberIn(count), .numberOut(count));
  
  assign io_sel[3:0] = ~(1 << count);
  assign selected_number[3] = number[(count*4)+3];
  assign selected_number[2] = number[(count*4)+2];
  assign selected_number[1] = number[(count*4)+1];
  assign selected_number[0] = number[(count*4)+0];
  
  BCD_n bcd(.number(selected_number[3:0]), .digit_n(io_seg[6:0]));
  assign io_seg[7] = (count == 2)? 1'b0:1'b1;
  
endmodule
