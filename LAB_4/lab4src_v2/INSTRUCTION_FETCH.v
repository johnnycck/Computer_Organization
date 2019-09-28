
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
		instruction[ 0] = 32'b000000_00101_00001_01011_00000_100100;    													//and $11, $5, $1   if $10=0 ,input is even; 	if $10=1, input is odd
		instruction[ 1] = 32'b000000_00001_00101_00111_00000_100000;														// add $7, $1, $5					 // $7 store input+1
		instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 4] = 32'b000100_01011_00000_0000_0000_0000_1000;													//beq, $11, $0, start 			//beq go down 8
		instruction[ 5] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 6] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 7] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 8] = 32'b000000_00111_00001_00111_00000_100000;														// add $7, $7, $1 				// $7 +1
		instruction[ 9] = 32'b000100_00011_00101_0000_0000_0010_1100;													//beq, $3, $5, store answer 			//beq go down 44
		instruction[ 10] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 11] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 12] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 13] = 32'b000000_00011_00000_00110_00000_100000;														// start: add $6, $3, $0 					// $6 initial = 3
		instruction[ 14] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 15] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 16] = 32'b000000_00111_00000_01010_00000_100000;														// Reloop:		add $10, $7, $0 // $10 = $7		
		instruction[ 17] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 18] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 19] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)			
		instruction[ 20] = 32'b000000_01010_00110_01000_00000_101010;														//loop:	slt, $8, $10, $6
		instruction[ 21] = 32'b000100_01010_00110_0000_0000_0001_1001;													//beq, $10, $6, add_input			//beq go down 25
		instruction[ 22] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 23] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 24] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		instruction[ 25] = 32'b000101_01000_00000_0000_0000_0000_1010;													//bne, $8, $0,  leave loop			//bne go down 10
		instruction[ 26] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 27] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 28] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		instruction[ 29] = 32'b000000_01010_00110_01010_00000_100010;													// sub, $10, $10, $6
		instruction[ 30] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 31] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 32] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		instruction[ 33] = 32'b000010_00_0000_0000_0000_0000_0001_0100;												// j loop (0x20)
		instruction[ 34] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 35] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 36]= 32'b000000_00110_00010_00110_00000_100000;													// leave loop: add, $6, $6, $2
		instruction[ 37] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 38] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 39] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		instruction[ 40] = 32'b000100_00110_00111_0000_0000_0000_1101 ;													//beq, $6, $7, store answer				//beq go down 13
		instruction[ 41] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 42] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 43] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)		
		instruction[ 44] = 32'b000010_00_0000_0000_0000_0000_0001_0000;												// j Reloop (0x16)
		instruction[ 45] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 46] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 47]= 32'b000000_00111_00010_00111_00000_100000;													// add_input: add, $7, $7, $2
		instruction[ 48] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 49] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 50] = 32'b000000_00000_00011_00110_00000_100000;													// add $6, $0, $3		$6=3
		instruction[ 51] = 32'b000010_00_0000_0000_0000_0000_0001_0000;												// j Reloop (0x16)
		instruction[ 52] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 53] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 54] = 32'b000000_00000_00111_01110_00000_100000;													// store answer	add $14, $0, $7		$14 = answer_larger
		instruction[ 55] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 56] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		//////////////////////////////////////////////////
		//開始處理小於cpu.MEM.DM[0]值的最大質數		
		///////////////////////////////////////////////////
		instruction[ 57] = 32'b000000_00101_00001_00111_00000_100010;														// sub $7, $5, $1					 // $7 store input-1
		instruction[ 58] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 59] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 60] = 32'b000100_00011_00101_0000_0000_0011_0101;													//beq, $3, $5, store answer 			//beq go down 53
		instruction[ 61] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 62] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 63] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 64] = 32'b000100_01011_00000_0000_0000_0000_0100;													//beq, $11, $0, start 			//beq go down 4
		instruction[ 65] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 66] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 67] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 68] = 32'b000000_00111_00001_00111_00000_100010;														// sub $7, $7, $1 				// $7 -1
		instruction[ 69] = 32'b000000_00011_00000_00110_00000_100000;														// start: add $6, $3, $0 					// $6 initial = 3
		instruction[ 70] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 71] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 72] = 32'b000000_00111_00000_01010_00000_100000;														// Reloop:		add $10, $7, $0 // $10 = $7		
		instruction[ 73] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 74] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 75] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)			
		instruction[ 76] = 32'b000000_01010_00110_01000_00000_101010;														//loop:	slt, $8, $10, $6
		instruction[ 77] = 32'b000100_01010_00110_0000_0000_0001_1001;													//beq, $10, $6, minus_input			//beq go down 25
		instruction[ 78] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 79] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 80] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		instruction[ 81] = 32'b000101_01000_00000_0000_0000_0000_1010;													//bne, $8, $0,  leave loop			//bne go down 10
		instruction[ 82] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 83] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 84] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		instruction[ 85] = 32'b000000_01010_00110_01010_00000_100010;													// sub, $10, $10, $6
		instruction[ 86] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 87] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 88] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		instruction[ 89] = 32'b000010_00_0000_0000_0000_0000_0100_1100;												// j loop (0x76)
		instruction[ 90] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 91] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 92]= 32'b000000_00110_00010_00110_00000_100000;													// leave loop: add, $6, $6, $2
		instruction[ 93] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 94] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 95] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		instruction[ 96] = 32'b000100_00110_00111_0000_0000_0001_0001 ;													//beq, $6, $7, store answer				//beq go down 17
		instruction[ 97] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 98] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 99] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)		
		instruction[ 100] = 32'b000010_00_0000_0000_0000_0000_0100_1000;												// j Reloop (0x72)
		instruction[ 101] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 102] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 103] = 32'b000100_00110_00111_0000_0000_0000_1010 ;													//minus_input: beq, $3, $7, store answer				//beq go down 10
		instruction[ 104] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 105] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 106] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)		
		instruction[ 107]= 32'b000000_00111_00010_00111_00000_100010;													//  sub, $7, $7, $2
		instruction[ 108] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 109] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 110] = 32'b000000_00000_00011_00110_00000_100000;													// add $6, $0, $3		$6=3
		instruction[ 111] = 32'b000010_00_0000_0000_0000_0000_0100_1000;												// j Reloop (0x72)
		instruction[ 112] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 113] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 114] = 32'b000000_00000_00111_01111_00000_100000;													// store answer	add $15, $0, $7		$14 = answer_larger
		instruction[ 115] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		instruction[ 116] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
	end
	else begin
		if(PC[10:2]<=8'd116)
			IR <= instruction[PC[10:2]];
	end		
end

// output program counter
always @(posedge clk or posedge rst)
begin
	if(rst)
		PC <= 32'd0;
	else	begin
		if(PC[10:2]<8'd116)
			PC <= (branch) ? branch_addr : ( (jump) ? jump_addr : (PC+4)) ;
		end	
end

endmodule