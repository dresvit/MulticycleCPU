`timescale 1ns / 1ps

//Ö¸Áî´æ´¢Æ÷
module InsMem (PCinit, IAddr, IDataOut);
	input [31:0] PCinit, IAddr;
	output reg [31:0] IDataOut;
	reg [7:0] memory [0:9999];
	
	initial begin
		#0.001;
		//j 0x00000100
		memory[PCinit+0] = 8'b01000000;
		memory[PCinit+1] = 8'b00000000;
		memory[PCinit+2] = 8'b00000000;
		memory[PCinit+3] = 8'b11100000;
		// ori $1,$0,22
		memory[PCinit+8] = 8'b00010110;
		memory[PCinit+9] = 8'b00000000;
		memory[PCinit+10] = 8'b00000001;
		memory[PCinit+11] = 8'b01001000;
		// addi  $2,$0,27
		memory[PCinit+12] = 8'b00011011;
		memory[PCinit+13] = 8'b00000000;
		memory[PCinit+14] = 8'b00000010;
		memory[PCinit+15] = 8'b00001000;
		// add  $3,$1,$2
		memory[PCinit+16] = 8'b00000000;
		memory[PCinit+17] = 8'b00011000;
		memory[PCinit+18] = 8'b00100010;
		memory[PCinit+19] = 8'b00000000;
		// sub  $5,$2,$1
		memory[PCinit+20] = 8'b00000000;
		memory[PCinit+21] = 8'b00101000;
		memory[PCinit+22] = 8'b01000001;
		memory[PCinit+23] = 8'b00000100;
		// or   $8,$1,$2
		memory[PCinit+24] = 8'b00000000;
		memory[PCinit+25] = 8'b01000000;
		memory[PCinit+26] = 8'b00100010;
		memory[PCinit+27] = 8'b01000000;
		// jal  0x00000134
		memory[PCinit+28] = 8'b01001101;
		memory[PCinit+29] = 8'b00000000;
		memory[PCinit+30] = 8'b00000000;
		memory[PCinit+31] = 8'b11101000;
		// beq  $3,$8,5
		memory[PCinit+32] = 8'b00000101;
		memory[PCinit+33] = 8'b00000000;
		memory[PCinit+34] = 8'b01101000;
		memory[PCinit+35] = 8'b11010000;
		// sw  $3,32($1)
		memory[PCinit+36] = 8'b00100000;
		memory[PCinit+37] = 8'b00000000;
		memory[PCinit+38] = 8'b00100011;
		memory[PCinit+39] = 8'b11000000;
		// and  $6,$1,$2
		memory[PCinit+40] = 8'b00000000;
		memory[PCinit+41] = 8'b00110000;
		memory[PCinit+42] = 8'b00100010;
		memory[PCinit+43] = 8'b01000100;
		// move  $9,$5
		memory[PCinit+44] = 8'b00000000;
		memory[PCinit+45] = 8'b01001000;
		memory[PCinit+46] = 8'b10100000;
		memory[PCinit+47] = 8'b10000000;
		// lw  $8,36($6)
		memory[PCinit+48] = 8'b00100100;
		memory[PCinit+49] = 8'b00000000;
		memory[PCinit+50] = 8'b11001000;
		memory[PCinit+51] = 8'b11000100;
		// beq  $5,$9,-6
		memory[PCinit+52] = 8'b11111010;
		memory[PCinit+53] = 8'b11111111;
		memory[PCinit+54] = 8'b10101001;
		memory[PCinit+55] = 8'b11010000;
		// halt
		memory[PCinit+56] = 8'b00000000;
		memory[PCinit+57] = 8'b00000000;
		memory[PCinit+58] = 8'b00000000;
		memory[PCinit+59] = 8'b11111100;
		// slt  $11,$1,$2
		memory[PCinit+60] = 8'b00000000;
		memory[PCinit+61] = 8'b01011000;
		memory[PCinit+62] = 8'b00100010;
		memory[PCinit+63] = 8'b10011100;
		// slt  $12,$2,$1
		memory[PCinit+64] = 8'b00000000;
		memory[PCinit+65] = 8'b01100000;
		memory[PCinit+66] = 8'b01000001;
		memory[PCinit+67] = 8'b10011100;
		// sll  $13,$5,2
		memory[PCinit+68] = 8'b10000000;
		memory[PCinit+69] = 8'b01101000;
		memory[PCinit+70] = 8'b10100000;
		memory[PCinit+71] = 8'b01100000;
		// jr  $31
		memory[PCinit+72] = 8'b00000000;
		memory[PCinit+73] = 8'b01000000;
		memory[PCinit+74] = 8'b11100000;
		memory[PCinit+75] = 8'b11100111;
	end
	
	always @(IAddr) begin
		#0.001;
		IDataOut = {memory[IAddr+3], memory[IAddr+2], memory[IAddr+1], memory[IAddr]};
	end
endmodule
