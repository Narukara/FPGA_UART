module test (input CLK,
             input [3:0] button,
             output [3:0] led);
    assign led = button;
endmodule
