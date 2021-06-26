`timescale 1ps/1ps
module tb ();
    
    reg CLK;
    initial begin
        CLK = 1'b0;
        repeat (128) begin
            #5 CLK <= ~CLK;
        end
    end
    
    reg RX;
    wire OK, catch;
    wire [11:1] sample;
    receiver rec (CLK, RX, OK, catch, sample);
    wire S           = rec.S;
    wire R           = rec.R;
    wire [6:1] count = rec.count;
    initial begin
        rec.count = 6'b0;
        RX        = 1'b1;
        #23 RX    = 1'b0;
        repeat (9) begin
            #50 RX = ~RX;
        end
    end
    
    // reg start;
    // reg [8:1] message;
    // wire TX;
    // sender send(CLK, start, message, TX);
    // initial begin
    //     start      = 1'b1;
    //     message    = 8'b1011_0101;
    //     #120 start = 1'b0;
    //     #10 start  = 1'b1;
    // end
    
    // reg [2:0] speed;
    // reg dir, stop;
    // wire [4:1] F;
    // motor mot(CLK, speed, dir, stop, F);
    // initial begin
    //     mot.count = 0;
    //     mot.cnt   = 0;
    //     speed     = 3'd1;
    //     dir       = 1'b1;
    //     stop      = 1'b1;
    //     #80;
    //     stop = 1'b0;
    //     #80;
    //     dir = 1'b0;
    //     #80;
    //     speed = 3'd7;
    // end
    
    // reg [8:1] message;
    // reg OK;
    // wire [2:0] speed;
    // wire dir, stop;
    // motor_driver md(message, OK, speed, dir, stop);
    // initial begin
    //     OK      = 1'b0;
    //     md.stop = 1'b1;
    //     md.dir  = 1'b1;
    //     message = 8'h30;
    //     #10;
    //     OK = 1'b1;
    //     #10;
    //     OK      = 1'b0;
    //     message = 8'h35;
    //     #10;
    //     OK = 1'b1;
    //     #10;
    //     OK      = 1'b0;
    //     message = 8'h64;
    //     #10;
    //     OK = 1'b1;
    //     #10;
    // end
    
    // initial begin
    //     $dumpfile("wave.vcd");
    //     $dumpvars;
    // end
    
endmodule
