`timescale 1ps/1ps
module shift_reg #(parameter length = 8)
                  (input [length:1] data,
                   input CLK,
                   input set,                // set = 1 -> Q = data
                   input dir,                // dir = 0 -> Q << 1
                   input in,
                   output reg [length:1] Q);
    
    always @(negedge CLK) begin
        if (set == 1'b1) begin
            Q <= data;
        end
        else begin
            if (dir == 1'b0)begin
                Q    <= Q << 1;
                Q[1] <= in;
            end
            else begin
                Q         <= Q >> 1;
                Q[length] <= in;
            end
        end
    end
    
endmodule
