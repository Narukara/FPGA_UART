`timescale 1ps/1ps
// clock signal divider
module divider (input CLK_50M,
                output reg CLK_500k, // T = 2us
                output reg CLK_1k,   // T = 1ms
                output reg CLK_100,  // T = 10ms
                output reg CLK_1);   // T = 1s
    
    // 50MHz to 500kHz
    parameter max0 = 6'd49; // (50M / 500k / 2 - 1)
    reg [5:0] count0;
    always @(negedge CLK_50M) begin
        if (count0 == max0) begin
            count0   <= 6'b0;
            CLK_500k <= ~CLK_500k;
        end
        else begin
            count0 <= count0 + 1'b1;
        end
    end
    
    // 500kHZ to 1kHz
    parameter max1 = 8'd249; // (500k / 1k / 2 - 1)
    reg [7:0] count1;
    always @(negedge CLK_500k) begin
        if (count1 == max1) begin
            count1 <= 8'b0;
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
