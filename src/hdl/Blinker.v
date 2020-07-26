module Blinker  #(
    parameter BOARD_CLOCK_FREQUENCY_IN_HZ	=	100_000_000,
    parameter OUTPUT_CLOCK_FREQUENCY_IN_HZ	=	1
  )
  (
    input wire clk,  // clock
    input wire rst,  // reset
    output reg blink // blink
  );

  
  wire blink_toggle;
  
  Clock_Hz #(  .BOARD_CLOCK_FREQUENCY_IN_HZ	(BOARD_CLOCK_FREQUENCY_IN_HZ),
               .OUTPUT_CLOCK_FREQUENCY_IN_HZ	(OUTPUT_CLOCK_FREQUENCY_IN_HZ * 2)
            )
            blinker(  .clk(clk),
                      .rst(rst),
                      .clkOut(blink_toggle)
                   );
  
  always @(posedge clk, posedge rst) begin
    if (rst) blink <= 0;
    else if (blink_toggle) blink <= ~blink;
  end
  
  
endmodule
