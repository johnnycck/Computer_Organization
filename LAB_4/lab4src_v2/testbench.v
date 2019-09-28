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
	   	cpu.IF.instruction[ 0] = 32'b000000_00101_00001_01011_00000_100100;    													//and $11, $5, $1   if $10=0 ,input is even; 	if $10=1, input is odd
		cpu.IF.instruction[ 1] = 32'b000000_00001_00101_00111_00000_100000;														// add $7, $1, $5					 // $7 store input+1
		cpu.IF.instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 4] = 32'b000100_01011_00000_0000_0000_0000_1000;													//beq, $11, $0, start 			//beq go down 8
		cpu.IF.instruction[ 5] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 6] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 7] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 8] = 32'b000000_00111_00001_00111_00000_100000;														// add $7, $7, $1 				// $7 +1
		cpu.IF.instruction[ 9] = 32'b000100_00011_00101_0000_0000_0010_1100;													//beq, $3, $5, store answer 			//beq go down 44
		cpu.IF.instruction[ 10] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 11] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 12] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 13] = 32'b000000_00011_00000_00110_00000_100000;														// start: add $6, $3, $0 					// $6 initial = 3
		cpu.IF.instruction[ 14] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 15] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 16] = 32'b000000_00111_00000_01010_00000_100000;														// Reloop:		add $10, $7, $0 // $10 = $7		
		cpu.IF.instruction[ 17] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 18] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 19] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)			
		cpu.IF.instruction[ 20] = 32'b000000_01010_00110_01000_00000_101010;														//loop:	slt, $8, $10, $6
		cpu.IF.instruction[ 21] = 32'b000100_01010_00110_0000_0000_0001_1001;													//beq, $10, $6, add_input			//beq go down 25
		cpu.IF.instruction[ 22] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 23] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 24] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 25] = 32'b000101_01000_00000_0000_0000_0000_1010;													//bne, $8, $0,  leave loop			//bne go down 10
		cpu.IF.instruction[ 26] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 27] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 28] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 29] = 32'b000000_01010_00110_01010_00000_100010;													// sub, $10, $10, $6
		cpu.IF.instruction[ 30] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 31] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 32] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 33] = 32'b000010_00_0000_0000_0000_0000_0001_0100;												// j loop (0x20)
		cpu.IF.instruction[ 34] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 35] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 36]= 32'b000000_00110_00010_00110_00000_100000;													// leave loop: add, $6, $6, $2
		cpu.IF.instruction[ 37] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 38] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 39] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 40] = 32'b000100_00110_00111_0000_0000_0000_1101 ;													//beq, $6, $7, store answer				//beq go down 13
		cpu.IF.instruction[ 41] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 42] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 43] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)		
		cpu.IF.instruction[ 44] = 32'b000010_00_0000_0000_0000_0000_0001_0000;												// j Reloop (0x16)
		cpu.IF.instruction[ 45] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 46] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 47]= 32'b000000_00111_00010_00111_00000_100000;													// add_input: add, $7, $7, $2
		cpu.IF.instruction[ 48] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 49] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 50] = 32'b000000_00000_00011_00110_00000_100000;													// add $6, $0, $3		$6=3
		cpu.IF.instruction[ 51] = 32'b000010_00_0000_0000_0000_0000_0001_0000;												// j Reloop (0x16)
		cpu.IF.instruction[ 52] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 53] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 54] = 32'b000000_00000_00111_01110_00000_100000;													// store answer	add $14, $0, $7		$14 = answer_larger
		cpu.IF.instruction[ 55] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 56] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		//////////////////////////////////////////////////
		//開始處理小於cpu.MEM.DM[0]值的最大質數		
		///////////////////////////////////////////////////
		cpu.IF.instruction[ 57] = 32'b000000_00101_00001_00111_00000_100010;														// sub $7, $5, $1					 // $7 store input-1
		cpu.IF.instruction[ 58] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 59] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 60] = 32'b000100_00011_00101_0000_0000_0011_0101;													//beq, $3, $5, store answer 			//beq go down 53
		cpu.IF.instruction[ 61] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 62] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 63] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 64] = 32'b000100_01011_00000_0000_0000_0000_0100;													//beq, $11, $0, start 			//beq go down 4
		cpu.IF.instruction[ 65] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 66] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 67] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 68] = 32'b000000_00111_00001_00111_00000_100010;														// sub $7, $7, $1 				// $7 -1
		cpu.IF.instruction[ 69] = 32'b000000_00011_00000_00110_00000_100000;														// start: add $6, $3, $0 					// $6 initial = 3
		cpu.IF.instruction[ 70] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 71] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 72] = 32'b000000_00111_00000_01010_00000_100000;														// Reloop:		add $10, $7, $0 // $10 = $7		
		cpu.IF.instruction[ 73] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 74] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 75] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)			
		cpu.IF.instruction[ 76] = 32'b000000_01010_00110_01000_00000_101010;														//loop:	slt, $8, $10, $6
		cpu.IF.instruction[ 77] = 32'b000100_01010_00110_0000_0000_0001_1001;													//beq, $10, $6, minus_input			//beq go down 25
		cpu.IF.instruction[ 78] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 79] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 80] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 81] = 32'b000101_01000_00000_0000_0000_0000_1010;													//bne, $8, $0,  leave loop			//bne go down 10
		cpu.IF.instruction[ 82] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 83] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 84] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 85] = 32'b000000_01010_00110_01010_00000_100010;													// sub, $10, $10, $6
		cpu.IF.instruction[ 86] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 87] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 88] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 89] = 32'b000010_00_0000_0000_0000_0000_0100_1100;												// j loop (0x76)
		cpu.IF.instruction[ 90] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 91] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 92]= 32'b000000_00110_00010_00110_00000_100000;													// leave loop: add, $6, $6, $2
		cpu.IF.instruction[ 93] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 94] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 95] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 96] = 32'b000100_00110_00111_0000_0000_0001_0001 ;													//beq, $6, $7, store answer				//beq go down 17
		cpu.IF.instruction[ 97] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 98] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 99] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)		
		cpu.IF.instruction[ 100] = 32'b000010_00_0000_0000_0000_0000_0100_1000;												// j Reloop (0x72)
		cpu.IF.instruction[ 101] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 102] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 103] = 32'b000100_00110_00111_0000_0000_0000_1010 ;													//minus_input: beq, $3, $7, store answer				//beq go down 10
		cpu.IF.instruction[ 104] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 105] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 106] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)		
		cpu.IF.instruction[ 107]= 32'b000000_00111_00010_00111_00000_100010;													//  sub, $7, $7, $2
		cpu.IF.instruction[ 108] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 109] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 110] = 32'b000000_00000_00011_00110_00000_100000;													// add $6, $0, $3		$6=3
		cpu.IF.instruction[ 111] = 32'b000010_00_0000_0000_0000_0000_0100_1000;												// j Reloop (0x72)
		cpu.IF.instruction[ 112] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 113] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 114] = 32'b000000_00000_00111_01111_00000_100000;													// store answer	add $15, $0, $7		$14 = answer_larger
		cpu.IF.instruction[ 115] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 116] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.PC = 0;
		
		
		
	
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
	cpu.ID.REG[4]=32'd4;
	cpu.ID.REG[5]=32'd3;
	


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
	if (cpu.ID.REG[15]==2) $finish; // 將答案存在 cpu.MEM.DM[8] 和 cpu.MEM.DM[9]，因此迴圈條件設定為，若cpu.MEM.DM[9]不為0，就終止迴圈
end

//generate wave file, it can use gtkwave to display
initial begin
	$dumpfile("cpu_hw.vcd");
	$dumpvars;
end
endmodule

