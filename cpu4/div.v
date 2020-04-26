`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:24 07/20/2016 
// Design Name: 
// Module Name:    div 
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
/*module div(a,b,start,clock,resetn,q,r,busy,ready);
	input [31:0]a,b;
	input start,clock,resetn;
	output busy,ready;
	output [31:0]q,r;
	reg [63:0]temp_a;
	reg [63:0]reg_q;
	reg [31:0]reg_r;
	reg [31:0]reg_b;
	reg [4:0]count;
	reg busy,busy2,r_sign,sign;
	wire [63:0]temp_q;
	wire op_add;
	wire [32:0] sub_add;
	always@(posedge clock or posedge resetn)
	begin
		if(resetn)
		begin
			count<=5'b0;
			busy<=0;
			busy2<=0;
		end
		else 
		begin
			busy2<=busy;
			if(start)
			begin
				reg_r<=32'b0;
				temp_a={{32{a[31]}},a};
				r_sign<=temp_a[63];
				sign<=temp_a[63]^b[31];
				reg_q<=temp_a;
				reg_b<=b;
				count<=5'b0;
				busy<=1'b1;
			end
			else if(busy)
			begin
				reg_r <= sub_add[31:0];
				r_sign <= sub_add[32];
				reg_q[63:1] <= reg_q[62:0];
				reg_q[0]<=~sub_add[32];
				count <= count+5'b1;
				if(count==5'b11110) busy<=0;
			end
		end
	end
	assign reasy=~busy&busy2;
	assign op_add=r_sign^reg_b[31];
	assign sub_add=op_add?{reg_r,reg_q[63]}+{reg_b[31],reg_b}:{reg_r,reg_q[63]}-{reg_b[31],reg_b};
	wire [31:0]abs_b=reg_b[31]? ~reg_b+32'b1:reg_b;
	assign r=r_sign?reg_r+abs_b:reg_r;
	assign temp_q=sign?~reg_q+1:reg_q;
	assign q=temp_q[31:0];
endmodule*/
module div(a,b,start,clock,resetn,q,r,busy);
	input [31:0]a,b;
	input start,clock,resetn;
	output busy;
	output [31:0]q,r;
	
	wire temp_busy;
	wire [31:0]temp_a,temp_b,temp_q,temp_r;
	
	assign temp_a=a[31]? ~a+1:a;
	assign temp_b=b[31]? ~b+1:b;
	
	divu d(temp_a,temp_b,start,clock,resetn,temp_q,temp_r,temp_busy);
	
	assign q=(a[31]^b[31])? ~temp_q+1:temp_q;//32'h000000ff:32'h0000000f;
	assign r=a[31]? ~temp_r+1:temp_r;
	assign busy=temp_busy;
endmodule 