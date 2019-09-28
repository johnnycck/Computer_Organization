
module MEMORY(
	clk,
	rst,
	XM_MemtoReg,
	XM_RegWrite,
	XM_MemRead,
	XM_MemWrite,
	ALUout,
	XM_RD,
	XM_MD,
	//sw0,
    //sw1,
    //sw2,
    //sw3,
    //sw4,
    //sw5,
    //sw6,
    //sw7,
    //sw8,
	//sw9,
    //sw10,
    //sw11,
	//sw12,
	
	MW_MemtoReg,
	MW_RegWrite,
	MW_ALUout,
	MDR,
	MW_RD
);
input clk, rst, XM_MemtoReg, XM_RegWrite, XM_MemRead, XM_MemWrite;
//input sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8,sw9,sw10,sw11,sw12;
input [31:0] ALUout;
input [4:0] XM_RD;
input [31:0] XM_MD;


output reg MW_MemtoReg, MW_RegWrite;
output reg [31:0]	MW_ALUout, MDR;
output reg [4:0]	MW_RD;

//data memory
reg [31:0] DM [0:127];
reg [31:0] i;
always @(posedge clk)
	if(XM_MemWrite)
		DM[ALUout[6:0]] <= XM_MD;

always @(posedge clk or posedge rst)
	if (rst) begin
		MW_MemtoReg 		<= 1'b0;
		MW_RegWrite 		<= 1'b0;
		MDR					<= 32'b0;
		MW_ALUout			<= 32'b0;
		MW_RD				<= 5'b0;
		//for (i=1; i<128; i=i+1) DM[i] <= 32'b0;
	end
	else begin
		MW_MemtoReg 		<= XM_MemtoReg;
		MW_RegWrite 		<= XM_RegWrite;
		MDR					<= (XM_MemRead)?DM[ALUout[6:0]]:MDR;
		MW_ALUout			<= ALUout;
		MW_RD 				<= XM_RD;
	end

endmodule
