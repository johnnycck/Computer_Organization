`define CYCLE_TIME 1000
`define INSTRUCTION_NUMBERS 1000
`timescale 1ns/1ps
`include "CPU.v"

module testbench;
reg Clk, Rst;
reg [31:0] cycles, i;

// Instruction DM initialilation
initial
begin
	/*=================================================     連加     =================================================*/
	//開始處理大於cpu.MEM.DM[0]值的最小質數
	//判斷input是偶數還奇數, 若t3最後為0即為偶數
		cpu.IF.instruction[ 0] = 32'b100011_00011_01001_0000_0000_0000_0000;													// lw $t1, 0($r2) 
		cpu.IF.instruction[ 1] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 4] = 32'b100011_00011_01010_0000_0000_0000_0010;													//lw $t2, 2($r2)
		cpu.IF.instruction[ 5] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 6] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 7] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 8] = 32'b100011_00011_11000_0000_0000_0000_0010;													//lw $t8, 2($r2)
		cpu.IF.instruction[ 9] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 10] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 11] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 12] = 32'b000000_01001_01010_01011_00000_100100;													//and $t3, $t1, $t2
		cpu.IF.instruction[ 13] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 14] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 15] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		// input往上判斷, 偶數+1, 奇數+2, 數字存在t2
		cpu.IF.instruction[ 16] = 32'b000000_01001_00000_01010_00000_100000;													//add $t2, $t1, $zero
		cpu.IF.instruction[ 17] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 18] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 19] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 20] = 32'b000100_01011_11000_0000_0000_0000_0111;													//beq $t3, $t8, odd			//beq go down 7
		cpu.IF.instruction[ 21] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 22] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 23] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 24] = 32'b000100_01011_00000_0000_0000_0000_0111;													//beq $t3, $0, even			//beq go down 7
		cpu.IF.instruction[ 25] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 26] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 27] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 28] = 32'b000000_01010_11000_01010_00000_100000;													//odd:	add $t2, $t2, $t8
		cpu.IF.instruction[ 29] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 30] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 31] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 32] = 32'b000000_01010_11000_01010_00000_100000;													//even:	add $t2, $t2, $t8
		cpu.IF.instruction[ 33] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 34] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 35] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		// 從3開始往上加，判斷是否整除於t2
		cpu.IF.instruction[ 36] = 32'b100011_00011_01100_0000_0000_0000_0011;													// lw $t4, 3($r2) 
		cpu.IF.instruction[ 37] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 38] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 39] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 40] = 32'b100011_00011_11001_0000_0000_0000_0001;													//lw $t9, 1($r2)
		cpu.IF.instruction[ 41] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 42] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 43] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 44] = 32'b000100_01011_01100_0000_0000_0101_0111;													//beq, $t2, $t4, store answer			//beq go down 89
		cpu.IF.instruction[ 45] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 46] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 47] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 48] = 32'b000000_01010_00000_01101_00000_100000;													//Bloop: add, $t5, $t2, $zero
		cpu.IF.instruction[ 49] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 50] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 51] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 52] = 32'b000000_01101_01100_01000_00000_101010;													//loop:	slt, $t0, $t5, $t4
		cpu.IF.instruction[ 53] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 54] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 55] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 56] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 57] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 58] = 32'b000100_01101_01100_0000_0000_0011_0001;													//beq, $t5, $t4, exit			//beq go down 49
		cpu.IF.instruction[ 59] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 60] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 61] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 62] = 32'b000101_01000_00000_0000_0000_0000_1001;													//bne, $t0, $zero, check			//bne go down 9
		cpu.IF.instruction[ 63] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 64] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 65] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 66] = 32'b000000_01101_01100_01101_00000_100010;													// sub, $t5, $t5, $t4
		cpu.IF.instruction[ 67] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 68] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 69] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 70] = 32'b000010_00_0000_0000_0000_0000_0011_0011;												// j loop (0x51)
		cpu.IF.instruction[ 71] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 72] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 73] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		//被除數平方後若大於原數就表示該數為質數
		cpu.IF.instruction[ 74] = 32'b000100_01100_01110_0000_0000_0000_1110;												// check:	beq, $t4, $t6, plus		//beq go down 14
		cpu.IF.instruction[ 75] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 76] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 77] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 78] = 32'b000000_01110_11000_01110_00000_100000;													// add $t6, $t6, $t8
		cpu.IF.instruction[ 79] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 80] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 81] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 82] = 32'b000000_01111_01100_01111_00000_100000;													// add $t7, $t7, $t4
		cpu.IF.instruction[ 83] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 84] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 85] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 86] = 32'b000010_00_0000_0000_0000_0000_0100_1010;												// j check (0x74)
		cpu.IF.instruction[ 87] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 88]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 89] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 90] = 32'b000000_01111_01010_01000_00000_101010;													//plus:	slt, $t0, $t7, $t2
		cpu.IF.instruction[ 91] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 92] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 93] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 94] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 95] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 96] = 32'b000100_01000_00000_0000_0000_0000_1001;													//beq, $t0, $zero, exit				//beq go down 9
		cpu.IF.instruction[ 97] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 98] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 99] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 100]= 32'b000000_01100_11001_01100_00000_100000;													// add, $t4, $t4, $t9
		cpu.IF.instruction[ 101]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 102]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 103] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 104] = 32'b000010_00_0000_0000_0000_0000_0011_0000;												// j Bloop (0x48)
		cpu.IF.instruction[ 105] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 106] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 107] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 108] = 32'b000100_01101_01100_0000_0000_0000_0101;													//exit: beq, $t5, $t4, larger				//beq go down 5
		cpu.IF.instruction[ 109] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 110] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 111] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 112] = 32'b000010_00_0000_0000_0000_0000_1000_0011;												// j store answer(0x131)
		cpu.IF.instruction[ 113] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 114] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 115] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 116]= 32'b000000_01010_11001_01010_00000_100000;													// larger: add, $t2, $t2, $t9
		cpu.IF.instruction[ 117]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 118]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 119] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 120] = 32'b100011_00010_01100_0000_0000_0000_0011;													//lw $t4, 3($r2)
		cpu.IF.instruction[ 121] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 122] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 123] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 124] = 32'b000010_00_0000_0000_0000_0000_0011_0000;												// j Bloop (0x48)
		cpu.IF.instruction[ 125] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 126] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 127] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 128] = 32'b100011_00011_01010_0000_0000_0000_0001;													//lw $t2, 1($r2)
		cpu.IF.instruction[ 129] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 130] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 131] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 132] = 32'b101011_00011_01010_0000_0000_0000_1000;													//sw $t2, 8($r2)
		cpu.IF.instruction[ 133] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 134] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 135] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		///////////////////////////////////////////////////
		//開始處理小於cpu.MEM.DM[0]值的最大質數		
		///////////////////////////////////////////////////
		cpu.IF.instruction[ 136] = 32'b100011_00011_01011_0000_0000_0000_0000;													// lw $t3, 0($r2)
		cpu.IF.instruction[ 137] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 138] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 139] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 140] = 32'b100011_00010_01100_0000_0000_0000_0011;													//lw $t4, 3($r2)
		cpu.IF.instruction[ 141] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 142] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 143] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 144] = 32'b100011_00010_01101_0000_0000_0000_0011;													//lw $t5, 3($r2)
		cpu.IF.instruction[ 145] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 146] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 147] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 148] = 32'b100011_00010_01110_0000_0000_0000_0100;													//lw $t6, 4($r2)
		cpu.IF.instruction[ 149] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 150] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 151] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 152] = 32'b100011_00010_01111_0000_0000_0000_0100;													//lw $t7, 4($r2)
		cpu.IF.instruction[ 153] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 154] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 155] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 156] = 32'b100011_00011_01010_0000_0000_0000_0001;													//lw $t2, 1($r2)
		cpu.IF.instruction[ 157] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 158] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 159] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 160] = 32'b000100_01101_01011_0000_0000_0111_0111;													//beq $t5, $t3, twoS				//beq go down 119
		cpu.IF.instruction[ 161] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 162] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 163] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 164] = 32'b100011_00011_01010_0000_0000_0000_0010;													//lw $t2, 2($r2)
		cpu.IF.instruction[ 165] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 166] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 167] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 168] = 32'b000000_01001_01010_01011_00000_100100;													//and $t3, $t1, $t2
		cpu.IF.instruction[ 169] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 170] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 171] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		// 從3開始往上加，判斷是否整除於t2
		cpu.IF.instruction[ 172] = 32'b000000_01001_00000_01010_00000_100000;													//add $t2, $t1, $zero
		cpu.IF.instruction[ 173] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 174] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 175] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 176] = 32'b000100_01011_11000_0000_0000_0000_0111;													//beq $t3, $t8, oddS			//beq go down 7
		cpu.IF.instruction[ 177] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 178] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 179] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 180] = 32'b000100_01011_00000_0000_0000_0000_0111;													//beq $t3, $0, evenS			//beq go down 7
		cpu.IF.instruction[ 181] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 182] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 183] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 184] = 32'b000000_01010_11000_01010_00000_100010;													//oddS:	sub $t2, $t2, $t8
		cpu.IF.instruction[ 185] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 186] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 187] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 188] = 32'b000000_01010_11000_01010_00000_100010;													//evenS:	sub $t2, $t2, $t8
		cpu.IF.instruction[ 189] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 190] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 191] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		// input往下判斷, 偶數-1, 奇數-2, 數字存在t2
		cpu.IF.instruction[ 192] = 32'b000100_01011_01100_0000_0000_0101_0101;													//beq, $t2, $t4, store answer			//beq go down 87
		cpu.IF.instruction[ 193] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 194] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 195] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 196] = 32'b000000_01010_00000_01101_00000_100000;													//BloopS: add, $t5, $t2, $zero
		cpu.IF.instruction[ 197] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 198] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 199] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 200] = 32'b000000_01101_01100_01000_00000_101010;													//loopS:	slt, $t0, $t5, $t4
		cpu.IF.instruction[ 201] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 202] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 203] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 204] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 205] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 206] = 32'b000100_01101_01100_0000_0000_0011_0001;													//beq, $t5, $t4, exitS			//beq go down 49
		cpu.IF.instruction[ 207] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 208] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 209] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 210] = 32'b000101_01000_00000_0000_0000_0000_1001;													//bne, $t0, $zero, checkS			//bne go down 9
		cpu.IF.instruction[ 211] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 212] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 213] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 214] = 32'b000000_01101_01100_01101_00000_100010;													// sub, $t5, $t5, $t4
		cpu.IF.instruction[ 215] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 216] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 217] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 218] = 32'b000010_00_0000_0000_0000_0000_1100_0111;												// j loopS (0x199)
		cpu.IF.instruction[ 219] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 220] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 221] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 222] = 32'b000100_01100_01110_0000_0000_0000_1110;												// checkS:	beq, $t4, $t6, plusS		//beq go down 14
		cpu.IF.instruction[ 223] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 224] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 225] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 226] = 32'b000000_01110_11000_01110_00000_100000;													// add $t6, $t6, $t8
		cpu.IF.instruction[ 227] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 228] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 229] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 230] = 32'b000000_01111_01100_01111_00000_100000;													// add $t7, $t7, $t4
		cpu.IF.instruction[ 231] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 232] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 233] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 234] = 32'b000010_00_0000_0000_0000_0000_1101_1101;												// j checkS (0x221)
		cpu.IF.instruction[ 235] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 236]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 237] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 238] = 32'b000000_01111_01010_01000_00000_101010;													//plusS:	slt, $t0, $t7, $t2
		cpu.IF.instruction[ 239] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 240] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 241] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 242] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 243] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 244] = 32'b000100_01000_00000_0000_0000_0000_1001;													//beq, $t0, $zero, exitS				//beq go down 9
		cpu.IF.instruction[ 245] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 246] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 247] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 248]= 32'b000000_01100_11001_01100_00000_100000;													// add, $t4, $t4, $t9
		cpu.IF.instruction[ 249]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 250]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 251] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 252] = 32'b000010_00_0000_0000_0000_0000_1100_0011;												// j BloopS (0x195)
		cpu.IF.instruction[ 253] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 254] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 255] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 256] = 32'b000100_01101_01100_0000_0000_0000_0101;													//exitS: beq, $t5, $t4, largerS				//beq go down 5
		cpu.IF.instruction[ 257] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 258] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 259] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 260] = 32'b000010_00_0000_0000_0000_0001_0001_0111;												// j store answer(0x279)
		cpu.IF.instruction[ 261] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 262] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 263] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 264]= 32'b000000_01010_11001_01010_00000_100010;													// largerS: sub, $t2, $t2, $t9
		cpu.IF.instruction[ 265]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 266]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 267] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 268] = 32'b100011_00010_01100_0000_0000_0000_0011;													//lw $t4, 3($r2)
		cpu.IF.instruction[ 269] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 270] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 271] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 272] = 32'b000010_00_0000_0000_0000_0000_1100_0011;												// j BloopS (0x195)
		cpu.IF.instruction[ 273] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 274] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 275] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 276] = 32'b100011_00011_01010_0000_0000_0000_0001;													//lw $t2, 1($r2)
		cpu.IF.instruction[ 277] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 278] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 279] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 280] = 32'b101011_00011_01010_0000_0000_0000_1001;													//sw $t2, 9($r2)
		cpu.IF.instruction[ 281] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 282] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 283] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.PC = 0;
		
		
		
	
