module clkDivider (
    input wire clk,  // clock
    input wire rst,
    output wire clkOut
  );
  // 10111 11010 11110 00010 00000 00 //27 bit
//   integer count;
  
  wire [63:0] count;
  
  assign clkOut = (|count)? 0:1;
  
  Counter #(.BASE(10_000), .NUMBER_OF_NYBLES(16)) counter(.clk(clk), .rst(1'b0), .enable(1'b1), .numberIn(count), .numberOut(count));
  
//   /* Sequential Logic */
//   always @(posedge clk, posedge rst) begin
//     if (rst) begin
//       count <= 32'b0;
//     end else begin
//       if (count+1 < 25000000) begin
//         count <= count + 1;
//       end else begin
//         count <= 32'b0;
//       end
//     end
//   end
  
endmodule
