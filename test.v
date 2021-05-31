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
             output [4:1] DO);
    
    wire CLK_RX, CLK_TX, CLK_1k, CLK_100, CLK_1;
    divider div (CLK, CLK_RX, CLK_TX, CLK_1k, CLK_100, CLK_1);
    assign led[0] = CLK_1;
    
    wire [3:0] signal;
    filter
    f0 (CLK_100, button[0], signal[0]),
    f1 (CLK_100, button[1], signal[1]),
    f2 (CLK_100, button[2], signal[2]),
    f3 (CLK_100, button[3], signal[3]);
    
    wire [11:1] sample;
    wire OK, catch;
    receiver rec (CLK_RX, RX, OK, catch, sample);
    assign led[1] = OK;
    
    wire [8:1] message = sample[9:2];
    // always @(negedge signal[0]) begin
    //     if (signal[1] == 1'b1) begin
    //         message <= message + 1'b1;
    //     end
    //     else begin
    //         message <= message - 1'b1;
    //     end
    // end
    sender send (CLK_TX, ~OK, message, TX);
    
    number_display nd (CLK_1k, {sample[9:2], 8'h11, message}, seg, sel);
    
    wire [2:0] speed;
    wire dir;
    wire stop;
    motor_driver md (sample[9:2], OK, speed, dir, stop);
    motor m(CLK_1k, speed, dir, stop, DO);
    
    // assign DO[1] = RX;
    // assign DO[2] = TX;
    // assign DO[3] = catch;
    // assign DO[4] = OK;
    
endmodule
