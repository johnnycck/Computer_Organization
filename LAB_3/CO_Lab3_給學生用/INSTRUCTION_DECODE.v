`timescale 1ns/1ps

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
	MD,
);

input clk, rst, MW_MemtoReg, MW_RegWrite;
input [31:0] IR, PC, MDR, MW_ALUout;
input [4:0]  MW_RD;

output reg MemtoReg, RegWrite, MemRead, MemWrite, branch, jump;
output reg [2:0] ALUctr;
output reg [31:0]JT, DX_PC, NPC, A, B;
output reg [15:0]imm;
output reg [4:0] RD;
output reg [31:0] MD;

//register file
reg [31:0] REG [0:31];

always @(posedge clk or posedge rst)
	if(rst) begin
		A 	<=32'b0;
	end
	else if(MW_RegWrite)
		REG[MW_RD] <= (MW_MemtoReg)? MDR : MW_ALUout;

always @(posedge clk or posedge rst)
begin
	if(rst) begin //初始化
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
		JT	<={PC[31:28], IR[26:0], 2'b0};
		
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
					
					//and
					
					//or
					
					//slt
					    
		    	endcase
			end
		6'd35:  begin// lw   //寫之前先看該指令格式及訊號線哪些該打開哪些該關閉，input A在上述已經設定好了，那還需要設定什麼? for example:
				//B 		<= { { 16{IR[15]} } , IR[15:0] };
			    //RD 	<=IR[20:16];
			    //MemtoReg<= 1'b1;
			    //RegWrite<= 1'b1;
			    //MemRead <= 1'b1;
			    //MemWrite<= 1'b0;
			    //branch  <= 1'b0;
			    //ALUctr  <= 3'd0;
			    
		 	end
		6'd43:  begin// sw  //其實做法都很雷同，確認好指令格式及訊號線即可
				
			    
		 	end
		6'd4:   begin // beq
				
			end
		6'd5:   begin // bne
			    
			end
		6'd2: begin  // j
			  
			end

			default: begin
				//$display("ERROR instruction!!");
			end
		endcase
   end
end

endmodule