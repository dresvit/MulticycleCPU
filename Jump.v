`timescale 1ns / 1ps

module Jump (PC0, DataIn, DataOut);
	input [31:0] PC0, DataIn;
	output [31:0] DataOut;
	assign DataOut = {PC0[31:28], DataIn[25:0], 2'b00};
	//assign DataOut = 9'b100000000;
endmodule
