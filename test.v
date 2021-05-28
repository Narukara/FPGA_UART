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
    
    wire CLK_2500k, CLK_500k, CLK_1k, CLK_100, CLK_1;
    divider div (CLK, CLK_2500k, CLK_500k, CLK_1k, CLK_100, CLK_1);
    assign led[0] = CLK_1;
    
    wire [3:0] signal;
    filter
    f0 (CLK_100, button[0], signal[0]),
    f1 (CLK_100, button[1], signal[1]),
    f2 (CLK_100, button[2], signal[2]),
    f3 (CLK_100, button[3], signal[3]);
    
    // motor mot(CLK_1k, button[2:0], button[3], button[3], DO);
    
    wire [11:1] sample;
    wire OK, catch;
    receiver rec (CLK_2500k, RX, OK, catch, sample);
    
    reg [8:1] message;
    always @(negedge signal[0]) begin
        if (signal[1] == 1'b1) begin
            message <= message + 1'b1;
        end
        else begin
            message <= message - 1'b1;
        end
    end
    sender send (CLK_500k, signal[2], message, TX);
    
    number_display nd (CLK_1k, {8'h12, sample[9:2], message}, seg, sel);
    
    assign DO[1] = RX;
    assign DO[2] = TX;
    assign DO[3] = catch;
    assign DO[4] = OK;
    
endmodule
