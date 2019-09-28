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
	//判斷input是偶數還奇數, 若 $11 最後為0即為偶數
		cpu.IF.instruction[ 0] = 32'b000000_00101_00001_01011_00000_100100;													//and $11, $5(input), $1(1)
		cpu.IF.instruction[ 1] = 32'b000000_00000_00101_01010_00000_100000;													// add $10, $0, $5 // $10 store input
		// input往上判斷, 偶數+1, 奇數+2, 數字存在 $10
		cpu.IF.instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 4] = 32'b000100_01011_00001_0000_0000_0000_0001;													//beq $11, $1, odd			//beq go down 1
		cpu.IF.instruction[ 5] = 32'b000100_01011_00000_0000_0000_0000_0100;													//beq $11, $0, even			//beq go down 4
		cpu.IF.instruction[ 6] = 32'b000000_01010_00001_01110_00000_100000;													//odd:	add $14, $t2, $1
		cpu.IF.instruction[ 7] = 32'b000000_01010_00001_01110_00000_100010;													//			sub $15, $t2, $1
		cpu.IF.instruction[ 8] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 9] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 10] = 32'b000000_01010_00001_01010_00000_100000;													//even:	add $14, $t2, $1
		cpu.IF.instruction[ 11] = 32'b000000_01010_00001_01010_00000_100010;													//			sub $15, $t2, $1
		// 從3開始往上加，判斷是否整除於t2
