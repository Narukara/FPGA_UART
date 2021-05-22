// `include "divider.v"
// `include "sender.v"
// `include "filter.v"
// `include "receiver.v"
// `include "number_display.v"
`timescale 1ps/1ps
module test (input CLK,
             input [3:0] button,
             input RX,
             output [3:0] led,
             output TX,
             output [6:0] seg,
             output [5:0] sel,
             output [4:1] DO,
             output [11:0] out_led);
    
    assign DO[1] = RX;
    
    wire CLK_2500k, CLK_500k, CLK_1k, CLK_100, CLK_1;
    divider div (CLK, CLK_2500k, CLK_500k, CLK_1k, CLK_100, CLK_1);
    assign led[0] = CLK_1;
    
    wire [3:0] signal;
    filter
    f0 (CLK_100, button[0], signal[0]),
    f1 (CLK_100, button[1], signal[1]),
    f2 (CLK_100, button[2], signal[2]),
    f3 (CLK_100, button[3], signal[3]);
    
    wire [10:1] sample;
    sender send (CLK_500k, signal[0], 8'h62, TX);
    receiver rec (CLK_2500k, RX, led[1], DO[2], sample);
    
    number_display nd (CLK_1k, {16'h1234, sample[9:2]}, seg, sel);
    
    assign out_led[9:0] = ~sample;
    assign out_led[10] = 1;
    assign out_led[11] = 1;
    assign DO[3] = sample[10];
    assign DO[4] = sample[9];

endmodule
