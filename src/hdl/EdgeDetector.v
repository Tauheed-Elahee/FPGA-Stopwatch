module EdgeDetector (
  input wire clk,
  input wire rst,
  input wire signal,
  output reg [1:0] detected
  );
  
  reg oldSignal;
  
  always @(posedge clk, posedge rst) begin
    if (rst) begin
        detected <= 0;
        oldSignal <= 0;
    end
    else begin
        case ({oldSignal, signal})
            {2'b01}:    detected <= 2'b01;
            {2'b10}:    detected <= 2'b10;
            default:    detected <= 0;
        endcase
        
        oldSignal <= signal;
    end
  end
  
endmodule
