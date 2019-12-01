module clkDivider (
    input wire clk,  // clock
    input wire rst,
    output wire clkOut
  );
  // 10111 11010 11110 00010 00000 00 //27 bit
//   integer count;
  
  wire [63:0] display_refresh_clock;
  
  assign clkOut = (|display_refresh_clock)? 0:1;
  
  Counter #(.BASE(125_000), .NUMBER_OF_NYBLES(16)) counter(.clk(clk), .rst(1'b0), .enable(1'b1), .numberIn(display_refresh_clock), .numberOut(display_refresh_clock)); // 2^20 = 1048576
  
endmodule
