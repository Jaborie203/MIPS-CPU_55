`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:35:20 05/06/2016 
// Design Name: 
// Module Name:    mux32_1 
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
module mux32_1(
    input wire [31:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,
    input wire [4:0] s,
    output reg[31:0] r
    );
always@(*)
begin
    case(s)
	 5'b00000:r=a0;
	 5'b00001:r=a1;
	 5'b00010:r=a2;
	 5'b00011:r=a3;
	 5'b00100:r=a4;
	 5'b00101:r=a5;
	 5'b00110:r=a6;
	 5'b00111:r=a7;
	 5'b01000:r=a8;
	 5'b01001:r=a9;
	 5'b01010:r=a10;
	 5'b01011:r=a11;
	 5'b01100:r=a12;
	 5'b01101:r=a13;
	 5'b01110:r=a14;
	 5'b01111:r=a15;
	 5'b10000:r=a16;
	 5'b10001:r=a17;
	 5'b10010:r=a18;
	 5'b10011:r=a19;
	 5'b10100:r=a20;
	 5'b10101:r=a21;
	 5'b10110:r=a22;
	 5'b10111:r=a23;
	 5'b11000:r=a24;
	 5'b11001:r=a25;
	 5'b11010:r=a26;
	 5'b11011:r=a27;
	 5'b11100:r=a28;
	 5'b11101:r=a29;
	 5'b11110:r=a30;
	 5'b11111:r=a31;
	 endcase
	end
endmodule
