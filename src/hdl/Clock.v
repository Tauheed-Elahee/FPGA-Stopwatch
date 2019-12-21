module Clock (
    input wire clk,  // clock
    input wire rst,
    output wire clkOut
  );
  parameter BOARD_CLOCK_FREQUENCY_IN_HZ = 100_000_000;
  parameter OUTPUT_CLOCK_PERIOD_IN_SECONDS = 1;
  
  
  // localparams cannot be defined/depend on other local params. division is still ok.
  
//  localparam OUTPUT_CLOCK_FREQUENCY_IN_HZ = 1/OUTPUT_CLOCK_PERIOD_IN_SECONDS;
//   localparam MAX_COUNT = BOARD_CLOCK_FREQUENCY_IN_HZ / OUTPUT_CLOCK_FREQUENCY_IN_HZ;

  localparam MAX_COUNT = BOARD_CLOCK_FREQUENCY_IN_HZ * OUTPUT_CLOCK_PERIOD_IN_SECONDS - 1;
  
  
  // 10111 11010 11110 00010 00000 00 //27 bit
  reg [63:0] count;
  
  assign clkOut = ~|count;
  /*
  Counter3 #(.BASE(MAX_COUNT), .NUMBER_OF_BITS(64)) counter( .clk(clk),
                                                            .rst(rst),
                                                            .enable(1),
                                                            .up_down(1),
                                                            .numberIn(count),
                                                            .numberOut(count)
                                                          );
  */
  /* Sequential Logic */
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      count <= MAX_COUNT;
    end else begin
      if (count <= MAX_COUNT) begin
        count <= count - 1;
      end else begin
        count <= MAX_COUNT;
      end
    end
  end
  
endmodule
