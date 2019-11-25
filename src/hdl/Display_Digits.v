`include "/home/thegreat/projects/_Hardware/FPGA/Verilog/basicCounter/source/Counter.v" 
module Display_Digits (
    clk,
    number,
    io_sel,
    io_seg
  );
  
  parameter NUMBER_OF_DIGITS = 1;
  
  input wire clk;  // clock
  input wire [((NUMBER_OF_DIGITS*4)-1):0] number;  // reset
  output wire [3:0] io_sel;
  output wire [7:0] io_seg;

  wire [3:0] selected_number;
//   integer count;
  wire [63:0] count;

  /* Combinational Logic */
  BCD_n bcd(.number(selected_number[3:0]), .digit_n(io_seg[7:0]));
  assign  {io_sel[3:0],selected_number[3:0]} = (|count)? {4'b1101,number[7:4]}:{4'b1110,number[3:0]};
  
  Counter #(.BASE(NUMBER_OF_DIGITS), .NUMBER_OF_NYBLES(16)) counter(.clk(clk), .rst(1'b0), .enable(1'b1), .numberIn(count), .numberOut(count));
  
  /*
  always @(posedge clk) begin
    if (count+1 < NUMBER_OF_DIGITS) begin
      count <= count+1;
    end else begin
      count <= 0;
    end
  end
  */
//   /* Sequential Logic */
//   always @(posedge clk) begin
//       // probably use foorloop with genvar
//       selected_number [3] <= number [(count*4)+3];
//       selected_number [2] <= number [(count*4)+2];
//       selected_number [1] <= number [(count*4)+1];
//       selected_number [0] <= number [(count*4)+0];
//       io_sel[3:0] <= ~(4'b0000 | (1 << count));
//   end
  
endmodule
