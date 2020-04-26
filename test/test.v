`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:24 07/20/2016 
// Design Name: 
// Module Name:    test 
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
module test(a,b,c);
	input [8:0]a,b;
	output reg[8:0]c;
	reg k;
	always@(*)
	begin
		if(k)
			c=a+b;
		else
			c=a-b;
	end
endmodule
