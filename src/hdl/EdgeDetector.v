module EdgeDetector (
  input wire clk,
  input wire rst,
  input wire signal,
  output reg [1:0] detected
  );
  
  wire oldSignal;
  
  always @(posedge clk, posedge rst) begin
    if (rst) begin
        detected <= 0;
    end
    else begin
        case ({oldSignal, signal})
            {2'b01}:    detected <= 2'b01;
            {2'b10}:    detected <= 2'b10;
            default:    detected <= 0;
        endcase
    end
  end
  
endmodule
