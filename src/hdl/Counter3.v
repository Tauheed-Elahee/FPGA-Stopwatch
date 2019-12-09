module Counter3 (   
    clk,  // clock
    rst,  // reset
    enable,
    up_down,
    numberIn,
    numberOut,
    threshold
  );
  parameter BASE = 10;
  parameter NUMBER_OF_NYBLES = 1;
  
  input wire clk;
  input wire rst;
  input wire enable;
  input wire up_down;
  input wire [(NUMBER_OF_NYBLES*4-1):0] numberIn;
  output reg [(NUMBER_OF_NYBLES*4-1):0] numberOut;
  output wire threshold;
  
  wire [(NUMBER_OF_NYBLES*4-1):0] numberNext;
  wire [(NUMBER_OF_NYBLES*4-1):0] numberIncrement;
  wire [(NUMBER_OF_NYBLES*4-1):0] numberDecrement;
  
  /* Combinational Logic */
  assign numberIncrement = ((0 <= numberIn) && (numberIn < (BASE-1)))? numberIn+1:0;  // numberIn must be between [0:BASE-1[ for numberOut to be [0:BASE[ and be of base BASE
  assign numberDecrement = ((0 < numberIn) && (numberIn <= (BASE-1)))? numberIn-1:BASE-1;
  assign numberNext =  (up_down)? numberIncrement:numberDecrement;
  assign threshold = (up_down)? ((numberOut == BASE-1)? 1:0):((numberOut == 0)? 1:0);
  
  /* Sequential Logic */
  // Async rst
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      numberOut <= 8'b0;
    end else if (enable) begin
      numberOut <= numberNext;
    end
  end
  
endmodule
