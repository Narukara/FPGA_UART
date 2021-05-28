`timescale 1ps/1ps

`define ODD
// `define EVEN

module receiver (input CLK,                 // f = 5 x baud rate
                 input RX,
                 output OK,                 // posedge OK -> receive message
                 output catch,              // for debugging only
                 output reg [11:1] sample);
    
    // catch start signal
    reg last, start;
    always @(negedge CLK) begin
        last  <= RX;
        start <= ~last | RX;
    end
    
    // RS flip-flop
    wire S, R, Q, nQ;
    nand n1 (Q, S, nQ);
    nand n2 (nQ, R, Q);
    
    reg [6:1] count;
    assign S = start;
    assign R = ~(count == 6'd53);
    
    assign catch = 
    (count == 6'd2) |
    (count == 6'd7) |
    (count == 6'd12) |
    (count == 6'd17) |
    (count == 6'd22) |
    (count == 6'd27) |
    (count == 6'd32) |
    (count == 6'd37) |
    (count == 6'd42) |
    (count == 6'd47) |
    (count == 6'd52) ;
    
    always @(posedge CLK) begin
        if (Q) begin
            count <= count + 1'b1;
        end
        else begin
            count <= 6'b0;
        end
    end
    
    always @(negedge CLK) begin
        if (catch) begin
            sample <= {RX, sample[11:2]};
        end
    end
    
`ifdef ODD
    assign OK = (~Q) & (~sample[1]) & sample[11] & (^sample[10:2]);
`elsif EVEN
    assign OK = (~Q) & (~sample[1]) & sample[11] & (~^sample[10:2]);
`else
    assign OK = (~Q) & (~sample[1]) & sample[10];
`endif
    
endmodule
