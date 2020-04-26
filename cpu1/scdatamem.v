`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:40:22 05/04/2016 
// Design Name: 
// Module Name:    scdatamem 
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
module scdatamem(
    input clk, // 存储器时钟信号，上升沿时向ram 内部写入数据
    input wena, // 存储器写有效信号，与ram_ena 同时有效时才可写存储器
    input [10:0] addr, // 输入地址，指定数据读写的地址
    input [31:0] data_in, // 存储器写入的数据，在clk 上升沿时被写入
    output [31:0] data_out // 存储器读出的数据，ram 工作时持续输出相应地址的数据
    );
    reg [31:0] dram1 [0:2047];
	 assign data_out=dram[addr];	 
    always@(negedge clk) begin 
	 if(wena==1) dram[addr]<=data_in;
        end	
endmodule
