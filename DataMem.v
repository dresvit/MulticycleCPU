`timescale 1ns / 1ps

//数据存储器
module DataMem (DAddr, DataIn, DataOut, DataMemRW);
	input [31:0] DAddr, DataIn;
	output reg [31:0] DataOut;
	input DataMemRW;
	reg [7:0] memory [0:9999];
	
	always @(DAddr or DataIn or DataMemRW) begin
		#0.001;
		if (DataMemRW == 0) begin  //读数据
			DataOut <= {memory[DAddr+3], memory[DAddr+2], memory[DAddr+1], memory[DAddr]};
		end
		else if (DataMemRW == 1) begin  //写数据
			memory[DAddr] <= DataIn[7:0];
			memory[DAddr+1] <= DataIn[15:8];
			memory[DAddr+2] <= DataIn[23:16];
			memory[DAddr+3] <= DataIn[31:24];
		end
	end
endmodule
