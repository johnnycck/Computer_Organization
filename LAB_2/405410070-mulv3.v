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
		/*	正負號判斷	*/
		sign <= in_a[15] ^ in_b[15];
	end

	//輸入結果與被乘數
	else if (Counter == 6'd0) begin
		/* 判斷被乘數是否為負數 */
		if(in_a[15]==1)
			Mplicand <= ~in_a + 1'b1;
		else
			Mplicand <= in_a;
		
		/* 判斷乘數是否為負數 */
		if(in_b[15]==1)
			Product <= {16'b0, (~in_b + 1'b1)};
		else
			Product <= {16'b0, in_b};
	end
	
	//乘法與數值移位
	else if (Counter <= 6'd16)begin
		/* 避免overflow 先shift再相加 */
		if (Product[0] == 1'b1)begin
			Product = Product >> 1'b1;
			Product = {Mplicand[15:0] + Product[30:15], Product[14:0]};
		end
		else	
			Product = Product >> 1'b1;

		/* 全部加完再判斷結果為正或負 */
		if(Counter == 6'd16)
			if (sign == 1'b1 && Product[31]== 1'b0)
				Product = ~Product + 1'b1;
	end
	
	//給定結果正負號
	/*else if (Counter == 6'd16)begin
		//$display("Product:%d",Product);
		if (Product[0] == 1'b1)begin
			Product = Product >> 1'b1;
			Product = {Mplicand[15:0] + Product[30:15], Product[14:0]};
		end
		else
			Product = Product >> 1'b1;
		if (sign == 1'b1 && Product[31]==0)
			Product = ~Product + 1'b1;
			//write your code here
	end*/
	
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
