module BCD_n (
    input wire [3:0] number,
    output wire [6:0] digit_n
  );

  wire [6:0] digit;

  BCD bcd(.number(number[3:0]), .digit(digit[6:0]));
  
  assign digit_n = ~digit[6:0];
  
endmodule
