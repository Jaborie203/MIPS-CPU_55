`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:17:17 05/06/2016 
// Design Name: 
// Module Name:    regfiles 
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
module regfiles(
    input clk, //�Ĵ�����ʱ���źţ��½���д�����ݣ�ע�⣺pc Ϊ�����أ���Ϊ�½��أ�
    input rst, //reset �źţ�reset ��Чʱȫ���Ĵ�������
    input we, //д��Ч�źţ�we ��Чʱ�Ĵ������ܱ�д��
    input [4:0] raddr1, //�����ȡ�ļĴ����ĵ�ַ
    input [4:0] raddr2, //�����ȡ�ļĴ����ĵ�ַ
    input [4:0] waddr, //д�Ĵ����ĵ�ַ
    input [31:0] wdata, //д�Ĵ�������
    output [31:0] rdata1, //raddr1 ����Ӧ�Ĵ��������ݣ�ֻҪ��raddr1 �����뼴�����Ӧ����
    output [31:0] rdata2 //raddr2 ����Ӧ�Ĵ��������ݣ�ֻҪ��raddr2 �����뼴�����Ӧ����
    );
	 wire [31:0]regi;
	 wire [31:0] reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14,reg15,reg16,reg17,reg18,reg19,reg20,reg21,reg22,reg23,reg24,reg25,reg26,reg27,reg28,reg29,reg30,reg31;
    decoder5_32 decd(waddr,we,regi);
    pcreg p0(clk,1'b1,regi[0],wdata,reg0);
    pcreg p1(clk,rst,regi[1],wdata,reg1);
    pcreg p2(clk,rst,regi[2],wdata,reg2);
    pcreg p3(clk,rst,regi[3],wdata,reg3);
    pcreg p4(clk,rst,regi[4],wdata,reg4);
    pcreg p5(clk,rst,regi[5],wdata,reg5);
    pcreg p6(clk,rst,regi[6],wdata,reg6);
    pcreg p7(clk,rst,regi[7],wdata,reg7);
    pcreg p8(clk,rst,regi[8],wdata,reg8);
    pcreg p9(clk,rst,regi[9],wdata,reg9);
    pcreg p10(clk,rst,regi[10],wdata,reg10);
    pcreg p11(clk,rst,regi[11],wdata,reg11);
    pcreg p12(clk,rst,regi[12],wdata,reg12);
    pcreg p13(clk,rst,regi[13],wdata,reg13);
    pcreg p14(clk,rst,regi[14],wdata,reg14);
    pcreg p15(clk,rst,regi[15],wdata,reg15);
    pcreg p16(clk,rst,regi[16],wdata,reg16);
    pcreg p17(clk,rst,regi[17],wdata,reg17);
    pcreg p18(clk,rst,regi[18],wdata,reg18);
    pcreg p19(clk,rst,regi[19],wdata,reg19);
    pcreg p20(clk,rst,regi[20],wdata,reg20);
    pcreg p21(clk,rst,regi[21],wdata,reg21);
    pcreg p22(clk,rst,regi[22],wdata,reg22);
    pcreg p23(clk,rst,regi[23],wdata,reg23);
    pcreg p24(clk,rst,regi[24],wdata,reg24);
    pcreg p25(clk,rst,regi[25],wdata,reg25);
    pcreg p26(clk,rst,regi[26],wdata,reg26);
    pcreg p27(clk,rst,regi[27],wdata,reg27);
    pcreg p28(clk,rst,regi[28],wdata,reg28);
    pcreg p29(clk,rst,regi[29],wdata,reg29);
    pcreg p30(clk,rst,regi[30],wdata,reg30);
    pcreg p31(clk,rst,regi[31],wdata,reg31);
    mux32_1 mu32_1_1(reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14,reg15,reg16,reg17,reg18,reg19,reg20,reg21,reg22,reg23,reg24,reg25,reg26,reg27,reg28,reg29,reg30,reg31,raddr1,rdata1);
    mux32_1 mu32_1_2(reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14,reg15,reg16,reg17,reg18,reg19,reg20,reg21,reg22,reg23,reg24,reg25,reg26,reg27,reg28,reg29,reg30,reg31,raddr2,rdata2);
endmodule

