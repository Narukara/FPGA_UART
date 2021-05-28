module motor (input CLK,           // 1kHz
              input [2:0] speed,   // 1 <= speed <= 7
              input dir,
              input stop,          // stop = 1 -> stop
              output reg [4:1] F);
    
    reg [2:0] count;
    reg [1:0] cnt;
    
    always @(negedge CLK) begin
        if (stop == 1'b0) begin
            if (count == speed) begin
                count <= 3'b0;
                if (dir == 1'b1) begin
                    cnt <= cnt + 1'b1;
                end
                else begin
                    cnt <= cnt - 1'b1;
                end
            end
            else begin
                count <= count + 1'b1;
            end
        end
    end
    
    always @(cnt) begin
        case (cnt)
            2'b00: F = 4'b0011;
            2'b01: F = 4'b0110;
            2'b10: F = 4'b1100;
            2'b11: F = 4'b1001;
        endcase
    end
    
endmodule
