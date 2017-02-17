`timescale 1ns / 1ps

//³ÌÐò¼ÆÊýÆ÷
module PC (PCinit, AddrIn, AddrOut, clk, reset, PCWre);
	input [31:0] PCinit, AddrIn;
	output reg [31:0] AddrOut;
	input clk, reset, PCWre;
	
	always @(posedge clk) begin
		#0.002;
		if (reset == 1)
			AddrOut <= PCinit;
		if (reset == 0 && PCWre == 1)
			AddrOut <= AddrIn;
	end
endmodule
