`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:36:07 07/20/2016 
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
/////////////////////////////////////////////////////////////////////////////////
/*module DIVU(
    input [31:0] dividend,
    input [31:0] divisor,
    input start,
    input clock,
    input reset,
    output [31:0] q,
    output [31:0] r,
    output reg busy
    );
	reg [31:00] reg_q;
	reg [31:00] reg_r;
	reg [31:00] reg_b;
	reg [4:0] count;
	reg sign, r_sign;
	wire [32:00] sub_add = r_sign? {reg_r, q[31]} + {1'b0, reg_b} : {reg_r, q[31]} - {1'b0, reg_b};
	
	always @ (posedge clock or negedge reset) begin
		if (reset == 0) begin
			count <= 5'b0;
			busy <= 0;			
		end else begin			
			if (start) begin
				reg_r <= 32'h0;
				r_sign <= 0;
				sign <= dividend[31]^ divisor[31];
				reg_q <= dividend;
				reg_b <= divisor;
				count <= 5'b0;
				busy <= 1'b1;
				
			end else if (busy!=1'b0) begin
				reg_r <= sub_add[31:00];
				r_sign <= sub_add[32];
				reg_q<={reg_q[30:00],~sub_add[32]};
				count <= count + 5'b1;
				if (count == 5'h1f) busy <= 0;
			end
			
		end
	
	end
	assign r = r_sign? reg_r +reg_b : reg_r ;
	assign q = reg_q;	
endmodule*/
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
	always@(posedge clock or negedge resetn)
	begin
		if(resetn==0)
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

