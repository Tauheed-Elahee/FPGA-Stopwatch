module CounterModule   #(
                            parameter NUMBER_OF_DIGITS = 4;
                            parameter NUMBER_OF_BITS_PER_DIGIT = 4;
                        )
                        (   
                            input wire clk,  // clock
                            input wire rst,  // reset
                            input wire enable, // needed but not implemented now.
                            input wire up_down,
                            input wire [(NUMBER_OF_BITS-1):0] number // hope vivado does not throw an error otherwise do the wire declareation after the definition of local paramter
                        );
    
    localparam NUMBER_OF_BITS = NUMBER_OF_DIGITS * NUMBER_OF_BITS_PER_DIGIT;

  
  wire clock_seconds_1;
  wire [3:0] seconds_1 = number[3:0];
  wire [3:0] seconds_10 = number[7:4];
  wire [3:0] minutes_1 = number[11:8];
  wire [3:0] minutes_10 = number[15:12];
  
  wire [(NUMBER_OF_DIGITS-1):0] enable_wire;
  wire [(NUMBER_OF_DIGITS-1):0] threshold;
  
  // does not handle division in the inputs properly.
    Clock #(  .BOARD_CLOCK_FREQUENCY_IN_HZ(100_000_000), // Alchitry does not understand Verilog and as such changing how numbers are update changes the display even though it shouldn't.
              .OUTPUT_CLOCK_PERIOD_IN_SECONDS(1)
           )
           one_second_clock(  .clk(clk),
                              .rst(rst),
                              .clkOut(clock_seconds_1)
                           );
    
    assign enable_wire[0] = clock_seconds_1 & enable;
    assign enable_wire[1] = enable_wire[0] & threshold[0];
    assign enable_wire[2] = enable_wire[1] & threshold[1];
    assign enable_wire[3] = enable_wire[2] & threshold[2];
    
    // Alchitry labs cannot understand project hierachry and so a seperate Counter file must be created in order for Alchitry Labs to tell Vivado where it is.
    // The doublicate counter was changed to a wrapper for the counter file.
    
    Counter #(.BASE(10), .NUMBER_OF_BITS(NUMBER_OF_BITS_PER_DIGIT)) counterSeconds1(  .clk(clk),
                                            .rst(rst),
                                            .enable(enable_wire[0]),
                                            .up_down(up_down),
                                            .numberIn(seconds_1[3:0]),
                                            .numberOut(seconds_1[3:0]),
                                            .threshold(threshold[0])
                                         );
    Counter #(.BASE(6), .NUMBER_OF_BITS(NUMBER_OF_BITS_PER_DIGIT)) counterSeconds10(  .clk(clk),
                                            .rst(rst),
                                            .enable(enable_wire[1]),
                                            .up_down(up_down),
                                            .numberIn(seconds_10[3:0]),
                                            .numberOut(seconds_10[3:0]),
                                            .threshold(threshold[1])
                                         );
    
    Counter #(.BASE(10), .NUMBER_OF_BITS(NUMBER_OF_BITS_PER_DIGIT)) counterMinutes1(  .clk(clk),
                                            .rst(rst),
                                            .enable(enable_wire[2]),
                                            .up_down(up_down),
                                            .numberIn(minutes_1[3:0]),
                                            .numberOut(minutes_1[3:0]),
                                            .threshold(threshold[2])
                                         );
    Counter #(.BASE(6), .NUMBER_OF_BITS(NUMBER_OF_BITS_PER_DIGIT)) counterMinutes10(  .clk(clk),
                                            .rst(rst),
                                            .enable(enable_wire[3]),
                                            .up_down(up_down),
                                            .numberIn(minutes_10[3:0]),
                                            .numberOut(minutes_10[3:0]),
                                            .threshold(threshold[3])
                                         );
  
endmodule
