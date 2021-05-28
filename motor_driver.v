`timescale 1ps/1ps
module motor_driver (input [8:1] message,
                     input OK,
                     output reg [2:0] speed,
                     output reg dir,
                     output reg stop);

    always @(posedge OK) begin
        case (message)
            8'h30 : stop  <= ~stop; // 0
            8'h31 : speed <= 3'd1;  // 1
            8'h32 : speed <= 3'd2;  // 2
            8'h33 : speed <= 3'd3;  // 3
            8'h34 : speed <= 3'd4;  // 4
            8'h35 : speed <= 3'd5;  // 5
            8'h36 : speed <= 3'd6;  // 6
            8'h37 : speed <= 3'd7;  // 7
            8'h64 : dir   <= ~dir;  // d
        endcase
    end

endmodule
