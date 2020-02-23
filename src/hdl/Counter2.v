module Counter2 #(
      parameter BASE = 10,
      parameter NUMBER_OF_BITS = 4,
      parameter EXPOSE_NUMBER = 1
    )
    (   
      input wire clk,
      input wire rst,
      input wire enable,
      input wire up_down,
      output reg [(NUMBER_OF_BITS-1):0] number,
      output wire threshold
    );
  
  wire [(NUMBER_OF_BITS-1):0] numberIncrement;
  wire [(NUMBER_OF_BITS-1):0] numberDecrement;
  
  /* Combinational Logic */
  assign numberIncrement = ((0 <= number) && (number < (BASE-1)))? number+1:0;  // numberIn must be between [0:BASE-1[ for numberOut to be [0:BASE[ and be of base BASE
  assign numberDecrement = ((0 < number) && (number <= (BASE-1)))? number-1:BASE-1;
  assign threshold = (up_down)? ((number == BASE-1)? 1:0):((number == 0)? 1:0);
  
  /* Sequential Logic */
  // Async rst
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      number <= (up_down)? 0:(BASE-1);
    end else if (enable) begin
      number = (up_down)? numberIncrement:numberDecrement;
    end
  end
  
endmodule
