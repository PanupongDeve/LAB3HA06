`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:22:19 10/24/2017 
// Design Name: 
// Module Name:    alarm_twodigit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alarm_twodigit(
	input clk,
	input en,
	output reg sp,
	output reg [6:0] o,
	output [1:0] com
    );
	 
	 assign com = 2'b00;
	 reg [3:0] one;
	 reg [3:0] ten;
	 reg sclk;
	 reg [31:0] cnt; 
	 
	 always@ (posedge sclk)
	 if (en == 0)
		begin
			one <= 0;
			ten <= 0;
		end
	 else
		begin
			if(one == 9) 
				begin 
					one <=0; 
					ten <= ten +1; 
				end
			else if (one == 9 && ten == 9)
				begin
					one <= 0;
					ten <= 0;
				end
			else 
				begin 
					one <= one+1; 
				end
		end
		
	 always@ (one,ten)
		if(en == 0) sp <= 0;
		else 
			begin 
				if(one ==9 && ten == 1) sp <= 1;
			end
	always@ (posedge clk)
		begin
			if(cnt == 10000000)
				begin
					sclk <= ~sclk;
					cnt <= 0;
				end
			else
				cnt <= cnt + 1;
		end
	

	always@ (one)
		begin
			case(one)
				4'b0000 : o <= 7'b0111111;
				4'b0001 : o <= 7'b0000110;
				4'b0010 : o <= 7'b1011011;
				4'b0011 : o <= 7'b1001111;
				4'b0100 : o <= 7'b1100110;
				4'b0101 : o <= 7'b1101101;
				4'b0110 : o <= 7'b1111101;
				4'b0111 : o <= 7'b0000111;
				4'b1000 : o <= 7'b1111111;
				4'b1001 : o <= 7'b1100111;
				default : o <= 7'b0000000;
			endcase
		end

endmodule
