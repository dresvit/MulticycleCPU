`timescale 1ns / 1ps

//CPU¶¥²ãÄ£¿é
module CPU (
	clk, reset, PCinit, PCAddrIn, PC0, PC4, JumpOut, instruction, opcode, ReadReg1, ReadReg2,
	WriteReg, ReadData1, ReadData2, ExtDataOut, ALUB, ALUOp, ALUresult, DDataOut, ALUM2DRData, WriteData,
	zero, PCWre, ALUSrcB, ALUM2Reg, RegWre, WrRegData, DataMemRW, IRWre, ExtSel, PCSrc, RegOut, state
	);
	
	input clk, reset;
	input [31:0] PCinit;
	output zero, PCWre, ALUSrcB, ALUM2Reg, RegWre, WrRegData, DataMemRW, IRWre;
	output [1:0] ExtSel, PCSrc, RegOut;
	output [2:0] ALUOp, state;
	output [4:0] ReadReg1, ReadReg2, WriteReg;
	output [5:0] opcode;
	output [31:0] instruction, PCAddrIn, PC0, PC4, JumpOut, ExtDataOut,
				WriteData, ReadData1, ReadData2, ALUB, ALUresult, DDataOut, ALUM2DRData;
	wire [31:0] IROut, ADROut, BDROut, ALUoutData, ALUM2DROut;
	
	 PC my_PC (
	 .PCinit(PCinit), 
    .AddrIn(PCAddrIn), 
    .AddrOut(PC0), 
    .clk(clk), 
	 .reset(reset), 
    .PCWre(PCWre)
    );
	 
	 Adder my_Adder (
    .AddrIn(PC0), 
    .AddrOut(PC4)
    );
	 
	 NextPC my_NextPC (
    .AddrIn1(PC4), 
    .offset(ExtDataOut), 
    .AddrIn2(ReadData1), 
    .AddrIn3(JumpOut), 
    .AddrOut(PCAddrIn), 
    .PCSrc(PCSrc)
    );
	 
	 InsMem my_InsMem (
	 .PCinit(PCinit), 
    .IAddr(PC0), 
    .IDataOut(instruction)
    );
	 
	 IR my_IR (
    .clk(clk), 
    .IRIn(instruction), 
    .IROut(IROut), 
    .IRWre(IRWre)
    );
	 
	 assign opcode = IROut[31:26];
	 
	 CU my_CU (
    .clk(clk), 
    .reset(reset), 
    .decode(IROut[31:26]), 
    .zero(zero), 
    .PCWre(PCWre), 
    .ALUSrcB(ALUSrcB), 
    .ALUM2Reg(ALUM2Reg), 
    .RegWre(RegWre), 
    .WrRegData(WrRegData), 
    .DataMemRW(DataMemRW), 
    .IRWre(IRWre), 
    .ExtSel(ExtSel), 
    .PCSrc(PCSrc), 
    .RegOut(RegOut), 
    .ALUOp(ALUOp), 
	 .state(state)
    );
	 
	 Mux4x5 my_Mux4x5 (
	 .a(5'h1F), 
    .b(IROut[20:16]), 
    .c(IROut[15:11]), 
	 .d(5'b00000), 
    .s(RegOut), 
    .y(WriteReg)
    );
	 
	 Mux2x32 my_Mux2x32_1 (
	 .a(PC4), 
    .b(ALUM2DROut), 
    .s(WrRegData), 
    .y(WriteData)
    );
	 
	 assign ReadReg1 = IROut[25:21];
	 assign ReadReg2 = IROut[20:16];
	 
	 RegFile my_RegFile (
    .ReadReg1(IROut[25:21]), 
    .ReadReg2(IROut[20:16]), 
    .WriteReg(WriteReg), 
	 .WriteData(WriteData), 
    .RegWre(RegWre), 
    .clk(clk), 
    .reset(reset), 
    .ReadData1(ReadData1), 
    .ReadData2(ReadData2)
    );
	 
	 ADR my_ADR (
	 .clk(clk), 
    .DataIn(ReadData1), 
    .DataOut(ADROut)
    );
	 
	 BDR my_BDR (
	 .clk(clk), 
    .DataIn(ReadData2), 
    .DataOut(BDROut)
    );
	 
	 Jump my_Jump (
    .PC0(PC0), 
    .DataIn(IROut), 
    .DataOut(JumpOut)
    );
	 
	 Extend my_Extend (
	 .DataIn1(IROut[10:6]), 
    .DataIn2(IROut[15:0]), 
    .DataOut(ExtDataOut), 
    .ExtSel(ExtSel)
    );
	 
	 Mux2x32 my_Mux2x32_2 (
    .a(BDROut), 
    .b(ExtDataOut), 
    .s(ALUSrcB), 
    .y(ALUB)
    );
	 
	 ALU my_ALU (
    .A(ADROut), 
    .B(ALUB), 
    .ALUOp(ALUOp), 
    .zero(zero), 
    .result(ALUresult)
    );
	 
	 ALUout my_ALUout (
	 .clk(clk), 
    .DataIn(ALUresult), 
    .DataOut(ALUoutData)
    );
	 
	 DataMem my_DataMem (
    .DAddr(ALUoutData), 
    .DataIn(BDROut), 
    .DataOut(DDataOut), 
    .DataMemRW(DataMemRW)
    );
	 
	 Mux2x32 my_Mux2x32_3 (
    .a(ALUresult), 
    .b(DDataOut), 
    .s(ALUM2Reg), 
    .y(ALUM2DRData)
    );
	 
	 ALUM2DR my_ALUM2DR (
	 .clk(clk), 
    .DataIn(ALUM2DRData), 
    .DataOut(ALUM2DROut)
    );
endmodule
