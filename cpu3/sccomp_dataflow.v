`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:36:30 05/03/2016 
// Design Name: 
// Module Name:    sccomp_dataflow 
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
module sccomp_dataflow(clock,reset,pc_out,inst,aluout,dmemout);
    input clock,reset;
	 output [31:0] pc_out,inst,aluout,dmemout;
	 wire [31:0] dmemdata;
	 wire dmemwena;
	 wire [1:0]wbh;
	 
	 sccpu_dataflow cpu(clock,reset,pc_out,inst,dmemwena,aluout,dmemdata,dmemout,wbh);
	 scinstmem imem(pc_out[12:2],inst);
	 scdatamem dmem(clock,wbh,dmemwena,aluout[12:0],dmemdata,dmemout);//在此aluout作为数据存储器的地址
endmodule
