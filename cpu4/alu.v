`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:06:18 04/18/2016 
// Design Name: 
// Module Name:    alu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu(
      input [31:0] a, // 32 位输入，操作数1
      input [31:0] b, // 32 位输入，操作数2
      input [3:0] aluc, // 4 位输入，控制alu 的操作
      output[31:0] r, // 32 位输出，有a b 经过aluc 指定的操作生成
      output zero, // 0 标志位
      output carry, // 进位标志位
      output negative, // 负数标志位
      output overflow // 溢出标志位
      );
      reg [31:0] r_temp;
      reg carry_temp,overflow_temp;
      assign r = r_temp;
      assign zero = r_temp? 1'b0:1'b1;
      assign negative = aluc == 4'b0000 || aluc == 4'b0001 ? 1'b0 : r_temp[31];
      assign carry = carry_temp;
      assign overflow = overflow_temp;
always@(aluc or a or b)
begin
     case(aluc)
	  4'b0000://无符号a+b
	  begin
	  r_temp = a + b;
	  carry_temp = (a[31] && b[31])||((a[31] || b[31])&&~r_temp[31])? 1'b1:1'b0; //当a、b的最高位为1时，和溢出；当a和b的最高位有一个为1时，当r的最高位为0时溢出
	  overflow_temp = 1'b0;
	  end
	  4'b0010://有符号a+b
	  begin
	  r_temp = a + b;
	  carry_temp = 1'b0;
	  overflow_temp = ~(a[31]^b[31])&&(b[31]^r_temp[31])? 1'b1:1'b0;
	  end
	  4'b0001://无符号a-b
	  begin
	  r_temp = a - b;
	  carry_temp = (~a[31]||b[31])&&r_temp[31]? 1'b1:1'b0;
	  overflow_temp = 1'b0;
	  end
	  4'b0011://有符号a-b
	  begin
	  r_temp = a - b;
	  carry_temp = 1'b0;
	  overflow_temp = (a[31] ^ b[31]) && (a[31] ^ r_temp[31]) ? 1'b1 : 1'b0;
	  end
	  4'b0100://r=a & b
	  begin
	  r_temp = a & b;
	  carry_temp = 1'b0;
	  overflow_temp = 1'b0;
	  end
	  4'b0101://a | b
	  begin
	  r_temp = a | b;
	  carry_temp = 1'b0;
	  overflow_temp = 1'b0;
	  end
	  4'b0110://a ^ b
	  begin
	  r_temp = a ^ b;
	  carry_temp = 1'b0;
	  overflow_temp = 1'b0;
	  end
	  4'b0111://~(a | b)
	  begin
	  r_temp = ~(a | b);
	  carry_temp = 1'b0;
	  overflow_temp = 1'b0;
	  end
	  4'b1001,
	  4'b1000://r = {b[15:0],16'b0}
	  begin
	  r_temp = {b[15:0],16'b0};
	  carry_temp = 1'b0;
	  overflow_temp = 1'b0;
	  end
     4'b1011://($signed(a) < $signed(b))? 1:0
	  begin
	  r_temp = ($signed(a) < $signed(b))? 1:0;
	  carry_temp = 1'b0;
	  overflow_temp = 1'b0;
	  end 
	  4'b1010://(a < b)? 1:0
	  begin
	  r_temp = (a < b)? 1:0;
	  carry_temp = r_temp==1? 1'b1:1'b0;
	  overflow_temp = 1'b0;
	  end 
	  4'b1100://r=b>>>a
	  begin
	  r_temp = a & 32'h0000001f;
	  carry_temp = r_temp ? b[r_temp - 1] : 1'b0;
	  r_temp = $signed(b) >>> r_temp;
	  overflow_temp = 1'b0;
	  end 
	  4'b1110,
	  4'b1111://r=b<<a
	  begin
	  r_temp = a & 32'h0000001f;
	  carry_temp = r_temp ? b[32 - r_temp] : 1'b0;
	  r_temp = b << r_temp;
	  overflow_temp = 1'b0;
	  end 
	  4'b1101://r=b>>a
	  begin
	  r_temp = a & 32'h0000001f;
	  carry_temp = r_temp ? b[r_temp - 1] : 1'b0;
	  r_temp = b >> r_temp;
	  overflow_temp = 1'b0;//只有有符号加减法影响此标志位
	  end
	endcase
 end
endmodule 