/*		cpu.IF.instruction[ 11] = 32'b000000_00000_00011_01100_00000_100000;													// add $t4, $0, $3		t4=3 
		cpu.IF.instruction[ 12] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 13] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 14] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 15] = 32'b000100_01011_01100_0000_0000_0011_1010;													//beq, $t2, $t4, store answer			//beq go down 58
		cpu.IF.instruction[ 16] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 17] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 18] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 19] = 32'b000000_01010_00000_01101_00000_100000;													//Bloop: add, $t5, $t2, $zero
		cpu.IF.instruction[ 20] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 21] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 22] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 23] = 32'b000000_01101_01100_01000_00000_101010;													//loop:	slt, $t0, $t5, $t4
		cpu.IF.instruction[ 24] = 32'b000100_01101_01100_0000_0000_0010_0011;													//beq, $t5, $t4, exit			//beq go down 35
		cpu.IF.instruction[ 25] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 26] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 27] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 28] = 32'b000101_01000_00000_0000_0000_0000_1000;													//bne, $t0, $zero, check			//bne go down 8
		cpu.IF.instruction[ 29] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 30] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 31] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 32] = 32'b000000_01101_01100_01101_00000_100010;													// sub, $t5, $t5, $t4
		cpu.IF.instruction[ 33] = 32'b000010_00_0000_0000_0000_0000_0001_0111;												// j loop (0x23)
		cpu.IF.instruction[ 34] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 35] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 36] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		//被除數平方後若大於原數就表示該數為質數
		cpu.IF.instruction[ 37] = 32'b000100_01100_01110_0000_0000_0000_1001;												// check:	beq, $t4, $t6, plus		//beq go down 9
		cpu.IF.instruction[ 38] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 39] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 40] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 41] = 32'b000000_01110_00001_01110_00000_100000;													// add $t6, $t6, $1
		cpu.IF.instruction[ 42] = 32'b000000_01111_01100_01111_00000_100000;													// add $t7, $t7, $t4
		cpu.IF.instruction[ 43] = 32'b000010_00_0000_0000_0000_0000_0010_0101;												// j check (0x37)
		cpu.IF.instruction[ 44] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 45]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 46] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 47] = 32'b000000_01111_01010_01000_00000_101010;													//plus:	slt, $t0, $t7, $t2
		cpu.IF.instruction[ 48] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 49] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 50] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 51] = 32'b000100_01000_00000_0000_0000_0000_1000;													//beq, $t0, $zero, exit				//beq go down 8
		cpu.IF.instruction[ 52] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 53] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 54] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 55]= 32'b000000_01100_00010_01100_00000_100000;													// add, $t4, $t4, $2
		cpu.IF.instruction[ 56] = 32'b000010_00_0000_0000_0000_0000_0001_0011;												// j Bloop (0x19)
		cpu.IF.instruction[ 57] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 58] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 59] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 60] = 32'b000100_01101_01100_0000_0000_0000_0111;													//exit: beq, $t5, $t4, larger				//beq go down 7
		cpu.IF.instruction[ 61] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 62] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 63] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 64] = 32'b000010_00_0000_0000_0000_0000_0100_1010;												// j store answer(0x74)
		cpu.IF.instruction[ 65] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 66] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 67] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 68]= 32'b000000_01010_00010_01010_00000_100000;													// larger: add, $t2, $t2, $2
		cpu.IF.instruction[ 69] = 32'b000000_00000_00011_00100_00000_100000;													// add $t4, $0, $3		t4=3
		cpu.IF.instruction[ 70] = 32'b000010_00_0000_0000_0000_0000_0001_0011;												// j Bloop (0x19)
		cpu.IF.instruction[ 71] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 72] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 73] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 74] =32'b000000_01010_00000_01110_00000_100000;													//store answer 		add $14, $t2, $0		t14 store answer_larger
		cpu.IF.instruction[ 75] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 76] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		//////////////////////////////////////////////////
		//開始處理小於cpu.MEM.DM[0]值的最大質數		
		///////////////////////////////////////////////////
		cpu.IF.instruction[ 77] = 32'b000000_00000_00011_01100_00000_100000;													//add $t4, $0, $3		t4=3
		cpu.IF.instruction[ 78] = 32'b000000_00000_00011_01101_00000_100000;													//add $t5, $0, $3		t5=3
		cpu.IF.instruction[ 79] = 32'b000000_00000_00110_11001_00000_100000;													//add $t9, $0, $t6		t9=0
		cpu.IF.instruction[ 80] = 32'b000000_00000_00110_01111_00000_100000;													//add $t7, $0, $6			t7=0
		cpu.IF.instruction[ 81] = 32'b000000_00000_00010_01010_00000_100000;													//add $t2, $0, $2			t2 = 2
		cpu.IF.instruction[ 82] = 32'b000100_01101_00101_0000_0000_0100_1100;													//beq $t5, $5, twoS				//beq go down 76
		cpu.IF.instruction[ 83] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 84] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 85] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		//判斷input是偶數還奇數, 若t3最後為0即為偶數
		cpu.IF.instruction[ 86] = 32'b000000_00101_00001_01011_00000_100100;													//and $t3, $5, $1
		cpu.IF.instruction[ 87] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 88] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		// input往下判斷, 偶數-1, 奇數-2, 數字存在t2
		cpu.IF.instruction[ 89] = 32'b000000_00101_00000_01010_00000_100000;													//add $t2, $5, $zero
		cpu.IF.instruction[ 90] = 32'b000100_01011_00001_0000_0000_0000_0001;													//beq $t3, $1, oddS			//beq go down 1
		cpu.IF.instruction[ 91] = 32'b000100_01011_00000_0000_0000_0000_0100;													//beq $t3, $0, evenS			//beq go down 4
		cpu.IF.instruction[ 92] = 32'b000000_01010_00001_01010_00000_100000;													//oddS:	sub $t2, $t2, $1
		cpu.IF.instruction[ 93] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 94] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 95] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 96] = 32'b000000_01010_00001_01010_00000_100000;													//evenS:	sub $t2, $t2, $1
		cpu.IF.instruction[ 97] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 98] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 99] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		// 從3開始往上加，判斷是否整除於t2
		cpu.IF.instruction[ 100] = 32'b000100_01011_01100_0000_0000_0011_1010;													//beq, $t2, $t4, store answer			//beq go down 58
		cpu.IF.instruction[ 101] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 102] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 103] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 104] = 32'b000000_01010_00000_01101_00000_100000;													//Bloop: add, $t5, $t2, $zero
		cpu.IF.instruction[ 105] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 106] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 107] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 108] = 32'b000000_01101_01100_01000_00000_101010;													//loop:	slt, $t0, $t5, $t4
		cpu.IF.instruction[ 109] = 32'b000100_01101_01100_0000_0000_0010_0011;													//beq, $t5, $t4, exit			//beq go down 35
		cpu.IF.instruction[ 110] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 111] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 112] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 113] = 32'b000101_01000_00000_0000_0000_0000_1000;													//bne, $t0, $zero, check			//bne go down 8
		cpu.IF.instruction[ 114] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 115] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 116] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 117] = 32'b000000_01101_01100_01101_00000_100010;													// sub, $t5, $t5, $t4
		cpu.IF.instruction[ 118] = 32'b000010_00_0000_0000_0000_0000_0110_1100;												// j loop (0x108)
		cpu.IF.instruction[ 119] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 120] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 121] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		//被除數平方後若大於原數就表示該數為質數
		cpu.IF.instruction[ 122] = 32'b000100_01100_11001_0000_0000_0000_1001;												// check:	beq, $t4, $t9, plus		//beq go down 9
		cpu.IF.instruction[ 123]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 124] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 125] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 126] = 32'b000000_11001_00001_11001_00000_100000;													// add $t9, $t9, $1
		cpu.IF.instruction[ 127] = 32'b000000_01111_01100_01111_00000_100000;													// add $t7, $t7, $t4
		cpu.IF.instruction[ 128] = 32'b000010_00_0000_0000_0000_0000_0111_1010;												// j check (0x122)
		cpu.IF.instruction[ 129] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 130]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 131] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 132] = 32'b000000_01111_01010_01000_00000_101010;													//plus:	slt, $t0, $t7, $t2
		cpu.IF.instruction[ 133] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 134] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 135] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 136] = 32'b000100_01000_00000_0000_0000_0000_1000;													//beq, $t0, $zero, exit				//beq go down 8
		cpu.IF.instruction[ 137] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 138] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 139] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 140]= 32'b000000_01100_00010_01100_00000_100000;													// add, $t4, $t4, $2
		cpu.IF.instruction[ 141] = 32'b000010_00_0000_0000_0000_0000_0110_1000;												// j Bloop (0x104)
		cpu.IF.instruction[ 142] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 143] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 144] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 145] = 32'b000100_01101_01100_0000_0000_0000_0111;													//exit: beq, $t5, $t4, larger				//beq go down 7
		cpu.IF.instruction[ 146] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 147] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 148] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 149] = 32'b000010_00_0000_0000_0000_0000_1001_1111;												// j store answer(0x159)
		cpu.IF.instruction[ 150] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 151] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 152] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 153]= 32'b000000_01010_00010_01010_00000_100000;													// larger: add, $t2, $t2, $2
		cpu.IF.instruction[ 154] = 32'b000000_00000_00011_00100_00000_100000;													// add $t4, $0, $3		t4=3
		cpu.IF.instruction[ 155] = 32'b000010_00_0000_0000_0000_0000_0110_1000;												// j Bloop (0x104)
		cpu.IF.instruction[ 156] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 157] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 158] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 159] =32'b000000_01010_00000_01111_00000_100000;		//											store answer 		add $15, $t2, $0		t14 store answer_larger
		cpu.IF.instruction[ 160] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 161] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
*/		cpu.IF.PC = 0;
		
		
		
	
end

// Data Memory & Register Files initialilation
initial
begin
//	cpu.MEM.DM[0] = 32'd9;			//input放在此處
	//cpu.MEM.DM[1] = 32'd2;
	//cpu.MEM.DM[2] = 32'd1;
	//cpu.MEM.DM[3] = 32'd3;
	for (i=0; i<128; i=i+1) cpu.MEM.DM[i] = 32'b0;
		
	for (i=0; i<32; i=i+1) cpu.ID.REG[i] = 32'b0;
	cpu.ID.REG[1]=32'd1;
	cpu.ID.REG[2]=32'd2;
	cpu.ID.REG[3]=32'd3;
	cpu.ID.REG[5]=32'd7;
	


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
	if (cpu.ID.REG[15]==5) $finish; // 將答案存在 cpu.MEM.DM[8] 和 cpu.MEM.DM[9]，因此迴圈條件設定為，若cpu.MEM.DM[9]不為0，就終止迴圈
end

//generate wave file, it can use gtkwave to display
initial begin
	$dumpfile("cpu_hw.vcd");
	$dumpvars;
end
endmodule

