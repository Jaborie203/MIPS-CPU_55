`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:03:29 05/06/2016 
// Design Name: 
// Module Name:    mux4c1 
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
module mux4c1(
    input [1:0]choose,
    input [31:0]a,
	 input [31:0]b,
	 input [31:0]c,
	 input [31:0]d,
	 output reg[31:0]pc_mux
    );
    always @ (*) begin
		case (choose)
				2'b00: pc_mux=a;
				2'b01: pc_mux=b;
				2'b10: pc_mux=c;
				2'b11: pc_mux=d;
		endcase
	end 
endmodule
