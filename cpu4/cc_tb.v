`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:05:55 07/21/2016
// Design Name:   fun
// Module Name:   G:/projects/CPU_55/cpu4/cc_tb.v
// Project Name:  cpu1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fun
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cc_tb;

	// Inputs
	reg clk;
	reg [1:0] func;
	reg start;
	reg resetn;
	reg [31:0] a;
	reg [31:0] b;

	// Outputs
	wire [31:0] hi;
	wire [31:0] lo;
	wire busy;

	// Instantiate the Unit Under Test (UUT)
	fun uut (
		.clk(clk), 
		.func(func), 
		.start(start), 
		.resetn(resetn), 
		.a(a), 
		.b(b), 
		.hi(hi), 
		.lo(lo), 
		.busy(busy)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		func = 2'b11;
		start = 0;
		resetn = 1;
		a = 32'h7fff;
		b = 32'h10;

		// Wait 100 ns for global reset to finish
		#1
		start=1;
		resetn=0;
      #4
		start=0;
		// Add stimulus here

	end
	always #3 clk=~clk;
      
endmodule

