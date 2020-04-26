`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:22:03 05/06/2016
// Design Name:   sccomp_dataflow
// Module Name:   G:/projects/cpu_temp2/cpu_tb.v
// Project Name:  cpu1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sccomp_dataflow
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cpu_tb;

	// Inputs
	reg clock;
	reg reset;

	// Outputs
	wire [31:0] pc_out;
	wire [31:0] inst;
	wire [31:0] aluout;
	wire [31:0] dmemout;

	// Instantiate the Unit Under Test (UUT)
	sccomp_dataflow uut (
		.clock(clock), 
		.reset(reset), 
		.pc_out(pc_out),
		.inst(inst), 
		.aluout(aluout), 
		.dmemout(dmemout)
	);
	integer file_output;
	integer counter = 0;
	initial begin
	   file_output = $fopen("result.txt");	//存放register寄存器内容，用于比较指令执行结果
		// Initialize Inputs
		clock = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#3;
      reset = 0;  
		// Add stimulus here

	 end
	 always #3 clock = ~clock;
    always @ (posedge clock)
		begin
				counter = counter + 1;
				$fdisplay(file_output,"regfiles0=%h",uut.cpu.rf.p0.data_out);
				$fdisplay(file_output,"regfiles1=%h",uut.cpu.rf.p1.data_out);
				$fdisplay(file_output,"regfiles2=%h",uut.cpu.rf.p2.data_out);
				$fdisplay(file_output,"regfiles3=%h",uut.cpu.rf.p3.data_out);
				$fdisplay(file_output,"regfiles4=%h",uut.cpu.rf.p4.data_out);
				$fdisplay(file_output,"regfiles5=%h",uut.cpu.rf.p5.data_out);
				$fdisplay(file_output,"regfiles6=%h",uut.cpu.rf.p6.data_out);
				$fdisplay(file_output,"regfiles7=%h",uut.cpu.rf.p7.data_out);
				$fdisplay(file_output,"regfiles8=%h",uut.cpu.rf.p8.data_out);
				$fdisplay(file_output,"regfiles9=%h",uut.cpu.rf.p9.data_out);
				$fdisplay(file_output,"regfiles10=%h",uut.cpu.rf.p10.data_out);
				$fdisplay(file_output,"regfiles11=%h",uut.cpu.rf.p11.data_out);
				$fdisplay(file_output,"regfiles12=%h",uut.cpu.rf.p12.data_out);
				$fdisplay(file_output,"regfiles13=%h",uut.cpu.rf.p13.data_out);
				$fdisplay(file_output,"regfiles14=%h",uut.cpu.rf.p14.data_out);
				$fdisplay(file_output,"regfiles15=%h",uut.cpu.rf.p15.data_out);
				$fdisplay(file_output,"regfiles16=%h",uut.cpu.rf.p16.data_out);
				$fdisplay(file_output,"regfiles17=%h",uut.cpu.rf.p17.data_out);
				$fdisplay(file_output,"regfiles18=%h",uut.cpu.rf.p18.data_out);
				$fdisplay(file_output,"regfiles19=%h",uut.cpu.rf.p19.data_out);
				$fdisplay(file_output,"regfiles20=%h",uut.cpu.rf.p20.data_out);
				$fdisplay(file_output,"regfiles21=%h",uut.cpu.rf.p21.data_out);
				$fdisplay(file_output,"regfiles22=%h",uut.cpu.rf.p22.data_out);
				$fdisplay(file_output,"regfiles23=%h",uut.cpu.rf.p23.data_out);
				$fdisplay(file_output,"regfiles24=%h",uut.cpu.rf.p24.data_out);
				$fdisplay(file_output,"regfiles25=%h",uut.cpu.rf.p25.data_out);
				$fdisplay(file_output,"regfiles26=%h",uut.cpu.rf.p26.data_out);
				$fdisplay(file_output,"regfiles27=%h",uut.cpu.rf.p27.data_out);
				$fdisplay(file_output,"regfiles28=%h",uut.cpu.rf.p28.data_out);
				$fdisplay(file_output,"regfiles29=%h",uut.cpu.rf.p29.data_out);
				$fdisplay(file_output,"regfiles30=%h",uut.cpu.rf.p30.data_out);
				$fdisplay(file_output,"regfiles31=%h",uut.cpu.rf.p31.data_out);

				$fdisplay(file_output,"instr=%h",uut.imem.data_out);
				$fdisplay(file_output,"pc=%h",uut.cpu.pc.data_out);
		end
endmodule