end

// Data Memory & Register Files initialilation
initial
begin
	cpu.MEM.DM[0] = 32'd9;			//input放在此處
	cpu.MEM.DM[1] = 32'd2;
	cpu.MEM.DM[2] = 32'd1;
	cpu.MEM.DM[3] = 32'd3;
	for (i=4; i<128; i=i+1) cpu.MEM.DM[i] = 32'b0;
		
	for (i=0; i<32; i=i+1) cpu.ID.REG[i] = 32'b0;
	
	


end

//clock cycle time is 20ns, inverse Clk value per 10ns
initial Clk = 1'b1;
always #(`CYCLE_TIME/2) Clk = ~Clk;

//Rst signal
initial begin
	cycles = 32'b0;
	Rst = 1'b1;
	#12 Rst = 1'b0;
end

CPU cpu(
	.clk(Clk),
	.rst(Rst)
);

//display all Register value and Data memory content
always @(posedge Clk) begin
	cycles <= cycles + 1;
	$display("PC: %d cycles: %d", cpu.FD_PC>>2 , cycles);
	$display("  R00-R07: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[0], cpu.ID.REG[1], cpu.ID.REG[2], cpu.ID.REG[3],cpu.ID.REG[4], cpu.ID.REG[5], cpu.ID.REG[6], cpu.ID.REG[7]);
	$display("  R08-R15: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[8], cpu.ID.REG[9], cpu.ID.REG[10], cpu.ID.REG[11],cpu.ID.REG[12], cpu.ID.REG[13], cpu.ID.REG[14], cpu.ID.REG[15]);
	$display("  R16-R23: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[16], cpu.ID.REG[17], cpu.ID.REG[18], cpu.ID.REG[19],cpu.ID.REG[20], cpu.ID.REG[21], cpu.ID.REG[22], cpu.ID.REG[23]);
	$display("  R24-R31: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[24], cpu.ID.REG[25], cpu.ID.REG[26], cpu.ID.REG[27],cpu.ID.REG[28], cpu.ID.REG[29], cpu.ID.REG[30], cpu.ID.REG[31]);
	$display("  0x00   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[0],cpu.MEM.DM[1],cpu.MEM.DM[2],cpu.MEM.DM[3],cpu.MEM.DM[4],cpu.MEM.DM[5],cpu.MEM.DM[6],cpu.MEM.DM[7]);
	$display("  0x08   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[8],cpu.MEM.DM[9],cpu.MEM.DM[10],cpu.MEM.DM[11],cpu.MEM.DM[12],cpu.MEM.DM[13],cpu.MEM.DM[14],cpu.MEM.DM[15]);
	if (cpu.MEM.DM[9]!=0) $finish; // 將答案存在 cpu.MEM.DM[8] 和 cpu.MEM.DM[9]，因此迴圈條件設定為，若cpu.MEM.DM[9]不為0，就終止程式
end

//generate wave file, it can use gtkwave to display
initial begin
	$dumpfile("cpu_hw.vcd");
	$dumpvars;
end
endmodule

