`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:57:38 10/24/2017 
// Design Name: 
// Module Name:    buzzer 
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
module buzzer(
	input clk,
	input onoff,
	output reg sp
    );
	 
	 parameter clk440 = 25000000/440/2;
	 parameter clk220 = 25000000/220/2;

		reg speed;
		reg sp1;
		reg sp2;
		always@(onoff)
			if(onoff == 0) sp <= 0;
			else sp <= (speed ? sp1:sp2);
			
		reg[31:0] cnt1;
		always@ (posedge clk)
				if(cnt1 == clk440) begin sp1 <= ~sp1; cnt1 <=0; end
				else begin cnt1 <= cnt1+1; end
	
			
		reg[31:0] cnt2;
		always@ (posedge clk)
				if(cnt2 == clk220) begin sp2 <= ~sp2; cnt2 <=0; end
				else begin cnt2 <= cnt2+1; end
		reg[31:0] cnt;
		always@ (posedge clk)
			if(cnt == 15000000)
			begin speed = ~speed; cnt <=0; end
			else cnt <= cnt +1;

endmodule
