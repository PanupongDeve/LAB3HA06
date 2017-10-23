module combine(out,com,spk,clk_f,clk_s,rst);
	output [7:0] out;
	output [1:0] com;
	output spk;
	input clk_f,clk_s,rst;
	
	wire [3:0] w0;
	wire [3:0] w1;
	wire en;
	
	counter m1({w1[3:0],w0[3:0]},en,clk_s,rst);
	seg2digit m2(out,com,clk_f,w1,w0);
	buzzer m3(spk,clk_f,en);
endmodule

module counter(out,en,clk,rst);
	output [7:0] out;
	output en;
	input clk;
	input rst;
	reg [3:0] d1 = 9;
	reg [3:0] d0 = 9;
	reg en = 1;
	 
	always@(posedge clk or posedge rst) begin
		if(rst) begin
			d1 = 9;
			d0 = 9;
			en = 1;
		end
		
		else if(d1 > 0 || d0 > 0) begin
			if(d0 == 0) begin
				d0 = 9;
				if(d1 == 0)
					d1 = 9;
				else
					d1 = d1 - 1;
			end
			else
				d0 = d0 - 1;
			en = 1;
		end
		
		else if(d1 == 0 && d0 == 0)
			en = 0;
	end
	assign out = {d1,d0};
endmodule

module seg2digit(out,com,clk,in1,in0);
	output [7:0] out;
	output [1:0] com;
	input clk;
	input [3:0] in1;
	input [3:0] in0;
	reg [7:0] digit;
	reg [1:0] regcom = 2'b10;
	reg [15:0] clkdiv;
	reg [3:0] in;
	
	always@(posedge clk)begin
		clkdiv = clkdiv + 1;
		if(clkdiv == 0) begin
			regcom = {regcom[0],regcom[1]};
			case(regcom)
				2'b10:	in = in0;
				2'b01:	in = in1;
				default: in = 0000;
			endcase
			case(in)
				0: digit = 8'b00111111;
				1: digit = 8'b00000110;
				2: digit = 8'b01011011;
				3: digit = 8'b01001111;
				4: digit = 8'b01100110;
				5: digit = 8'b01101101;
				6: digit = 8'b01111101;
				7: digit = 8'b00000111;
				8: digit = 8'b01111111;
				9: digit = 8'b01101111;
				10:	digit = 8'b01110111;
				11:	digit = 8'b01111100;
				12:	digit = 8'b00111001;
				13:	digit = 8'b01011110;
				14:	digit = 8'b01111001;
				15:	digit = 8'b01110001;
				default:	digit = 8'b00000000;
			endcase
		end
	end
	assign out = digit;
	assign com = regcom;
endmodule

module buzzer(speaker,clk,en);
	input clk,en;
	output speaker;
	parameter clkdivider = 25000000/800/2;
	reg [23:0] tone;
	
	always @(posedge clk)
		tone <= tone+1;
		
	reg [14:0] counter;
	always @(posedge clk)
		if(counter==0) counter <= (tone[23] ? clkdivider-1 : clkdivider/2-1);
		else counter <= counter-1;
	
	reg speaker;
	always @(posedge clk)
		if(counter==0) speaker <= ~speaker & ~en;
endmodule


