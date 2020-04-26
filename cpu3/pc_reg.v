`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:38:39 05/05/2016 
// Design Name: 
// Module Name:    pcreg 
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
/*module pc_reg(
    input clk, // 1 位输入，寄存器时钟信号，上升沿时为PC寄存器赋值
    input rst, // 1 位输入，重置信号，高电平时将PC 寄存器清零
    input [31 : 0] data_in, // 31 位输入，输入数据将被存入寄存器内部
    output reg [31 : 0] data_out // 31 位输出，工作时始终输出PC 寄存器内部存储的值
    );
always@(posedge rst or posedge clk)
    if(rst) data_out <= 0;
	 else  data_out <= data_in;
endmodule*/
module pc_reg(
    input clk, // 1 位输入，寄存器时钟信号，上升沿时为PC寄存器赋值
    input rst, // 1 位输入，重置信号，高电平时将PC 寄存器清零
               // 注：当ena 信号无效时，rst 也可以重置寄存器
    input ena, // 1 位输入,有效信号高电平时PC 寄存器工读入data_in 的值，否则保持原有输出
    input [31 : 0] data_in, // 31 位输入，输入数据将被存入寄存器内部
    output reg [31 : 0] data_out // 31 位输出，工作时始终输出PC 寄存器内部存储的值
    );
always@(posedge clk or posedge rst)
    if(rst) data_out <= 0;
	 else if(ena) data_out <= data_in;
endmodule 