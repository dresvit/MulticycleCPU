`timescale 1ns / 1ps

//ALU
module ALU (A, B, ALUOp, zero, result);
	input [31:0] A, B;
	input [2:0] ALUOp;
	output reg zero;
	output reg [31:0] result;
	
	initial begin
		zero = 0;
	end
	
	always @(A or B or ALUOp) begin
		case(ALUOp)
			3'b000: result = A + B;
			3'b001: result = A - B;
			3'b010: result = (A < B) ? 1 : 0;
			3'b011: result = A >> B;
			3'b100: result = A << B;
			3'b101: result = A | B;
			3'b110: result = A & B;
			3'b111: result = A ^ B;
		endcase
		if (result == 0) zero = 1; else zero = 0;
	end
endmodule
