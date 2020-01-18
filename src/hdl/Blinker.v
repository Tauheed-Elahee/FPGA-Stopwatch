module Blinker (
    input wire clk,  // clock
    input wire rst,  // reset
    output reg blink // blink
  );

  
  wire blink_toggle;
  
  Clock #(  .BOARD_CLOCK_FREQUENCY_IN_HZ(100_000_000),
              .OUTPUT_CLOCK_PERIOD_IN_SECONDS(1)
           )
           blinker(  .clk(clk),
                              .rst(rst),
                              .clkOut(blink_toggle)
                           );
  
  always @(posedge blink_toggle, posedge rst) begin
    if (rst) blink <= 0;
    else blink <= !blink;
  end
  
  
endmodule
