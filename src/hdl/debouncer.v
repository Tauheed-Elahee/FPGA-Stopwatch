module debouncer #(
    parameter BOARD_CLOCK_FREQUENCY_IN_HZ	=	100_000_000,
    parameter SAMPLING_RATE			=	1000
    )
    (
    input wire clk,
    input wire in,  // async in
    output reg out  // sync out
    );
    
    // 4 comparison reg
    reg [3:0] compare;
    
    // stable is a 4 bit xnor comparision
    wire stable = (compare[0]~^compare[1])~^(compare[2]~^compare[3]);
    
    wire sampleClock;
    
    Clock_Hz #(
      .BOARD_CLOCK_FREQUENCY_IN_HZ (BOARD_CLOCK_FREQUENCY_IN_HZ),
      .OUTPUT_CLOCK_FREQUENCY_IN_HZ (SAMPLING_RATE)
    )
            delay   (
                        .clk(clk),  // clock
                        .rst(rst),
                        .clkOut(sampleClock)
    );
    
    always@(posedge clk) begin
        if (sampleClock) begin
            compare[3] <= compare[2];
            compare[2] <= compare[1];
            compare[1] <= compare[0];
            compare[0] <= in;
            if (stable) begin
                out <= compare[3];
            end
        end
    end
    
endmodule
