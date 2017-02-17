`timescale 1ns / 1ps

//计算下一条指令的地址
module NextPC (AddrIn1, offset, AddrIn2, AddrIn3, AddrOut, PCSrc);
	input [31:0] AddrIn1, offset, AddrIn2, AddrIn3;
	output reg [31:0] AddrOut;
	input [1:0] PCSrc;
	
	always @(*) begin
		#0.002;
		if (PCSrc == 0)
			AddrOut = AddrIn1;
		else if (PCSrc == 1)
			AddrOut = AddrIn1 + (offset << 2);
		else if (PCSrc == 2)
			AddrOut = AddrIn2;
		else if (PCSrc == 3)
			AddrOut = AddrIn3;
	end
endmodule
