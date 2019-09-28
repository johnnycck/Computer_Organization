//以前者(1ns)為單位，以後者(1ps)的時間，查看一次電路的行為
`timescale 1ns/1ps

//宣告module名稱,輸出入名稱
module lab(
	CLK, 
	RST, 
	in_a, 
	in_b, 
	Product, 
	Product_Valid
);
// in_a * in_b = Product
// in_a is Multiplicand , in_b is Multiplier
					
//定義port, 包含input, output
input 			CLK, RST;
input 	[15:0]	in_a;			// Multiplicand
input 	[15:0]	in_b;			// Multiplier
output 	[31:0]  Product;
output  		Product_Valid;

reg 	[31:0]	Mplicand;		//被乘數
reg 	[31:0]	Product;
reg 			Product_Valid;
reg 	[5:0]	Counter ;
reg				sign;	//isSigned

//Counter
always @(posedge CLK or posedge RST)
begin
	if (RST)
		Counter <= 6'b0;
	else
		Counter <= Counter + 6'b1;
end

//Product
always @(posedge CLK or posedge RST)
begin
	//初始化數值
	if (RST) begin
		Product  <= 31'b0;
		Mplicand <= 16'b0;
		sign = in_a[15] ^ in_b[15];	//判斷正負號
	end

	//輸入結果與被乘數
	else if (Counter == 6'd0) begin
		if( in_b[15] == 1)
			Product	 	<= {16'b0,(~in_b + 1'b1)};		//若Multiplier為負數，先把Product取二補數
		else
			Product	 	<= {16'b0,in_b};
			
		if( in_a[15] == 1)
			Mplicand <= ~in_a + 1'b1;
		else
			Mplicand <= in_a;
		
		/*
			Product	 	<= {16'b0, in_b}; 
			一開始的Product要先把乘數(Multiplier)放在前16bit
			結果與被乘數皆為正數
			被乘數為負數(in_a)
			結果為負數(in_b)
			結果與被乘數皆為負數
		*/
	end
	
	//乘法與數值移位
	else if (Counter <= 6'd16)begin								//包含最後一次
		if (Product[0] == 1'b1) begin
			Product = Product >> 1'b1;
			Product = {Mplicand[15:0]+Product[30:15],Product[14:0]};		//加upper 16 bit，因先右位移1bit，故取30:15
		end
		else 
			Product = Product >> 1'b1;
	
	
	//給定結果正負號
	//當計算到最後一次的時候，判斷結果應是正數或負數
		if (Counter == 6'd16)begin
			if (sign == 1'b1 && Product[31]== 1'b0)
				Product <= ~Product + 1'b1;
		end
	end
	
	else begin
		Product 	<= Product;
		Mplicand	<= Mplicand;
	end
end

//Product_Valid
always @(posedge CLK or posedge RST)
begin
	if (RST)
		Product_Valid <=1'b0;
	else if (Counter==6'd17)
		Product_Valid <=1'b1;
	else
		Product_Valid <=1'b0;
end

endmodule
