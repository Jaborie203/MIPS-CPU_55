`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:18:52 07/19/2016 
// Design Name: 
// Module Name:    lbh 
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
module lbh(lbh_c,sext,choose,data_in,data_out);
	input [1:0]lbh_c;
	input sext;
	input [1:0]choose;
	input [31:0]data_in;
	output reg[31:0]data_out;
	reg [31:0]data_temp1,data_temp2,data_temp3,data_temp4,data_temp5,data_temp6,data_temp7;
	ext #(8) ext_lbh(data_in[31:24],sext,data_temp1);
	ext #(8) ext_lbh(data_in[23:16],sext,data_temp2);
	ext #(8) ext_lbh(data_in[15:8],sext,data_temp3);
	ext #(8) ext_lbh(data_in[7:0],sext,data_temp4);
	ext #(16) ext_lbh(data_in[31:16],sext,data_temp5);
	ext #(16) ext_lbh(data_in[15:0],sext,data_temp6);
	always@(*)
	begin
		if(lbh_c==0)
		begin
			data_out=data_in;
		end
		else if(lbh_c==1)
		begin
			if(choose==0) data_out=data_temp1;
			if(choose==1) data_out=data_temp2;
			if(choose==2) data_out=data_temp3;
			if(choose==3) data_out=data_temp4;		
		end
		else if(lbh_c==2)
		begin
			if(choose==0) data_out=data_temp5;
			if(choose==3) data_out=data_temp6;
		end
		else
		begin
			data_out=data_in;
		end
	end
endmodule
