// `include "divider.v"
// `include "sender.v"
// `include "filter.v"
`timescale 1ps/1ps
module test (input CLK,
             input [3:0] button,
             input RX,
             output [3:0] led,
             output TX);

    wire CLK_500k, CLK_1k, CLK_100, CLK_1;
    divider div (CLK, CLK_500k, CLK_1k, CLK_100, CLK_1);
    assign led[0] = CLK_1;

    wire [3:0] signal;
    filter
    f0 (CLK_100, button[0], signal[0]),
    f1 (CLK_100, button[1], signal[1]),
    f2 (CLK_100, button[2], signal[2]),
    f3 (CLK_100, button[3], signal[3]);

    sender send (CLK_500k, signal[0], 8'h61, TX);

endmodule
