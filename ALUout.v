`timescale 1ns / 1ps

module ALUout (clk, DataIn, DataOut);
	input clk;
	input [31:0] DataIn;
	output reg [31:0] DataOut;
	
	always @(posedge clk) begin
		DataOut = DataIn;
	end
endmodule
