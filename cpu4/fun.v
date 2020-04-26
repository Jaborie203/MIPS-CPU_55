`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:31 07/20/2016 
// Design Name: 
// Module Name:    fun 
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
module fun(clk,func,start,resetn,a,b,hi,lo,busy);
	input clk,start,resetn;
	input [1:0]func;
	input [31:0]a,b;
	output [31:0]hi,lo;
	output reg busy;
	
	reg [31:0]hi_temp,lo_temp;
	
	wire [63:0]result_m1,result_m2;
	wire [31:0]q_d1,r_d1,q_d2,r_d2;
	wire busy_m1,busy_m2,busy_d1,busy_d2;
	
	assign hi=hi_temp;
	assign lo=lo_temp;
	
	/*multu m1(a, b,start,clk,resetn,result_m1, busy_m1);
	mult m2(a, b, result_m2,busy_m2);
	divu d1(a,b,start,clk,resetn,q_d1,r_d1,busy_d1);
	div d2(a,b,start,clk,resetn,q_d2,r_d2,busy_d2);*/
	
	always@(*)
	begin
		
		case(func)
		2'b00:
		begin
			busy<=busy_m1;
			hi_temp<=result_m1[63:32];
			lo_temp<=result_m1[31:0];
		end
		2'b01:
		begin
			busy<=busy_m2;
			hi_temp<=result_m2[63:32];
			lo_temp<=result_m2[31:0];
		end
		2'b10:
		begin
			busy<=busy_d1;
			hi_temp<=r_d1;
			lo_temp<=q_d1;
		end
		2'b11:
		begin
			busy<=busy_d2;
			hi_temp<=r_d2;
			lo_temp<=q_d2;
		end
		endcase
	end
endmodule
