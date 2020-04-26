`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:39:59 05/04/2016 
// Design Name: 
// Module Name:    scinstmem 
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
module scinstmem(
    input [10:0] addr, // 输入地址，指定数据读写的地址
    output [31:0] data_out // 存储器读出的数据，ram 工作时持续输出相应地址的数据
    );
	 //reg [31:0] data_temp;
	 //assign data_out=data_temp;
    reg [31:0] ram [0:2047];
    initial begin
        $readmemh("inst.txt", ram);		  
    end
	 assign data_out=ram[addr];
endmodule
