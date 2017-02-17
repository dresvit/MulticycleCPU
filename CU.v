`timescale 1ns / 1ps

//¿ØÖÆµ¥Ôª
module CU(
	clk,
	reset,
	decode,
   zero,
   PCWre,
	ALUSrcB,
	ALUM2Reg,
	RegWre,
	WrRegData,
	DataMemRW,
	IRWre,
	ExtSel,
	PCSrc,
	RegOut,
	ALUOp, 
	state
	);
   
	input [5:0] decode;
	input clk, reset, zero;
	output reg PCWre, ALUSrcB, ALUM2Reg, RegWre, WrRegData, DataMemRW, IRWre;
	output reg [1:0] ExtSel, PCSrc, RegOut;
	output reg [2:0] ALUOp, state;
	reg [2:0] next_state;
	reg i_add, i_sub, i_addi, i_or, i_and, i_ori, i_sll, i_move,
		 i_slt, i_sw, i_lw, i_beq, i_j, i_jr, i_jal, i_halt;
	
	always @(decode) begin
		{i_add, i_sub, i_addi, i_or, i_and, i_ori, i_sll, i_move,
		i_slt, i_sw, i_lw, i_beq, i_j, i_jr, i_jal, i_halt} = 16'b0000000000000000;
		case(decode)
			6'b000000: i_add = 1;
			6'b000001: i_sub = 1;
			6'b000010: i_addi = 1;
			6'b010000: i_or = 1;
			6'b010001: i_and = 1;
			6'b010010: i_ori = 1;
			6'b011000: i_sll = 1;
			6'b100000: i_move = 1;
			6'b100111: i_slt = 1;
			6'b110000: i_sw = 1;
			6'b110001: i_lw = 1;
			6'b110100: i_beq = 1;
			6'b111000: i_j = 1;
			6'b111001: i_jr = 1;
			6'b111010: i_jal = 1;
			6'b111111: i_halt = 1;
		endcase
	end
	
	always @(*) begin
		#0.001;
		PCWre = 0;
		IRWre = 0;
		RegWre = 0;
		DataMemRW = 0;
		case (state)
			3'b000:
			begin
				PCWre = i_halt^1;
				IRWre = 1;
				PCSrc[0] = (zero & i_beq)|i_j|i_jal;
				PCSrc[1] = i_jr|i_j|i_jal;
				next_state = 3'b001;
			end
			
			3'b001:
			begin
				PCSrc[0] = i_j|i_jal;
				PCSrc[1] = i_jr|i_j|i_jal;
				RegOut[0] = i_addi|i_ori|i_lw;
				RegOut[1] = i_add|i_sub|i_or|i_and|i_move|i_slt|i_sll;
				ExtSel[0] = i_ori;
				ExtSel[1] = i_addi|i_lw|i_sw|i_beq;
				WrRegData = i_add|i_addi|i_sub|i_or|i_and|i_ori|i_slt|i_sll|i_move|i_lw;
				RegWre = i_jal;
				next_state[0] = i_beq;
				next_state[1] = i_add|i_sub|i_addi|i_or|i_and|i_ori|i_move|i_slt|i_sll|i_sw|i_lw;
				next_state[2] = i_add|i_sub|i_addi|i_or|i_and|i_ori|i_move|i_slt|i_sll|i_beq;
			end
			
			3'b110:
			begin
				ALUOp[0] = i_sub|i_or|i_ori|i_beq;
				ALUOp[1] = i_slt|i_and;
				ALUOp[2] = i_sll|i_or|i_ori|i_and;
				ALUSrcB = i_addi|i_ori|i_sw|i_lw|i_sll;
				next_state = 3'b111;
			end
			
			3'b111:
			begin
				ALUM2Reg = i_lw;
				RegWre = i_add|i_sub|i_addi|i_or|i_and|i_ori|i_move|i_slt|i_sll|i_lw|i_jal;
				next_state = 3'b000;
			end
			
			3'b101:
			begin
				ALUOp[0] = i_sub|i_or|i_ori|i_beq;
				ALUOp[1] = i_slt|i_and;
				ALUOp[2] = i_sll|i_or|i_ori|i_and;
				ALUSrcB = i_addi|i_ori|i_sw|i_lw|i_sll;
				PCSrc[0] = zero & i_beq;
				next_state = 3'b000;
			end
			
			3'b010:
			begin
				ALUOp[0] = i_sub|i_or|i_ori|i_beq;
				ALUOp[1] = i_slt|i_and;
				ALUOp[2] = i_sll|i_or|i_ori|i_and;
				ALUSrcB = i_addi|i_ori|i_sw|i_lw|i_sll;
				next_state = 3'b011;
			end
			
			3'b011:
			begin
				DataMemRW = i_sw;
				next_state[0] = 0;
				next_state[1] = 0;
				next_state[2] = i_lw;
			end
			
			3'b100:
			begin
				ALUM2Reg = i_lw;
				RegWre = i_add|i_sub|i_addi|i_or|i_and|i_ori|i_move|i_slt|i_sll|i_lw|i_jal;
				next_state = 3'b000;
			end
		endcase
	end
	
	always @(posedge clk) begin
		if (reset == 1)
			state <= 3'b000;
		else if (reset == 0)
			state <= next_state;
	end
endmodule
