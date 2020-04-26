`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:05:27 07/20/2016 
// Design Name: 
// Module Name:    divu 
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
module divu(a,b,start,clock,resetn,q,r,busy);
	input [31:0]a,b;
	input start,clock,resetn;
	output busy;
	output [31:0]q,r;
	reg [31:0]reg_q;
	reg [31:0]reg_r;
	reg [31:0]reg_b;
	reg [4:0]count;
	reg busy,r_sign;
	wire [32:0] sub_add=r_sign?{reg_r,q[31]}+{1'b0,reg_b}:{reg_r,q[31]}-{1'b0,reg_b};
	always@(posedge clock or posedge resetn)
	begin
		if(resetn)
		begin
			count<=5'b0;
			busy<=0;
		end
		else 
		begin
			if(start)
			begin
				reg_r<=32'b0;
				r_sign<=0;
				reg_q<=a;
				reg_b<=b;
				count<=5'b0;
				busy<=1'b1;
			end
			else if(busy)
			begin
				reg_r <= sub_add[31:0];
				r_sign <= sub_add[32];
				reg_q <= {reg_q[30:0],~sub_add[32]};
				count <= count+5'b1;
				if(count==5'b11111) busy<=0;
			end
		end
	end
	assign r=r_sign?reg_r+reg_b:reg_r;
	assign q=reg_q;
endmodule

