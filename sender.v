// `include "shift_reg.v"
`timescale 1ps/1ps
module sender (input CLK,           // f = 500kHz, baud rate = 500k
               input start,         // negedge start to begin send
               input [8:1] message,
               output TX);
    
    reg set;
    wire [10:1] Q;
    
    assign TX = Q[1];
    shift_reg #(10) sr ({1'b1, message, 1'b0}, CLK, set, 1'b1, 1'b1, Q);
    
    reg last;
    always @(posedge CLK) begin
        last <= start;
        set  <= last & (~start);
    end
    
endmodule
