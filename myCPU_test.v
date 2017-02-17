`timescale 1ns / 1ps

module myCPU_test;

	// Inputs
	reg clk;
	reg reset;
	reg [31:0] PCinit;

	// Outputs
	wire [31:0] PCAddrIn;
	wire [31:0] PC0;
	wire [31:0] PC4;
	wire [31:0] JumpOut;
	wire [31:0] instruction;
	wire [5:0] opcode;
	wire [4:0] ReadReg1;
	wire [4:0] ReadReg2;
	wire [4:0] WriteReg;
	wire [31:0] ReadData1;
	wire [31:0] ReadData2;
	wire [31:0] ExtDataOut;
	wire [31:0] ALUB;
	wire [2:0] ALUOp;
	wire [31:0] ALUresult;
	wire [31:0] DDataOut;
	wire [31:0] ALUM2DRData;
	wire [31:0] WriteData;
	wire zero;
	wire PCWre;
	wire ALUSrcB;
	wire ALUM2Reg;
	wire RegWre;
	wire WrRegData;
	wire DataMemRW;
	wire IRWre;
	wire [1:0] ExtSel;
	wire [1:0] PCSrc;
	wire [1:0] RegOut;
	wire [2:0] state;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clk(clk), 
		.reset(reset), 
		.PCinit(PCinit), 
		.PCAddrIn(PCAddrIn), 
		.PC0(PC0), 
		.PC4(PC4), 
		.JumpOut(JumpOut), 
		.instruction(instruction), 
		.opcode(opcode), 
		.ReadReg1(ReadReg1), 
		.ReadReg2(ReadReg2), 
		.WriteReg(WriteReg), 
		.ReadData1(ReadData1), 
		.ReadData2(ReadData2), 
		.ExtDataOut(ExtDataOut), 
		.ALUB(ALUB), 
		.ALUOp(ALUOp), 
		.ALUresult(ALUresult), 
		.DDataOut(DDataOut), 
		.ALUM2DRData(ALUM2DRData), 
		.WriteData(WriteData), 
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
		.state(state)
	);

	initial begin
		// Initialize Inputs
		reset = 1;
		PCinit = 32'h000000F8;
		clk = 0;
		clk = 1;
		#5;
		reset = 0;
		clk = 0;
		#5;
		clk = 1;
		forever #5 clk = ~clk;
        
		// Add stimulus here

	end
      
endmodule

