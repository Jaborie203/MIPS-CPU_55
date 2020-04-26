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
      input [31:0] a, // 32 λ���룬������1
      input [31:0] b, // 32 λ���룬������2
      input [3:0] aluc, // 4 λ���룬����alu �Ĳ���
      output[31:0] r, // 32 λ�������a b ����aluc ָ���Ĳ�������
      output zero, // 0 ��־λ
      output carry, // ��λ��־λ
      output negative, // ������־λ
      output overflow // �����־λ
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
	  4'b0000://�޷���a+b
	  begin
	  r_temp = a + b;
	  carry_temp = (a[31] && b[31])||((a[31] || b[31])&&~r_temp[31])? 1'b1:1'b0; //��a��b�����λΪ1ʱ�����������a��b�����λ��һ��Ϊ1ʱ����r�����λΪ0ʱ���
	  overflow_temp = 1'b0;
	  end
	  4'b0010://�з���a+b
	  begin
	  r_temp = a + b;
	  carry_temp = 1'b0;
	  overflow_temp = ~(a[31]^b[31])&&(b[31]^r_temp[31])? 1'b1:1'b0;
	  end
	  4'b0001://�޷���a-b
	  begin
	  r_temp = a - b;
	  carry_temp = (~a[31]||b[31])&&r_temp[31]? 1'b1:1'b0;
	  overflow_temp = 1'b0;
	  end
	  4'b0011://�з���a-b
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
	  overflow_temp = 1'b0;//ֻ���з��żӼ���Ӱ��˱�־λ
	  end
	endcase
 end
endmodule 