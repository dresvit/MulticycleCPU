`timescale 1ns / 1ps

//¼Ä´æÆ÷¶Ñ
module RegFile (ReadReg1, ReadReg2, WriteReg, WriteData, RegWre, clk, reset, ReadData1, ReadData2);
	input [4:0]	ReadReg1, ReadReg2, WriteReg;
	input [31:0] WriteData;
	input	RegWre, clk, reset;
	output [31:0] ReadData1, ReadData2;
	reg [31:0] register [1:31];
	integer i;
	
	//¶Á¼Ä´æÆ÷
	assign ReadData1 = (ReadReg1 == 0) ? 0 : register[ReadReg1];
	assign ReadData2 = (ReadReg2 == 0) ? 0 : register[ReadReg2];
	
	//Ð´¼Ä´æÆ÷
	always @(posedge clk) begin
		if (reset == 1) begin
			for (i = 1; i < 32; i = i + 1)
				register[i] <= 0;
		end else begin
			if (WriteReg != 0 && RegWre == 1)
				register[WriteReg] <= WriteData;
		end
	end
endmodule
