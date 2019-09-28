`timescale 1ns/1ps

`include "INSTRUCTION_FETCH.v"
`include "INSTRUCTION_DECODE.v"
`include "EXECUTION.v"
`include "MEMORY.v"

module CPU(
	clk,
	rst
);
input clk, rst;
/*============================== Wire  ==============================*/
wire [7:0] GCD_OUTPUT;
//wire LI0,LI1,LI2,LI3,LI4,LI5,LI6,LI7,MI0,MI1,MI2,MI3,MI4,MI5,MI6,MI7,RI0,RI1,RI2,RI3,RI4,RI5,RI6,RI7;

// INSTRUCTION_FETCH wires
wire [31:0] FD_PC;
wire [31:0] FD_IR;

// INSTRUCTION_DECODE wires
wire DX_MemtoReg, DX_RegWrite, DX_MemRead, DX_MemWrite, DX_jump, DX_branch;
wire [31:0] DX_JT, DX_PC, DX_NPC, A, B;
wire [15:0] imm;
wire [4:0] DX_RD;
wire [31:0] DX_MD;
wire [2:0] ALUctr;

// EXECUTION wires
wire XM_MemtoReg, XM_RegWrite, XM_MemRead, XM_MemWrite, XM_branch;
wire [31:0] XM_ALUout;
wire [31:0] XM_BT;
wire [4:0] XM_RD;
wire [31:0] XM_MD;

// DATA_MEMORY wires
wire MW_MemtoReg, MW_RegWrite;
wire [31:0] 	MDR, MW_ALUout;
wire [5-1:0]	MW_RD;
/*============================== INSTRUCTION_FETCH ==============================*/
INSTRUCTION_FETCH IF(
	.clk(clk),
	.rst(rst),
	.jump(DX_jump),
	.branch(XM_branch),
	.jump_addr(DX_JT),
	.branch_addr(XM_BT),

	.PC(FD_PC),
	.IR(FD_IR)
);

/*============================== INSTRUCTION_DECODE ==============================*/

INSTRUCTION_DECODE ID(
	.clk(clk),
	.rst(rst),
	.PC(FD_PC),
	.IR(FD_IR),
	.MW_MemtoReg(MW_MemtoReg),
	.MW_RegWrite(MW_RegWrite),
	.MW_RD(MW_RD),
	.MDR(MDR),
	.MW_ALUout(MW_ALUout),

	.MemtoReg(DX_MemtoReg),
	.RegWrite(DX_RegWrite),
	.MemRead(DX_MemRead),
	.MemWrite(DX_MemWrite),
	.branch(DX_branch),
	.jump(DX_jump),
	.ALUctr(ALUctr),
	.JT(DX_JT),
	.DX_PC(DX_PC),
	.NPC(DX_NPC),
	.A(A),
	.B(B),
	.imm(imm),
	.RD(DX_RD),
	.MD(DX_MD)	
);

/*==============================     EXECUTION  	==============================*/

EXECUTION EXE(
	.clk(clk),
	.rst(rst),
	.DX_MemtoReg(DX_MemtoReg),
	.DX_RegWrite(DX_RegWrite),
	.DX_MemRead(DX_MemRead),
	.DX_MemWrite(DX_MemWrite),
	.DX_branch(DX_branch),
	.ALUctr(ALUctr),
	.NPC(DX_NPC),
	.A(A),
	.B(B),
	.imm(imm),
	.DX_RD(DX_RD),
	.DX_MD(DX_MD),

	.XM_MemtoReg(XM_MemtoReg),
	.XM_RegWrite(XM_RegWrite),
	.XM_MemRead(XM_MemRead),
	.XM_MemWrite(XM_MemWrite),
	.XM_branch(XM_branch),
	.ALUout(XM_ALUout),
	.XM_RD(XM_RD),
	.XM_MD(XM_MD),
	.XM_BT(XM_BT)
);

/*==============================     DATA_MEMORY	==============================*/

MEMORY MEM(
	.clk(clk),
	.rst(rst),
	.XM_MemtoReg(XM_MemtoReg),
	.XM_RegWrite(XM_RegWrite),
	.XM_MemRead(XM_MemRead),
	.XM_MemWrite(XM_MemWrite),
	.ALUout(XM_ALUout),
	.XM_RD(XM_RD),
	.XM_MD(XM_MD),

	.MW_MemtoReg(MW_MemtoReg),
	.MW_RegWrite(MW_RegWrite),
	.MW_ALUout(MW_ALUout),
	.MDR(MDR),
	.MW_RD(MW_RD)
);



endmodule
