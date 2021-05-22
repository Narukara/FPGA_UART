`timescale 1ps/1ps
module number_display (input CLK,             // T = 1ms
                       input [24:1] num,
                       output reg [6:0] seg,
                       output reg [5:0] sel);
    
    reg [2:0] count;
    always @(negedge CLK) begin
        if (count == 3'd5) begin
            count <= 3'b0;
        end
        else begin
            count <= count + 1'b1;
        end
    end
    
    always @(count) begin
        case (count)
            0 : sel      = 6'b 011111;
            1 : sel      = 6'b 101111;
            2 : sel      = 6'b 110111;
            3 : sel      = 6'b 111011;
            4 : sel      = 6'b 111101;
            5 : sel      = 6'b 111110;
            default: sel = 6'b 111111;
        endcase
    end
    
    reg [4:1] n;
    always @(count) begin
        case (count)
            0 : n       = num[4:1];
            1 : n       = num[8:5];
            2 : n       = num[12:9];
            3 : n       = num[16:13];
            4 : n       = num[20:17];
            5 : n       = num[24:21];
            default : n = 4'b0;
        endcase
        case (n)
            0 : seg  = 7'b 0000001;
            1 : seg  = 7'b 1001111;
            2 : seg  = 7'b 0010010;
            3 : seg  = 7'b 0000110;
            4 : seg  = 7'b 1001100;
            5 : seg  = 7'b 0100100;
            6 : seg  = 7'b 1100000;
            7 : seg  = 7'b 0001111;
            8 : seg  = 7'b 0000000;
            9 : seg  = 7'b 0001100;
            10 : seg = 7'b 0001000;
            11 : seg = 7'b 1100000;
            12 : seg = 7'b 0110001;
            13 : seg = 7'b 1000010;
            14 : seg = 7'b 0110000;
            15 : seg = 7'b 0111000;
        endcase
    end
    
endmodule
