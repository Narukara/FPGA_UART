`timescale 1ps/1ps

`define BAUD_500k
// `define BAUD_19200
// `define BAUD_115200

// clock signal divider
module divider (input CLK_50M,
                output reg CLK_RX,  // f_RX = 5 x f_TX
                output reg CLK_TX,  // f_TX
                output reg CLK_1k,  // T = 1ms
                output reg CLK_100, // T = 10ms
                output reg CLK_1);  // T = 1s
    
`ifdef BAUD_500k
    parameter max_rx = 4'd9; // (50M / (500k x 5) / 2 - 1)
    reg [3:0] count_rx;
`elsif BAUD_19200
    parameter max_rx = 9'd259; // (50M / (19200 x 5) / 2 - 1)
    reg [8:0] count_rx;
`elsif BAUD_115200
    parameter max_rx = 6'd42; // (50M / (115200 x 5) / 2 - 1)
    reg [5:0] count_rx;
`endif
    always @(negedge CLK_50M) begin
        if (count_rx == max_rx) begin
            count_rx <= 0;
            CLK_RX   <= ~CLK_RX;
        end
        else begin
            count_rx <= count_rx + 1'b1;
        end
    end
    
`ifdef BAUD_500k
    parameter max_tx = 6'd49; // (50M / 500k / 2 - 1)
    reg [5:0] count_tx;
`elsif BAUD_19200
    parameter max_tx = 11'd1301; // (50M / 19200 / 2 - 1)
    reg [10:0] count_tx;
`elsif BAUD_115200
    parameter max_tx = 8'd216; // (50M / 115200 / 2 - 1)
    reg [7:0] count_tx;
`endif
    always @(negedge CLK_50M) begin
        if (count_tx == max_tx) begin
            count_tx <= 0;
            CLK_TX   <= ~CLK_TX;
        end
        else begin
            count_tx <= count_tx + 1'b1;
        end
    end
    
    // 50MHZ to 1kHz
    parameter max1 = 15'd24999; // (50M / 1k / 2 - 1)
    reg [14:0] count1;
    always @(negedge CLK_50M) begin
        if (count1 == max1) begin
            count1 <= 15'b0;
            CLK_1k <= ~CLK_1k;
        end
        else begin
            count1 <= count1 + 1'b1;
        end
    end
    
    // 1kHz to 100Hz
    parameter max2 = 3'd4; // (1k / 100 / 2 - 1)
    reg [2:0] count2;
    always @(negedge CLK_1k) begin
        if (count2 == max2) begin
            count2  <= 3'b0;
            CLK_100 <= ~CLK_100;
        end
        else begin
            count2 <= count2 + 1'b1;
        end
    end
    
    // 100Hz to 1Hz
    parameter max3 = 6'd49; // (100 / 1 / 2 - 1)
    reg [5:0] count3;
    always @(negedge CLK_100) begin
        if (count3 == max3) begin
            count3 <= 6'b0;
            CLK_1  <= ~CLK_1;
        end
        else begin
            count3 <= count3 + 1'b1;
        end
    end
    
endmodule
