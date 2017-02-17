`timescale 1ns / 1ps

//À©Õ¹
module Extend (DataIn1, DataIn2, DataOut, ExtSel);
	input [4:0] DataIn1;
	input [15:0] DataIn2;
	output reg [31:0] DataOut;
	input [1:0] ExtSel;
	
	always @(*) begin
		case (ExtSel)
			0: DataOut = {27'b000000000000000000000000000, DataIn1};
			1: DataOut = {16'h0000, DataIn2};
			2: DataOut = DataIn2[15] ? {16'hffff, DataIn2} : {16'h0000, DataIn2};
		endcase
	end
endmodule
