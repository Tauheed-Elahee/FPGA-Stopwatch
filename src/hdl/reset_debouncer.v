module reset_debouncer(
    input wire clk,
    input wire in,  // async in
    output reg out  // sync out
    );
    
    // 4 comparison reg
    reg [3:0] compare;
    
    // stable is a 4 bit xnor comparision
    wire stable = (compare[0]^compare[1])^(compare[2]^compare[3]);
    
    always@(posedge clk) begin
        compare[3] <= compare[2];
        compare[2] <= compare[1];
        compare[1] <= compare[0];
        compare[0] <= in;
        if (stable) begin
            out <= ~compare[3];
        end
    end
    
endmodule
