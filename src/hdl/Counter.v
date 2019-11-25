`include "/home/thegreat/projects/_Hardware/FPGA/Verilog/basicCounter/source/Counter.v" 
module Counter (   
    clk,  // clock
    rst,  // reset
    enable,
    numberIn,
    numberOut
  );
  parameter BASE = 10;
  parameter NUMBER_OF_NYBLES = 1;
  
  input wire clk;
  input wire rst;
  input wire enable;
  input wire [(NUMBER_OF_NYBLES*4-1):0] numberIn;
  output reg [(NUMBER_OF_NYBLES*4-1):0] numberOut;
  
  /* Sequential Logic */
  // Async rst
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      numberOut <= 8'b0;
    end else if (enable) begin
      numberOut <= ((0 <= numberIn) && (numberIn < (BASE-1)))? numberIn+1:0;  // numberIn must be between [0:BASE-1[ for numberOut to be [0:BASE[ and be of base BASE
    end
  end
  
endmodule
