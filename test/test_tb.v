`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:28:23 07/20/2016
// Design Name:   test
// Module Name:   G:/projects/CPU_55/test/test_tb.v
// Project Name:  test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: test
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_tb;

	// Inputs
	reg [8:0] a;
	reg [8:0] b;

	// Outputs
	wire [8:0] c;

	// Instantiate the Unit Under Test (UUT)
	test uut (
		.a(a), 
		.b(b), 
		.c(c)
	);

	initial begin
		// Initialize Inputs
		a = 45;
		b = 3;

		// Wait 100 ns for global reset to finish
		#100;
      a = 99;
		b = 77;  
		// Add stimulus here

	end
      
endmodule

