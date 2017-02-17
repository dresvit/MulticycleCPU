`timescale 1ns / 1ps

//Ö¸Áî¼Ä´æÆ÷
module IR (clk, IRIn, IROut, IRWre);
	input clk, IRWre;
	input [31:0] IRIn;
	output reg [31:0] IROut;
	reg [31:0] register;
	
	always @(posedge clk) begin
		#0.005;
		if (IRWre == 1)
			register = IRIn;
		else if (IRWre == 0)
			IROut = register;
	end
endmodule
