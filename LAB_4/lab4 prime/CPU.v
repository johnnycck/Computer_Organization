
module CPU(
	clk,
	rst,
	li0,
	li1,
	li2,
	li3,
	li4,
	li5,
	li6,
	li7,
	li8,
	li9,
	li10,
	li11,
	li12,
	
	a,
	b,
	c,
	d,
	e,
	f,
	g,
	d0,
	d1,
	d2,
	d3,
	d4,
	d5,
	d6,
	d7
);
input clk, rst;
input li0,li1,li2,li3,li4,li5,li6,li7,li8,li9,li10,li11,li12;
output a,b,c,d,e,f,g;
output d0,d1,d2,d3,d4,d5,d6,d7;
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
wire [31:0] result1, result2;
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
    .sw0(li0),
    .sw1(li1),
    .sw2(li2),
    .sw3(li3),
    .sw4(li4),
    .sw5(li5),
    .sw6(li6),
    .sw7(li7),
    .sw8(li8),
    .sw9(li9),
    .sw10(li10),
    .sw11(li11),
    .sw12(li12),

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

/*=============================    LED segment    =================================*/

top TOP(
	.clk(clk),
	.rst(rst),
	.result1(ID.REG[14]),
	.result2(ID.REG[15]),
	
	.a1(a),
	.b1(b),
	.c1(c),
	.d1(d),
	.e1(e),
	.f1(f),
	.g1(g),
	.d01(d0),
	.d11(d1),
	.d21(d2),
	.d31(d3),
	.d41(d4),
	.d51(d5),
	.d61(d6),
	.d71(d7)
);

endmodule
