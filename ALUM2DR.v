`timescale 1ns / 1ps

module ALUM2DR (clk, DataIn, DataOut);
	input clk;
	input [31:0] DataIn;
	output reg [31:0] DataOut;
	
	always @(posedge clk) begin
		#0.002;
		DataOut = DataIn;
	end
endmodule
