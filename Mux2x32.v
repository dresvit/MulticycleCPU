`timescale 1ns / 1ps

//32位2选1数据选择器
module Mux2x32 (a, b, s, y);
	input [31:0] a, b;
	input s;
	output [31:0] y;
	assign y = s ? b : a;
endmodule
