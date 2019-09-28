
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
	if(rst) begin
		IR <= 32'd0;
		        instruction[ 0] = 32'b000000_00000_00000_00000_00000_100000;	// lw $5, 0($0)
                instruction[ 1] = 32'b000000_00000_00011_00110_00000_100000;    // add $6, $0, $3      $6=$t3   
                instruction[ 2] = 32'b000000_00000_00011_00111_00000_100000;    // add $7, $0, $3      $7=$t4   
                instruction[ 3] = 32'b000000_00000_00010_01110_00000_100000;    // sw $2, 1($0) 
                instruction[ 4] = 32'b000000_00101_00001_00100_00000_100100;    // and $4, $5, $1   determin is even  10
                instruction[ 5] = 32'b000101_00101_00011_00000_00000_000111;    // bne $5, $3, 7       
                instruction[ 6] = 32'b000000_00000_00100_01111_00000_100000;    // sw $4, 2($0) 
                instruction[ 7] = 32'b000000_00000_00000_00000_00000_100000;    // NOP 
                instruction[ 8] = 32'b000000_00001_00100_00100_00000_100010;    // sub $4, $1, $4                     20
                instruction[ 9] = 32'b000010_00000_00000_00000_00001_111101;  // j 00000064    change!!                 
                instruction[10] = 32'b000000_00000_00000_00000_00000_100000;    // NOP                          
                instruction[11] = 32'b000000_00000_00000_00000_00000_100000; // NOP                           
                instruction[12] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                30
                
                instruction[13] = 32'b000000_00110_00101_01000_00000_101010;    // slt $8, $6, $5
                instruction[14] = 32'b000000_00000_00000_00000_00000_100000;    // NOP                                
                instruction[15] = 32'b000000_00000_00000_00000_00000_100000;    // NOP                          
                instruction[16] = 32'b000000_00110_00111_00110_00000_100000; // add $6, $6, $7   calculate n^(1/2) 40          
                instruction[17] = 32'b000100_01000_00000_00000_00000_001000; // beq $8, $0, 8                
                instruction[18] = 32'b000000_00000_00000_00000_00000_100000; // NOP                         
                instruction[19] = 32'b000000_00000_00000_00000_00000_100000; // NOP                       
                instruction[20] = 32'b000000_00110_00111_00110_00000_100000; // add $6, $6, $7                     50
                instruction[21] = 32'b000000_00111_00001_00111_00000_100000; // add $7, $7, $1               
                instruction[22] = 32'b000010_00000_00000_00000_00000_001101; // j 00000034                   
                instruction[23] = 32'b000000_00000_00000_00000_00000_100000; // NOP                          
                instruction[24] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                60                     
                instruction[25] = 32'b000000_00000_00000_00000_00000_100000; // NOP                           
                
                instruction[26] = 32'b000000_00101_00100_01011_00000_100000; // add $11, $5, $4  X<A                         
                instruction[27] = 32'b000000_00101_00100_01100_00000_100010; // sub $12, $5, $4  X>A
                instruction[28] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                70                           
                
                instruction[29] = 32'b000000_00000_00011_00100_00000_100000; // add $4, $0, $3
                instruction[30] = 32'b000000_01011_00010_01011_00000_100010; // sub $11, $11, $2
                instruction[31] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[32] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                80
                instruction[33] = 32'b000000_00100_00111_01000_00000_101010; // slt $8, $4, $7   jump here!!       84
                instruction[34] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[35] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[36] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                90
                instruction[37] = 32'b000100_01000_00000_00000_00000_100101; // beq $8, $0, 37
                instruction[38] = 32'b000000_00100_00100_00110_00000_100000; // add $6, $4, $4
                instruction[39] = 32'b000000_01011_00000_01001_00000_100000; // add $9, $11, $0
                instruction[40] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                A0
                 instruction[41] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[42] = 32'b000000_00110_00110_00110_00000_100000; // add $6, $6, $6 //
                instruction[43] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                 instruction[44] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                B0
                instruction[45] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[46] = 32'b000000_01001_00110_01001_00000_100010; // sub $9, $9, $6
                instruction[47] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[48] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                C0
                instruction[49] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[50] = 32'b000000_00100_01001_01000_00000_101010; // slt $8, $4, $9
                instruction[51] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[52] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                D0
                instruction[53] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[54] = 32'b000101_01000_00000_11111_11111_110111; // bne $8, $0, -9
                instruction[55] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[56] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                E0
                instruction[57] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[58] = 32'b000100_01001_00100_11111_11111_100010; // beq $9, $4, -30
                instruction[59] = 32'b000000_01001_00100_01001_00000_100000; // add $9, $9, $4 //
                instruction[60] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                F0
                instruction[61] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[62] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[63] = 32'b000100_01001_00000_11111_11111_011101; // beq $9, $0, -35 //
                instruction[64] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                100
                instruction[65] = 32'b000000_00000_00000_00000_00000_100000; // NOP                            
                instruction[66] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[67] = 32'b000000_00100_00010_00100_00000_100000; // add $4, $4, $2
                instruction[68] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                110
                instruction[69] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[70] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[71] = 32'b000010_00000_00000_00000_00000_100001; // j [38]
                instruction[72] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                120
                instruction[73] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[74] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[75] = 32'b000000_00000_01011_01110_00000_100000; // sw $11, 1($0)
                
                
                instruction[76] = 32'b000000_00000_00011_00100_00000_100000; // add $4, $0, $3                     130
                instruction[77] = 32'b000000_01100_00010_01100_00000_100000; // add $12, $12, $2
                instruction[78] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[79] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[80] = 32'b000000_00100_00111_01000_00000_101010; // slt $8, $4, $7   jump here!!       140
                instruction[81] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[82] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[83] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[84] = 32'b000100_01000_00000_00000_00000_100101; // beq $8, $0, 37                     150
                instruction[85] = 32'b000000_00100_00100_00110_00000_100000; // add $6, $4, $4
                instruction[86] = 32'b000000_01100_00000_01001_00000_100000; // add $9, $12, $0
                instruction[87] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                160
                 instruction[88] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[89] = 32'b000000_00110_00110_00110_00000_100000; // add $6, $6, $6 //
                instruction[90] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                 instruction[91] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[92] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[93] = 32'b000000_01001_00110_01001_00000_100010; // sub $9, $9, $6
                instruction[94] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[95] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[96] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[97] = 32'b000000_00100_01001_01000_00000_101010; // slt $8, $4, $9
                instruction[98] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[99] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[100] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[101] = 32'b000101_01000_00000_11111_11111_110111; // bne $8, $0, -9
                instruction[102] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[103] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[104] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[105] = 32'b000100_01001_00100_11111_11111_100010; // beq $9, $4, -30
                instruction[106] = 32'b000000_01001_00100_01001_00000_100000; // add $9, $9, $4 //
                instruction[107] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[108] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[109] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[110] = 32'b000100_01001_00000_11111_11111_011101; // beq $9, $0, -35 //
                instruction[111] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[112] = 32'b000000_00000_00000_00000_00000_100000; // NOP                            
                instruction[113] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[114] = 32'b000000_00100_00010_00100_00000_100000; // add $4, $4, $2
                instruction[115] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[116] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[117] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[118] = 32'b000010_00000_00000_00000_00001_010000; // j [38]
                instruction[119] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[120] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[121] = 32'b000000_00000_00000_00000_00000_100000; // NOP
                instruction[122] = 32'b000000_00000_01100_01111_00000_100000; // sw $12, 2($0)
                instruction[123] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[124] = 32'b000000_00000_00000_00000_00000_100000; // NOP                                
                instruction[125] = 32'b000000_00000_00000_00000_00000_100000; // NOP
	end
	else begin
		if(PC[10:2]<=8'd125) 
		  IR <= instruction[PC[10:2]]; //(0, 4, 8, ...) => (0, 1, 2, ...)
		//else
		  //IR <= IR;
	end
end

// output program counter
always @(posedge clk or posedge rst)
begin
	if(rst)
		PC <= 32'd0;
	else begin
	   if(PC[10:2]<8'd125) 
	       PC <= (branch) ? branch_addr : ( (jump) ? jump_addr : (PC+4)) ;
	   //else
	       //PC <= PC;
	end
end

endmodule