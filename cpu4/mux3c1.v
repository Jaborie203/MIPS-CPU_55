`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:13:42 06/08/2016 
// Design Name: 
// Module Name:    mux3c1 
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
module mux3c1 #(parameter WIDTH = 32)(a,b,c,s,r);
    input wire[WIDTH-1:0] a;
    input wire[WIDTH-1:0] b;
	 input wire[WIDTH-1:0] c;
    input wire[1:0]s;
    output reg[WIDTH-1:0] r;
    always@(*)
	 begin
		case(s)
		2'b00:r<=a;
		2'b01:r<=b;
		2'b10:r<=c;
		endcase
	 end
endmodule
