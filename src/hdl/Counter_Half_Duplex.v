module Counter_Half_Duplex #(
      parameter BASE = 10,
      parameter NUMBER_OF_BITS = 4,
      parameter EXPOSE_NUMBER = 1
    )
    (   
      input wire clk,
      input wire rst,
      input wire enable,
      input wire up_down,
      input wire set,
      inout wire [(NUMBER_OF_BITS-1):0] number,
      output wire threshold
    );
  
  wire [(NUMBER_OF_BITS-1):0] numberCurrent;
  reg [(NUMBER_OF_BITS-1):0] numberNext;
  wire [(NUMBER_OF_BITS-1):0] numberIncrement;
  wire [(NUMBER_OF_BITS-1):0] numberDecrement;
  
  /* Combinational Logic */
  assign numberCurrent = number;
  assign number = (set)? 'bz:numberNext;//(EXPOSE_NUMBER == 0)? numberOut:numberIn;
  assign numberIncrement = ((0 <= numberCurrent) && (numberCurrent < (BASE-1)))? numberCurrent+1:0;  // numberIn must be between [0:BASE-1[ for numberOut to be [0:BASE[ and be of base BASE
  assign numberDecrement = ((0 < numberCurrent) && (numberCurrent <= (BASE-1)))? numberCurrent-1:BASE-1;
  assign threshold = (up_down)? ((numberNext == BASE-1)? 1:0):((numberNext == 0)? 1:0);
  
  /* Sequential Logic */
  // Async rst
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      numberNext <= (up_down)? 0:(BASE-1);
    end else if (enable) begin
      numberNext = (set)? number:(up_down)? numberIncrement:numberDecrement;
    end
    else begin
        numberNext = number;
    end
  end
  
endmodule
