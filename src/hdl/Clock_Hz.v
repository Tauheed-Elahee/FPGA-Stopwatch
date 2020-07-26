module Clock_Hz #(
      parameter BOARD_CLOCK_FREQUENCY_IN_HZ		=	100_000_000,
      parameter OUTPUT_CLOCK_FREQUENCY_IN_HZ	=	1
    )
    (
      input wire clk,  // clock
      input wire rst,
      output wire clkOut
    );
  
  
  
  // localparams cannot be defined/depend on other local params. division is still ok.
  
//  localparam OUTPUT_CLOCK_FREQUENCY_IN_HZ = 1/OUTPUT_CLOCK_PERIOD_IN_SECONDS;
//   localparam MAX_COUNT = BOARD_CLOCK_FREQUENCY_IN_HZ / OUTPUT_CLOCK_FREQUENCY_IN_HZ;

  localparam MAX_COUNT = BOARD_CLOCK_FREQUENCY_IN_HZ / OUTPUT_CLOCK_FREQUENCY_IN_HZ;
  
  
  // 10111 11010 11110 00010 00000 00 //27 bit
  //wire [63:0] count;
  
  Counter2 #(.BASE(MAX_COUNT), .NUMBER_OF_BITS(64)) counter( .clk(clk),
                                                            .rst(rst),
                                                            .enable(1),
                                                            .up_down(1),
                                                            .threshold(clkOut)
                                                          );
  
endmodule
