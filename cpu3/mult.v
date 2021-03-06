`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:07 07/20/2016 
// Design Name: 
// Module Name:    mult 
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
module mult(a,b,z,busy);
	input [31:0]a,b;
	output busy;
	output [63:0]z;
	reg [31:0]a_bi[31:0];
	assign busy=1'b0;
	integer i,j;
	always@(*)
	begin
		for(i=0;i<31;i=i+1)
			for(j=0;j<31;j=j+1)
				a_bi[i][j]=a[i]&b[j];
		for(i=0;i<31;i=i+1)
			a_bi[i][31]=~(a[i]&b[31]);
		for(j=0;j<31;j=j+1)
			a_bi[31][j]=~(a[31]&b[j]);
		a_bi[31][31]=a[31]&b[31];
	end
	assign z = (((({32'b1,a_bi[0][31],a_bi[0][30:0]}+
					 {31'b0,a_bi[1][31],a_bi[1][30:0],1'b0})+
					({30'b0,a_bi[2][31],a_bi[2][30:0],2'b0}+
					 {29'b0,a_bi[3][31],a_bi[3][30:0],3'b0}))+
				  (({28'b0,a_bi[4][31],a_bi[4][30:0],4'b0}+
					 {27'b0,a_bi[5][31],a_bi[5][30:0],5'b0})+
					({26'b0,a_bi[6][31],a_bi[6][30:0],6'b0}+
					 {25'b0,a_bi[7][31],a_bi[7][30:0],7'b0})))+
				  ((({24'b0,a_bi[8][31],a_bi[8][30:0],8'b0}+
					 {23'b0,a_bi[9][31],a_bi[9][30:0],9'b0})+
					({22'b0,a_bi[10][31],a_bi[10][30:0],10'b0}+
					 {21'b0,a_bi[11][31],a_bi[11][30:0],11'b0}))+
				  (({20'b0,a_bi[12][31],a_bi[12][30:0],12'b0}+
					 {19'b0,a_bi[13][31],a_bi[13][30:0],13'b0})+
					({18'b0,a_bi[14][31],a_bi[14][30:0],14'b0}+
					 {17'b0,a_bi[15][31],a_bi[15][30:0],15'b0}))))+
				  (((({16'b0,a_bi[16][31],a_bi[16][30:0],16'b0}+
					 {15'b0,a_bi[17][31],a_bi[17][30:0],17'b0})+
					({14'b0,a_bi[18][31],a_bi[18][30:0],18'b0}+
					 {13'b0,a_bi[19][31],a_bi[19][30:0],19'b0}))+
				  (({12'b0,a_bi[20][31],a_bi[20][30:0],20'b0}+
					 {11'b0,a_bi[21][31],a_bi[21][30:0],21'b0})+
					({10'b0,a_bi[22][31],a_bi[22][30:0],22'b0}+
					 {9'b0,a_bi[23][31],a_bi[23][30:0],23'b0})))+
				  ((({8'b0,a_bi[24][31],a_bi[24][30:0],24'b0}+
					 {7'b0,a_bi[25][31],a_bi[25][30:0],25'b0})+
					({6'b0,a_bi[26][31],a_bi[26][30:0],26'b0}+
					 {5'b0,a_bi[27][31],a_bi[27][30:0],27'b0}))+
				  (({4'b0,a_bi[28][31],a_bi[28][30:0],28'b0}+
					 {3'b0,a_bi[29][31],a_bi[29][30:0],29'b0})+
					({2'b0,a_bi[30][31],a_bi[30][30:0],30'b0}+
					 {1'b1,a_bi[31][31],a_bi[31][30:0],31'b0}))));
endmodule

