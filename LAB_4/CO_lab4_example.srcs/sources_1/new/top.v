`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/18 13:20:44
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top(
    input clk, 
    input sw0,
    input sw1,
    input sw2,
    input sw3,
    input sw4,
    input sw5,
    input sw6,
    input sw7,
    input sw8,
	input sw9,
    input sw10,
    input sw11,

    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g,
    output dp,
    output d0,
    output d1,
    output d2,
    output d3,
    output d4,
    output d5,
    output d6,
    output d7 
    );
reg [5:0] first_number,second_number;
reg [17:0] counter;
reg [2:0] state;
reg [6:0] seg_number,seg_data;
reg [11:0] answer_number;
reg [7:0] scan;


//wtite down your code here
always@(posedge clk)begin
	second_number <= {sw5,sw4,sw3,sw2,sw1,sw0};
	first_number <= {sw11,sw10,sw9,sw8,sw7,sw6};
	answer_number <= first_number*second_number;
end

//8顆(d0~d7)7-segment(a~g)顯示 dp為右下角的.
assign {d7,d6,d5,d4,d3,d2,d1,d0} = scan;
assign dp = ((state==1) || (state==3)) ? 0 : 1;  //1,3 light_on
always@(posedge clk) begin
  counter <=(counter<=100000) ? (counter +1) : 0;
  state <= (counter==100000) ? (state + 1) : state;
   case(state)
	0:begin
	  seg_number <= first_number/10;//6個switch值最多為63,63/10=6,顯示在左邊
	  scan <= 8'b0111_1111;
	end
	1:begin
	  seg_number <= first_number%10;//63%10=3,顯示在右邊
	  scan <= 8'b1011_1111;
	end
	2:begin
	  seg_number <= second_number/10;
	  scan <= 8'b1101_1111;
	end
	3:begin
	  seg_number <= second_number%10;
	  scan <= 8'b1110_1111;
	end
	4:begin
	  seg_number <= answer_number/1000;//63*63=3969,3969/1000=3
	  scan <= 8'b1111_0111;
	end
	5:begin
	  seg_number <= (answer_number%1000)/100;//3969%1000=969,969/1000=9
	  scan <= 8'b1111_1011;
	end
	6:begin
	  seg_number <= (answer_number%100)/10;
	  scan <= 8'b1111_1101;
	end
	7:begin
	  seg_number <= answer_number%10;
	  scan <= 8'b1111_1110;
	end
	default: state <= state;
  endcase 
end  

//7-segment 輸出數字解碼
assign {g,f,e,d,c,b,a} = seg_data;
always@(posedge clk) begin  
  case(seg_number)
	16'd0:seg_data <= 7'b100_0000;
	16'd1:seg_data <= 7'b111_1001;
	16'd2:seg_data <= 7'b010_0100;
	16'd3:seg_data <= 7'b011_0000;
	16'd4:seg_data <= 7'b001_1001;
	16'd5:seg_data <= 7'b001_0010;
	16'd6:seg_data <= 7'b000_0010;
	16'd7:seg_data <= 7'b101_1000;
	16'd8:seg_data <= 7'b000_0000;
	16'd9:seg_data <= 7'b001_0000;
	default: seg_number <= seg_number;
  endcase
end 
endmodule
