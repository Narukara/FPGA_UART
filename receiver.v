// `include "rx_reg.v"
`timescale 1ps/1ps
module receiver (input CLK,            // f = 2500kHz = 2.5MHz
                 input RX,
                 output OK,
                 output catch,
                 output reg [10:1] sample);
    
    reg last, start;
    always @(negedge CLK) begin
        last  <= RX;
        start <= ~last | RX;
    end
    
    wire S, R, Q, nQ;
    nand n1 (Q, S, nQ);
    nand n2 (nQ, R, Q);

    reg [6:1] count;
    assign S = start;
    assign R = ~(count == 6'd48);

    assign catch =  (count == 6'd2) |
                    (count == 6'd7) |
                    (count == 6'd12) |
                    (count == 6'd17) |
                    (count == 6'd22) |
                    (count == 6'd27) |
                    (count == 6'd32) |
                    (count == 6'd37) |
                    (count == 6'd42) |
                    (count == 6'd47) ;
    
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
            sample <= {RX, sample[10:2]};
        end
    end

    assign OK = (~Q) & (~sample[1]) & sample[10];
    
endmodule
