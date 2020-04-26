`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:47:41 07/21/2016
// Design Name:   divu
// Module Name:   G:/projects/CPU_55/divu/tb.v
// Project Name:  divu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: divu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg start;
	reg clock;
	reg resetn;

	// Outputs
	wire [31:0] q;
	wire [31:0] r;
	wire busy;

	// Instantiate the Unit Under Test (UUT)
	divu uut (
		.a(a), 
		.b(b), 
		.start(start), 
		.clock(clock), 
		.resetn(resetn), 
		.q(q), 
		.r(r), 
		.busy(busy)
	);

	initial begin
		// Initialize Inputs
		start = 0;
		clock = 0;
		resetn = 0;
		a=1;
		b=2;
		// Wait 100 ns for global reset to finish
		#3;
      start = 1;
		resetn = 1;
		a=1;
		b=2;
		#120;
		a=-1;
		b=2;
		#240;
		a=55;
		b=2;
		// Add stimulus here

	end
   always #3 clock=~clock;
	always@(posedge clock)
	begin
		if(busy) start<=0;
		else start<=1;
	end
endmodule

