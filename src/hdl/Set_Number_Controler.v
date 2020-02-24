module Set_Number_Controler  (
                                input wire clk,
                                input wire rst,
                                input wire buttonUp,
                                input wire buttonCentre,
                                input wire buttonDown,
                                input wire buttonLeft,
                                input wire buttonRight,
                                output reg up,
                                output reg set,
                                output reg down,
                                output reg left,
                                output reg right
                             );

  wire [1:0]    upEdge,
                centreEdge,
                downEdge,
                leftEdge,
                rightEdge;

  EdgeDetector upEdgeDetector(.clk(clk), .rst(rst), .signal(up), .detected(upEdge));
  EdgeDetector upEdgeDetector(.clk(clk), .rst(rst), .signal(centre), .detected(centreEdge));
  EdgeDetector upEdgeDetector(.clk(clk), .rst(rst), .signal(down), .detected(downEdge));
  EdgeDetector upEdgeDetector(.clk(clk), .rst(rst), .signal(left), .detected(leftEdge));
  EdgeDetector upEdgeDetector(.clk(clk), .rst(rst), .signal(right), .detected(rightEdge));
  
  always @(posedge clk, posedge rst) begin
    if (rst) begin
        up <= 0;
        down <= 0;
        left <= 0;
        right <= 0;
        
        set <= set;
    end
    else begin
        up <= (upEdge == 2'b01) 1:0;
        down <= (downEdge == 2'b01) 1:0;
        left <= (leftEdge == 2'b01) 1:0;
        right <= (rightEdge == 2'b01) 1:0;
        
        set <= (centreEdge == 2'b01) ~set:set;
    end
  end

endmodule
