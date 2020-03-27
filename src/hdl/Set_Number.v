module Set_Number  #(
                            parameter NUMBER_OF_DIGITS = 4,
                            parameter NUMBER_OF_BITS_PER_DIGIT = 4
                        )
                        (   
                            input wire clk,  // clock
                            input wire rst,  // reset
                            input wire set,
                            input wire up,
                            input wire down,
                            input wire left,
                            input wire right,
                            inout wire [(NUMBER_OF_BITS-1):0] number, // hope vivado does not throw an error otherwise do the wire declareation after the definition of local paramter
                            output wire [(NUMBER_OF_DIGITS-1):0] an
                        );

  localparam NUMBER_OF_BITS = NUMBER_OF_DIGITS * NUMBER_OF_BITS_PER_DIGIT;

  wire [(NUMBER_OF_DIGITS-1):0] enable;
  wire up_down;

  wire [3:0] seconds_1 = number[3:0];
  wire [3:0] seconds_10 = number[7:4];
  wire [3:0] minutes_1 = number[11:8];
  wire [3:0] minutes_10 = number[15:12];
  
  reg [(NUMBER_OF_DIGITS-1):0] selected_digit;
  
  wire an_selected;
  
  always @(posedge clk, posedge rst) begin
    if (rst) begin
        selected_digit <= 0;//NUMBER_OF_DIGITS-1;
    end
    else if (set) begin
        case ({left, right})
            {2'b10}:    selected_digit <= (selected_digit == NUMBER_OF_DIGITS-1)? selected_digit:(selected_digit+1);
            {2'b01}:    selected_digit <= (selected_digit == 0)? selected_digit:(selected_digit-1);
            default:    selected_digit <= selected_digit;
        endcase
    end
    else begin
        selected_digit = NUMBER_OF_DIGITS-1;
    end
  end
  
  Blinker #(.BOARD_CLOCK_FREQUENCY_IN_HZ(100_000_000), .OUTPUT_CLOCK_FREQUENCY_IN_HZ(2)) blinker(.clk(clk), .rst(0), .blink(an_selected));
  
  assign an [(NUMBER_OF_DIGITS-1):0] = ~( (!set)? 'b0:(('b0 | an_selected) << selected_digit) );
  
  assign enable[0] = (selected_digit == 0) & (up | down) & set;
  assign enable[1] = (selected_digit == 1) & (up | down) & set;
  assign enable[2] = (selected_digit == 2) & (up | down) & set;
  assign enable[3] = (selected_digit == 3) & (up | down) & set;
  
  assign up_down = (up)? 'b1:((down)? 'b0:'bz);

  Counter_Half_Duplex #(.BASE(10), .NUMBER_OF_BITS(NUMBER_OF_BITS_PER_DIGIT)) counterSeconds1(  .clk(clk),
                                            .rst(rst),
                                            .enable(enable[0]),
                                            .up_down(up_down),
                                            .set(!set),
                                            .number(seconds_1[3:0])
                                         );
  Counter_Half_Duplex #(.BASE(6), .NUMBER_OF_BITS(NUMBER_OF_BITS_PER_DIGIT)) counterSeconds10(  .clk(clk),
                                            .rst(rst),
                                            .enable(enable[1]),
                                            .up_down(up_down),
                                            .set(!set),
                                            .number(seconds_10[3:0])
                                         );
    
  Counter_Half_Duplex #(.BASE(10), .NUMBER_OF_BITS(NUMBER_OF_BITS_PER_DIGIT)) counterMinutes1(  .clk(clk),
                                            .rst(rst),
                                            .enable(enable[2]),
                                            .up_down(up_down),
                                            .set(!set),
                                            .number(minutes_1[3:0])
                                         );
  Counter_Half_Duplex #(.BASE(6), .NUMBER_OF_BITS(NUMBER_OF_BITS_PER_DIGIT)) counterMinutes10(  .clk(clk),
                                            .rst(rst),
                                            .enable(enable[3]),
                                            .up_down(up_down),
                                            .set(!set),
                                            .number(minutes_10[3:0])
                                         );

endmodule
