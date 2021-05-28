// `include "shift_reg.v"
`timescale 1ps/1ps

`define ODD
// `define EVEN

module sender (input CLK,           // f = baud rate
               input start,         // negedge start to begin send
               input [8:1] message,
               output TX);

    reg set;
    // generate set signal
    reg last;
    always @(posedge CLK) begin
        last <= start;
        set  <= last & (~start);
    end

`ifdef ODD
    wire [11:1] Q;
    shift_reg #(11) sr ({1'b1, ~^message, message, 1'b0}, CLK, set, 1'b1, 1'b1, Q);
`elsif EVEN
    wire [11:1] Q;
    shift_reg #(11) sr ({1'b1, ^message, message, 1'b0}, CLK, set, 1'b1, 1'b1, Q);
`else
    wire [10:1] Q;
    shift_reg #(10) sr ({1'b1, message, 1'b0}, CLK, set, 1'b1, 1'b1, Q);
`endif
    
    assign TX = Q[1];
    
endmodule
