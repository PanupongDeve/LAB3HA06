module buzzer(
    input clk, //P127
    output speaker //P52
);

    reg [15:0] cnt;
    always @(posedge clk)
    begin
      cnt <= cnt + 1; 
    end

    assign speaker = cnt[15];

endmodule