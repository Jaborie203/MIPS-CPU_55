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
    input clk, // �洢��ʱ���źţ�������ʱ��ram �ڲ�д������
    input wena, // �洢��д��Ч�źţ���ram_ena ͬʱ��Чʱ�ſ�д�洢��
    input [10:0] addr, // �����ַ��ָ�����ݶ�д�ĵ�ַ
    input [31:0] data_in, // �洢��д������ݣ���clk ������ʱ��д��
    output [31:0] data_out // �洢�����������ݣ�ram ����ʱ���������Ӧ��ַ������
    );
    reg [31:0] dram1 [0:2047];
	 assign data_out=dram[addr];	 
    always@(negedge clk) begin 
	 if(wena==1) dram[addr]<=data_in;
        end	
endmodule
