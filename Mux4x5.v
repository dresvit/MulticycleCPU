`timescale 1ns / 1ps

//5位4选1数据选择器
module Mux4x5 (a, b, c, d, s, y);
	input [4:0] a, b, c, d;
	input [1:0] s;
	output reg [4:0] y;
	always @(*) begin
		case (s)
			0: y = a;
			1: y = b;
			2: y = c;
			3: y = d;
		endcase
	end
endmodule
