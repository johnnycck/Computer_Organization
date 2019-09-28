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
reg 	[15:0]	Mplier;			//乘數
reg 	[31:0]	Product;
reg 			Product_Valid;
reg 	[5:0]	Counter ;
reg				sign;			//正負號判斷 (signed)

//Counter
always @(posedge CLK or posedge RST)
begin
	if(RST)
		Counter <= 6'b0;
	else
		Counter <= Counter + 6'b1;

end

//Product
always @(posedge CLK or posedge RST)
begin
	//初始化數值
	if(RST) begin
		Product  <= 31'b0;
		Mplicand <= 31'b0;
		Mplier   <= 16'b0;
		/*
			正負號判斷
			write your code here
		*/
		
	end 
	//輸入乘數與被乘數
	else if(Counter == 6'd0) begin
		Product	 	<= 31'b0;
		//乘數與被乘數皆為正數
		Mplicand 	<= {16'b0,in_a};
		Mplier	 	<= in_b;
		/*
			被乘數為負數(in_a)
			乘數為負數(in_b)
			乘數與被乘數皆為負數
			write your code here
		*/
	end 
	//乘法與數值移位
	else if(Counter <=6'd16) 
	begin
		if(Mplier[0] == 1'b1)
		Product 	<= Mplicand + Product;
		//利用sign來判斷結果(Product)是否需要二補數轉換
		//write your code here
		Mplicand 	<= Mplicand << 1'b1;
		Mplier 		<= Mplier >> 1'b1;
	end 
	else begin
		Product 	<= Product;
		Mplicand	<= Mplicand;
		Mplier 		<= Mplier;
	end
end

//Product_Valid
always @(posedge CLK or posedge RST)
begin
	if(RST)
		Product_Valid <=1'b0;
	else if(Counter==6'd17)
		Product_Valid <=1'b1;
	else
		Product_Valid <=1'b0;
end

endmodule
