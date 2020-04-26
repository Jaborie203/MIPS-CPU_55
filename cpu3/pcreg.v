`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:33:17 05/06/2016 
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
module pcreg(
    input clk, // 1 λ���룬�Ĵ���ʱ���źţ�������ʱΪPC�Ĵ�����ֵ
    input rst, // 1 λ���룬�����źţ��ߵ�ƽʱ��PC �Ĵ�������
               // ע����ena �ź���Чʱ��rst Ҳ�������üĴ���
    input ena, // 1 λ����,��Ч�źŸߵ�ƽʱPC �Ĵ���������data_in ��ֵ�����򱣳�ԭ�����
    input [31 : 0] data_in, // 31 λ���룬�������ݽ�������Ĵ����ڲ�
    output reg [31 : 0] data_out // 31 λ���������ʱʼ�����PC �Ĵ����ڲ��洢��ֵ
    );
always@(posedge rst or posedge clk)
    if(rst) data_out <= 0;
	 else if(!ena) data_out <= data_in;
endmodule 