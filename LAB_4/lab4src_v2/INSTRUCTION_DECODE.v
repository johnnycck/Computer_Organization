
module INSTRUCTION_DECODE(
	clk,
	rst,
	PC,
	IR,
	MW_MemtoReg,
	MW_RegWrite,
	MW_RD,
	MDR,
	MW_ALUout,
	sw0,
    sw1,
    sw2,
    sw3,
    sw4,
    sw5,
    sw6,
    sw7,
    sw8,
    sw9,
    sw10,
    sw11,
    sw12,

	MemtoReg,
	RegWrite,
	MemRead,
	MemWrite,
	branch,
	jump,
	ALUctr,
	JT,
	DX_PC,
	NPC,
	A,
	B,
	imm,
	RD,
	MD
);

input clk, rst, MW_MemtoReg, MW_RegWrite;
input [31:0] IR, PC, MDR, MW_ALUout;
input [4:0]  MW_RD;
input sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8,sw9,sw10,sw11,sw12;

output reg MemtoReg, RegWrite, MemRead, MemWrite, branch, jump;
output reg [2:0] ALUctr;
output reg [31:0]JT, DX_PC, NPC, A, B;
output reg [15:0]imm;
output reg [4:0] RD;
output reg [31:0] MD;

//register file
reg [31:0] REG [0:31];
reg [31:0] i;

always @(posedge clk or posedge rst)
	if(rst) begin
		
		REG[0] <= 32'b00000000000000000000000000000000;
		REG[1] <= 32'b00000000000000000000000000000001;
		REG[2] <= 32'b00000000000000000000000000000010;
		REG[3] <= 32'b00000000000000000000000000000011;
		REG[4] <= 32'b00000000000000000000000000000101;
		//REG[5] <= 32'b00000000000000000000000000000011;
		REG[5] <= {19'd0,sw12,sw11,sw10,sw9,sw8,sw7,sw6,sw5,sw4,sw3,sw2,sw1,sw0};
		REG[6] <= 32'b00000000000000000000000000000000;
		REG[7] <= 32'b00000000000000000000000000000000;
		REG[8] <= 32'b00000000000000000000000000000000;
		REG[9] <= 32'b00000000000000000000000000000000;
		REG[10] <= 32'b00000000000000000000000000000000;
		REG[11] <= 32'b00000000000000000000000000000000;
		REG[12] <= 32'b00000000000000000000000000000000;
		REG[13] <= 32'b00000000000000000000000000000000;
		REG[14] <= 32'b00000000000000000000000000000000;
		REG[15] <= 32'b00000000000000000000000000000000;
	end
	else if(MW_RegWrite)
		REG[MW_RD] <= (MW_MemtoReg)? MDR : MW_ALUout;

always @(posedge clk or posedge rst)
begin
	if(rst) begin //??å?‹å??
		A 	<=32'b0;		
		MD 	<=32'b0;
		imm <=16'b0;
	    DX_PC<=32'b0;
		NPC	<=32'b0;
		jump 	<=1'b0;
		JT 	<=32'b0;
	end else begin
		A 	<=REG[IR[25:21]];
		MD 	<=REG[IR[20:16]];
		imm <=IR[15:0];
	    DX_PC<=PC;
		NPC	<=PC;
		jump<=(IR[31:26]==6'd2)?1'b1:1'b0;
		JT	<={PC[31:28], IR[25:0], 2'b00};
		
	end
end

always @(posedge clk or posedge rst)
begin
   if(rst) begin
   	    B 		<= 32'b0;
		MemtoReg<= 1'b0;
		RegWrite<= 1'b0;
		MemRead <= 1'b0;
		MemWrite<= 1'b0;
		branch  <= 1'b0;
		ALUctr	<= 3'b0;
		RD 	<=5'b0;
		
   end else begin
   		case( IR[31:26] )
		6'd0:
			begin  // R-type
				B 		<= REG[IR[20:16]];
				RD 	<=IR[15:11];
				MemtoReg<= 1'b0;
				RegWrite<= 1'b1;
				MemRead <= 1'b0;
				MemWrite<= 1'b0;
				branch  <= 1'b0;
			    case(IR[5:0])
			    	//funct
				    6'd32://add
				        ALUctr <= 3'd0;
					//sub
					6'd34:
						ALUctr <= 3'd1;
					//and
					6'd36:
						ALUctr <= 3'd2;
					//or
					6'd37:
						ALUctr <= 3'd3;
					//slt
					6'd42:
						ALUctr <= 3'd4;
		    	endcase
			end
		6'd35:  begin// lw   //å¯«ä?‹å?å?ˆç?‹è©²??‡ä»¤? ¼å¼å?Šè?Šè?Ÿç?šå“ªäº›è©²??“é?‹å“ªäº›è©²??œé?‰ï?Œinput A?œ¨ä¸Šè¿°å·²ç?“è¨­å®šå¥½äº†ï?Œé‚£??„é?è¦è¨­å®šä?éº?? for example:
				B 		<= { { 16{IR[15]} } , IR[15:0] };
			    RD 	<=IR[20:16];
			    MemtoReg<= 1'b1;
			    RegWrite<= 1'b1;
			    MemRead <= 1'b1;
			    MemWrite<= 1'b0;
			    branch  <= 1'b0;
			    ALUctr  <= 3'd0;
			    
		 	end
		6'd43:  begin// sw  //?…¶å¯¦å?šæ?•éƒ½å¾ˆé›·??Œï?Œç¢ºèªå¥½??‡ä»¤? ¼å¼å?Šè?Šè?Ÿç?šå³?¯
				B 	<= { { 16{IR[15]} } , IR[15:0] };
				RD <= IR[20:16];
				MemtoReg<=1'b0;
				RegWrite<=1'b0;
				MemRead<=1'b0;
				MemWrite<=1'b1;
				branch<=1'b0;
				ALUctr <=3'd0;
				
		 	end
		6'd4:   begin // beq
				B 		<= REG[IR[20:16]];
				MemtoReg<= 1'b0;
				RegWrite<= 1'b0;
				MemRead <= 1'b0;
				MemWrite<= 1'b0;
				branch  <= 1'b1;
				ALUctr <= 3'd5;
			end
		6'd5:   begin // bne
				B 		<= REG[IR[20:16]];
			    MemtoReg<= 1'b0;
				RegWrite<= 1'b0;
				MemRead <= 1'b0;
				MemWrite<= 1'b0;
				branch  <= 1'b1;
				ALUctr <= 3'd6;
			end
		6'd2: begin  // j
			    MemtoReg<= 1'b0;
				RegWrite<= 1'b0;
				MemRead <= 1'b0;
				MemWrite<= 1'b0;
				branch  <= 1'b0;
				ALUctr <= 3'd7;
			end

			default: begin
				//$display("ERROR instruction!!");
			end
		endcase
   end
end

endmodule