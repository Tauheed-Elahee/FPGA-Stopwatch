module Counter2 (   
    clk,  // clock
    rst,  // reset
    enable,
    numberIn,
    numberOut,
    threshold
  );
  parameter BASE = 10;
  parameter NUMBER_OF_NYBLES = 1;
  
  Counter #(    .BASE(BASE)
                .NUMBER_OF_NYBLES(NUMBER_OF_NYBLES)
           )
           alchitry(    .clk(clk)
                        .rst(rst)
                        .enable(enable)
                        .numberIn(numberIn)
                        .numberOut(numberOut)
                        .threshold(threshold)
                   );
  
endmodule
