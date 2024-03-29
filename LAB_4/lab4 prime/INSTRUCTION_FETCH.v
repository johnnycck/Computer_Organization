
module INSTRUCTION_FETCH(
	clk,
	rst,
	jump,
	branch,
	jump_addr,
	branch_addr,

	PC,
	IR
);

input clk, rst, jump, branch;
input [31:0] jump_addr, branch_addr;

output reg 	[31:0] PC;
output reg 	[31:0] IR;

reg [31:0] instruction [255:0];
//output instruction
always @(posedge clk or posedge rst)
begin
	if(rst)	begin
		IR <= 32'd0;
			instruction[ 0] = 32'b000000_00101_00001_01011_00000_100100;													//and $t3, $5(input), $1(1)
			instruction[ 1] = 32'b000000_00000_00101_01010_00000_100000;													// add $t2, $0, $5 //	t2 store input
		// input往上判斷, 偶數+1, 奇數+2, 數字存在t2
			instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 4] = 32'b000100_01011_00001_0000_0000_0000_0001;													//beq $t3, $1, odd			//beq go down 1
			instruction[ 5] = 32'b000100_01011_00000_0000_0000_0000_0100;													//beq $t3, $0, even			//beq go down 4
			instruction[ 6] = 32'b000000_01010_00001_01010_00000_100000;													//odd:	add $t2, $t2, $1
			instruction[ 7] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 8] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 9] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 10] = 32'b000000_01010_00001_01010_00000_100000;													//even:	add $t2, $t2, $1
		// 從3開始往上加，判斷是否整除於t2
			instruction[ 11] = 32'b000000_00000_00011_01100_00000_100000;													// add $t4, $0, $3		t4=3 
			instruction[ 12] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 13] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 14] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 15] = 32'b000100_01011_01100_0000_0000_0011_1010;													//beq, $t2, $t4, store answer			//beq go down 58
			instruction[ 16] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 17] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 18] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 19] = 32'b000000_01010_00000_01101_00000_100000;													//Bloop: add, $t5, $t2, $zero
			instruction[ 20] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 21] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 22] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 23] = 32'b000000_01101_01100_01000_00000_101010;													//loop:	slt, $t0, $t5, $t4
			instruction[ 24] = 32'b000100_01101_01100_0000_0000_0010_0011;													//beq, $t5, $t4, exit			//beq go down 35
			instruction[ 25] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 26] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 27] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 28] = 32'b000101_01000_00000_0000_0000_0000_1000;													//bne, $t0, $zero, check			//bne go down 8
			instruction[ 29] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 30] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 31] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 32] = 32'b000000_01101_01100_01101_00000_100010;													// sub, $t5, $t5, $t4
			instruction[ 33] = 32'b000010_00_0000_0000_0000_0000_0001_0111;												// j loop (0x23)
			instruction[ 34] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 35] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 36] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		//被除數平方後若大於原數就表示該數為質數
			instruction[ 37] = 32'b000100_01100_01110_0000_0000_0000_1001;												// check:	beq, $t4, $t6, plus		//beq go down 9
			instruction[ 38] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 39] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 40] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 41] = 32'b000000_01110_00001_01110_00000_100000;													// add $t6, $t6, $1
			instruction[ 42] = 32'b000000_00111_01100_00111_00000_100000;													// add $7, $7, $t4
			instruction[ 43] = 32'b000010_00_0000_0000_0000_0000_0010_0101;												// j check (0x37)
			instruction[ 44] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 45]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 46] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 47] = 32'b000000_00111_01010_01000_00000_101010;													//plus:	slt, $t0, $7, $t2
			instruction[ 48] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 49] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 50] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 51] = 32'b000100_01000_00000_0000_0000_0000_1000;													//beq, $t0, $zero, exit				//beq go down 8
			instruction[ 52] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 53] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 54] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 55]= 32'b000000_01100_00010_01100_00000_100000;													// add, $t4, $t4, $2
			instruction[ 56] = 32'b000010_00_0000_0000_0000_0000_0001_0011;												// j Bloop (0x19)
			instruction[ 57] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 58] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 59] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 60] = 32'b000100_01101_01100_0000_0000_0000_0111;													//exit: beq, $t5, $t4, larger				//beq go down 7
			instruction[ 61] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 62] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 63] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 64] = 32'b000010_00_0000_0000_0000_0000_0100_1010;												// j store answer(0x74)
			instruction[ 65] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 66] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 67] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 68]= 32'b000000_01010_00010_01010_00000_100000;													// larger: add, $t2, $t2, $2
			instruction[ 69] = 32'b000000_00000_00011_00100_00000_100000;													// add $t4, $0, $3		t4=3
			instruction[ 70] = 32'b000010_00_0000_0000_0000_0000_0001_0011;												// j Bloop (0x19)
			instruction[ 71] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 72] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 73] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 74] =32'b000000_01010_00000_01110_00000_100000;													//store answer 		add $14, $t2, $0		t14 store answer_larger
			instruction[ 75] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 76] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		//////////////////////////////////////////////////
		//開始處理大於cpu.MEM.DM[0]值的最小質數		
		///////////////////////////////////////////////////
			instruction[ 77] = 32'b000000_00000_00011_01100_00000_100000;													//add $t4, $0, $3		t4=3
			instruction[ 78] = 32'b000000_00000_00011_01101_00000_100000;													//add $t5, $0, $3		t5=3
			instruction[ 79] = 32'b000000_00000_00110_11001_00000_100000;													//add $t9, $0, $t6		t9=0
			instruction[ 80] = 32'b000000_00000_00110_00111_00000_100000;													//add $7, $0, $6			7=0
			instruction[ 81] = 32'b000000_00000_00010_01010_00000_100000;													//add $t2, $0, $2			t2 = 2
			instruction[ 82] = 32'b000100_01101_00101_0000_0000_0100_1100;													//beq $t5, $5, twoS				//beq go down 76
			instruction[ 83] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 84] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 85] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		//判斷input是偶數還奇數, 若t3最後為0即為偶數
			instruction[ 86] = 32'b000000_00101_00001_01011_00000_100100;													//and $t3, $5, $1
			instruction[ 87] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 88] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		// input往下判斷, 偶數-1, 奇數-2, 數字存在t2
			instruction[ 89] = 32'b000000_00101_00000_01010_00000_100000;													//add $t2, $5, $zero
			instruction[ 90] = 32'b000100_01011_00001_0000_0000_0000_0001;													//beq $t3, $1, oddS			//beq go down 1
			instruction[ 91] = 32'b000100_01011_00000_0000_0000_0000_0100;													//beq $t3, $0, evenS			//beq go down 4
			instruction[ 92] = 32'b000000_01010_00001_01010_00000_100010;													//oddS:	sub $t2, $t2, $1
			instruction[ 93] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 94] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 95] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 96] = 32'b000000_01010_00001_01010_00000_100010;													//evenS:	sub $t2, $t2, $1
			instruction[ 97] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 98] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 99] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		// 從3開始往上加，判斷是否整除於t2
			instruction[ 100] = 32'b000100_01011_01100_0000_0000_0011_1010;													//beq, $t2, $t4, store answer			//beq go down 58
			instruction[ 101] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 102] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 103] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 104] = 32'b000000_01010_00000_01101_00000_100000;													//Bloop: add, $t5, $t2, $zero
			instruction[ 105] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 106] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 107] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 108] = 32'b000000_01101_01100_01000_00000_101010;													//loop:	slt, $t0, $t5, $t4
			instruction[ 109] = 32'b000100_01101_01100_0000_0000_0010_0011;													//beq, $t5, $t4, exit			//beq go down 35
			instruction[ 110] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 111] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 112] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 113] = 32'b000101_01000_00000_0000_0000_0000_1000;													//bne, $t0, $zero, check			//bne go down 8
			instruction[ 114] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 115] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 116] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 117] = 32'b000000_01101_01100_01101_00000_100010;													// sub, $t5, $t5, $t4
			instruction[ 118] = 32'b000010_00_0000_0000_0000_0000_0110_1100;												// j loop (0x108)
			instruction[ 119] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 120] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 121] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		//被除數平方後若大於原數就表示該數為質數
			instruction[ 122] = 32'b000100_01100_11001_0000_0000_0000_1001;												// check:	beq, $t4, $t9, plus		//beq go down 9
			instruction[ 123]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 124] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 125] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 126] = 32'b000000_11001_00001_11001_00000_100000;													// add $t9, $t9, $1
			instruction[ 127] = 32'b000000_00111_01100_00111_00000_100000;													// add $7, $7, $t4
			instruction[ 128] = 32'b000010_00_0000_0000_0000_0000_0111_1010;												// j check (0x122)
			instruction[ 129] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 130]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 131] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 132] = 32'b000000_00111_01010_01000_00000_101010;													//plus:	slt, $t0, $7, $t2
			instruction[ 133] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 134] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 135] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 136] = 32'b000100_01000_00000_0000_0000_0000_1000;													//beq, $t0, $zero, exit				//beq go down 8
			instruction[ 137] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 138] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 139] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 140]= 32'b000000_01100_00010_01100_00000_100000;													// add, $t4, $t4, $2
			instruction[ 141] = 32'b000010_00_0000_0000_0000_0000_0110_1000;												// j Bloop (0x104)
			instruction[ 142] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 143] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 144] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 145] = 32'b000100_01101_01100_0000_0000_0000_0111;													//exit: beq, $t5, $t4, larger				//beq go down 7
			instruction[ 146] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 147] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 148] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 149] = 32'b000010_00_0000_0000_0000_0000_1001_1111;												// j store answer(0x159)
			instruction[ 150] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 151] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 152] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 153]= 32'b000000_01010_00010_01010_00000_100000;													// larger: add, $t2, $t2, $2
			instruction[ 154] = 32'b000000_00000_00011_00100_00000_100000;													// add $t4, $0, $3		t4=3
			instruction[ 155] = 32'b000010_00_0000_0000_0000_0000_0110_1000;												// j Bloop (0x104)
			instruction[ 156] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 157] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 158] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 159] =32'b000000_01010_00000_01111_00000_100000;		//											store answer 		add $15, $t2, $0		t14 store answer_larger
			instruction[ 160] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
			instruction[ 161] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
			instruction[ 162] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
	end
	else begin
		if(PC[10:2]<=8'd162)
			IR <= instruction[PC[10:2]];
	end		
end

// output program counter
always @(posedge clk or posedge rst)
begin
	if(rst)
		PC <= 32'd0;
	else	begin
		if(PC[10:2]<8'd162)
			PC <= (branch) ? branch_addr : ( (jump) ? jump_addr : (PC+4)) ;
		end	
end

endmodule