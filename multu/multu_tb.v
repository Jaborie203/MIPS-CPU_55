`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:09:48 07/20/2016
// Design Name:   multu
// Module Name:   G:/projects/CPU_55/multu/multu_tb.v
// Project Name:  multu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: multu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module multu_tb;

	// Inputs
	reg clk;
	reg [31:0]a;
	reg [31:0]b;

	// Outputs
	wire busy;
	wire [63:0] result;

	// Instantiate the Unit Under Test (UUT)
	multu uut (
		.clk(clk), 
		.a(a), 
		.b(b), 
		.busy(busy), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		a = 0;
		b = 0;

		// Wait 100 ns for global reset to finish
		#400;
      a = -1;
		b = 3;
		#800;
      a = -2;
		b = 7;
		#1200;
      a = 55;
		b = 3;
		#1600;
      a = -2;
		b = 9;
		// Add stimulus here

	end
 always #10 clk=~clk;     
endmodule

