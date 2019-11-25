module BCD_n (
    input wire [3:0] number,
    output wire [7:0] digit_n
  );

  wire [7:0] digit;

  assign digit[0] =  (~number[3]&~number[2]&~number[1]&~number[0])  // 0
                  |  (~number[3]&~number[2]&number[1]&~number[0])  // 2
                  |  (~number[3]&~number[2]&number[1]&number[0])  // 3
                  |  (~number[3]&number[2]&~number[1]&number[0])  // 5
                  |  (~number[3]&number[2]&number[1]&~number[0])  // 6
                  |  (~number[3]&number[2]&number[1]&number[0])  // 7
                  |  (number[3]&~number[2]&~number[1]&~number[0])  // 8
                  |  (number[3]&~number[2]&~number[1]&number[0]); // 9
  
  assign digit[1] =  (~number[3]&~number[2]&~number[1]&~number[0])  // 0
                  |  (~number[3]&~number[2]&~number[1]&number[0])  // 1
                  |  (~number[3]&~number[2]&number[1]&~number[0])  // 2
                  |  (~number[3]&~number[2]&number[1]&number[0])  // 3
                  |  (~number[3]&number[2]&~number[1]&~number[0])  // 4
                  |  (~number[3]&number[2]&number[1]&number[0])  // 7
                  |  (number[3]&~number[2]&~number[1]&~number[0])  // 8
                  |  (number[3]&~number[2]&~number[1]&number[0]); // 9
  
  assign digit[2] =  (~number[3]&~number[2]&~number[1]&~number[0])  // 0
                  |  (~number[3]&~number[2]&~number[1]&number[0])  // 1
                  |  (~number[3]&~number[2]&number[1]&number[0])  // 3
                  |  (~number[3]&number[2]&~number[1]&~number[0])  // 4
                  |  (~number[3]&number[2]&~number[1]&number[0])  // 5
                  |  (~number[3]&number[2]&number[1]&~number[0])  // 6
                  |  (~number[3]&number[2]&number[1]&number[0])  // 7
                  |  (number[3]&~number[2]&~number[1]&~number[0])  // 8
                  |  (number[3]&~number[2]&~number[1]&number[0]); // 9
  
  assign digit[3] =  (~number[3]&~number[2]&~number[1]&~number[0])  // 0
                  |  (~number[3]&~number[2]&number[1]&~number[0])  // 2
                  |  (~number[3]&~number[2]&number[1]&number[0])  // 3
                  |  (~number[3]&number[2]&~number[1]&number[0])  // 5
                  |  (~number[3]&number[2]&number[1]&~number[0])  // 6
                  |  (number[3]&~number[2]&~number[1]&~number[0]);  // 8
  
  assign digit[4] =  (~number[3]&~number[2]&~number[1]&~number[0])  // 0
                  |  (~number[3]&~number[2]&number[1]&~number[0])  // 2
                  |  (~number[3]&number[2]&number[1]&~number[0])  // 6
                  |  (number[3]&~number[2]&~number[1]&~number[0]);  // 8
  
  assign digit[5] =  (~number[3]&~number[2]&~number[1]&~number[0])  // 0
                  |  (~number[3]&number[2]&~number[1]&~number[0])  // 4
                  |  (~number[3]&number[2]&~number[1]&number[0])  // 5
                  |  (~number[3]&number[2]&number[1]&~number[0])  // 6
                  |  (number[3]&~number[2]&~number[1]&~number[0])  // 8
                  |  (number[3]&~number[2]&~number[1]&number[0]); // 9

  assign digit[6] =  (~number[3]&~number[2]&number[1]&~number[0])  // 2
                  |  (~number[3]&~number[2]&number[1]&number[0])  // 3
                  |  (~number[3]&number[2]&~number[1]&~number[0])  // 4
                  |  (~number[3]&number[2]&~number[1]&number[0])  // 5
                  |  (~number[3]&number[2]&number[1]&~number[0])  // 6
                  |  (number[3]&~number[2]&~number[1]&~number[0])  // 8
                  |  (number[3]&~number[2]&~number[1]&number[0]); // 9
                  
  assign digit[7] = 0;
  
  assign digit_n[7:0] = ~digit[7:0];
  
endmodule
