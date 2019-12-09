module Counter2 (   
    clk,  // clock
    rst,  // reset
    enable,
    numberIn,
    numberOut,
    threshold
  );
  parameter BASE = 10;
  parameter NUMBER_OF_NYBLES = 1;
  
  input wire clk;
  input wire rst;
  input wire enable;
  input wire [(NUMBER_OF_NYBLES*4-1):0] numberIn;
  output wire [(NUMBER_OF_NYBLES*4-1):0] numberOut;
  output wire threshold;
  
  Counter #(.BASE(BASE), .NUMBER_OF_NYBLES(NUMBER_OF_NYBLES)) counter(.clk(clk), .rst(rst), .enable(enable), .numberIn(numberIn), .numberOut(numberOut), .threshold(threshold));
  
  
  
endmodule
