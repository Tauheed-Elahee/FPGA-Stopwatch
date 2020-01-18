`timescale 10ns/1ns
`include "../hdl/Blinker.v"

/* commands to enter after running iverilog

rm *.out *.vcd && iverilog -o _.out Clock_tb.v && vvp -v _.out && gtkwave *.vcd

notes

iverilog Display_Digits_tb.v # Defaults to a.out
vvp -v a.out
gtkwave Display_Digits_tb.vcd

*/

