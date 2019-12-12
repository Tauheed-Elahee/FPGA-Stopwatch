module Counter2 (   
    clk,  // clock
    rst,  // reset
    enable,
    up_down,
    numberIn,
    numberOut,
    threshold
  );
  parameter BASE = 10;
  parameter NUMBER_OF_BITS = 4;
  
  input wire clk;
  input wire rst;
  input wire enable;
  input wire up_down;
  input wire [(NUMBER_OF_BITS-1):0] numberIn;
  output wire [(NUMBER_OF_BITS-1):0] numberOut;
  output wire threshold;
  
  Counter3 #(.BASE(BASE), .NUMBER_OF_BITS(NUMBER_OF_BITS)) counter(.clk(clk), .rst(rst), .enable(enable), .up_down(up_down), .numberIn(numberIn), .numberOut(numberOut), .threshold(threshold));
  
  
  
endmodule
