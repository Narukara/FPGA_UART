// `include "sender.v"
// `include "receiver.v"
`timescale 1ps/1ps
module tb ();
    
    reg CLK, RX;
    receiver rec (CLK, RX, , , );
    initial begin
        rec.count = 6'b0;
        RX     = 1'b1;
        #23 RX = 1'b0;
        repeat (9) begin
            #50 RX = ~RX;
        end
    end
    
    // reg CLK, start;
    // reg [8:1] message;
    // wire TX;
    // sender send(CLK, start, message, TX);
    
    initial begin
        CLK = 1'b0;
        repeat (128) begin
            #5 CLK <= ~CLK;
        end
    end
    
    // initial begin
    //     start      = 1'b1;
    //     message    = 8'b1001_0101;
    //     #180 start = 1'b0;
    //     #100 start = 1'b1;
    //     #100 start = 1'b0;
    // end
    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
    
endmodule
