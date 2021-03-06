module Counter #(
      parameter BASE			=	10,
      parameter NUMBER_OF_BITS	=	4,
      parameter EXPOSE_NUMBER	=	1
    )
    (   
      input wire clk,
      input wire rst,
      input wire enable,
      input wire up_down,
      input wire [(NUMBER_OF_BITS-1):0] numberIn,
      output reg [(NUMBER_OF_BITS-1):0] numberOut,
      output wire threshold
    );
  
  wire [(NUMBER_OF_BITS-1):0] number;
  wire [(NUMBER_OF_BITS-1):0] numberNext;
  wire [(NUMBER_OF_BITS-1):0] numberIncrement;
  wire [(NUMBER_OF_BITS-1):0] numberDecrement;
  
  /* Combinational Logic */
  assign number = (EXPOSE_NUMBER == 0)? numberOut:numberIn;
  assign numberIncrement = ((0 <= number) && (number < (BASE-1)))? number+1:0;  // numberIn must be between [0:BASE-1[ for numberOut to be [0:BASE[ and be of base BASE
  assign numberDecrement = ((0 < number) && (number <= (BASE-1)))? number-1:BASE-1;
  assign numberNext =  (up_down)? numberIncrement:numberDecrement;
  assign threshold = (up_down)? ((numberOut == BASE-1)? 1:0):((numberOut == 0)? 1:0);
  
  /* Sequential Logic */
  // Async rst
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      numberOut <= (up_down)? 0:(BASE-1);
    end else if (enable) begin
      numberOut <= numberNext;
    end
  end
  
endmodule
