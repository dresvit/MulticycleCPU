`timescale 1ns / 1ps

//32λ2ѡ1����ѡ����
module Mux2x32 (a, b, s, y);
	input [31:0] a, b;
	input s;
	output [31:0] y;
	assign y = s ? b : a;
endmodule
