`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:35:59 10/24/2017 
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
	
	reg [31:0] cnt;
	
	always@ (posedge clk)
		if(onoff == 0) sp <= 0;
		else begin
			if(cnt == clk440) begin sp <= ~sp; cnt <= 0; end
			else begin cnt <= cnt+1; end
		end
endmodule
