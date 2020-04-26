`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:15:12 07/22/2016 
// Design Name: 
// Module Name:    mux5c1 
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
module mux5c1(
    input [31:0]a,
	 input [31:0]b,
	 input [31:0]c,
	 input [31:0]d,
	 input [31:0]e,
	 input [2:0]choose,
	 output reg[31:0]pc_mux
    );
    always @ (*) begin
		case (choose)
				3'b000: pc_mux=a;
				3'b001: pc_mux=b;
				3'b010: pc_mux=c;
				3'b011: pc_mux=d;
				3'b100: pc_mux=e;
				default: ;
		endcase
	end 
endmodule
