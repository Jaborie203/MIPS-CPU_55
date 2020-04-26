`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:51:32 07/19/2016 
// Design Name: 
// Module Name:    hilo_reg 
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
module hilo_reg(clk,rst,ena,hi_i,lo_i,hi_o,lo_o);
	input clk;
	input rst;
	input ena;
	input [31:0]hi_i,lo_i;
	output reg[31:0]hi_o,lo_o;
	always@(posedge rst or posedge clk)
	begin
		if(rst) 
		begin
			hi_o <= 0;
			lo_o <= 0;
		end
	   else if(ena)
		begin
			hi_o <= hi_i;
			lo_o <= lo_i;
		end
	end
endmodule

