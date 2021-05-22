`timescale 1ps/1ps
// filter for button input
module filter (input CLK,          // f = 100Hz, T = 10ms
               input button,
               output reg signal);
    
    parameter delay = 3'd5;        // delay 50ms
    reg [2:0] count;

    always @(negedge CLK) begin
        if (count != delay) begin
            count <= count + 1'b1;
        end
        else if (button != signal) begin
            signal <= button;
            count <= 3'b0;
        end
    end

endmodule
