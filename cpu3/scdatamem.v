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
	 input [1:0]wbh,
    input wena, // �洢��д��Ч�źţ���ram_ena ͬʱ��Чʱ�ſ�д�洢��
    input [12:0] addr, // �����ַ��ָ�����ݶ�д�ĵ�ַ
    input [31:0] data_in, // �洢��д������ݣ���clk ������ʱ��д��
    output reg[31:0] data_out // �洢�����������ݣ�ram ����ʱ���������Ӧ��ַ������
    );
	 reg [3:0]sel;
	 reg [7:0] dram0 [0:2047];
    reg [7:0] dram1 [0:2047];
	 reg [7:0] dram2 [0:2047];
	 reg [7:0] dram3 [0:2047];
	 
	 reg [15:0]temp1;
	 reg [7:0]temp2;
	 
	 always@(*)
	 begin
		case(addr[1:0])
		2'b00: sel=4'b1000;
		2'b01: sel=4'b0100;
		2'b10: sel=4'b0010;
		2'b11: sel=4'b0001;
		default:sel=4'b0000;
		endcase
	 end
    always@(negedge clk) 
	 begin 
		if(wena)
		begin
			if(wbh==2'b01)
			begin
				dram3[addr[12:2]]<=data_in[31:24];
				dram2[addr[12:2]]<=data_in[23:16];
				dram1[addr[12:2]]<=data_in[15:8];
				dram0[addr[12:2]]<=data_in[7:0];
			end
			else if(wbh==2'b10)
			begin
				if(sel==4'b1000)
				begin
					dram3[addr[12:2]]<=data_in[15:8];
					dram2[addr[12:2]]<=data_in[7:0];
				end
				else if(sel==4'b0100)
				begin
					dram2[addr[12:2]]<=data_in[15:8];
					dram1[addr[12:2]]<=data_in[7:0];
				end
				else if(sel==4'b0010)
				begin
					dram1[addr[12:2]]<=data_in[15:8];
					dram0[addr[12:2]]<=data_in[7:0];
				end
			end
			else if(wbh==2'b11)
			begin
				if(sel==4'b1000)
				begin
					dram3[addr[12:2]]<=data_in[7:0];
				end
				else if(sel==4'b0010)
				begin
					dram2[addr[12:2]]<=data_in[7:0];
				end
				else if(sel==4'b0100)
				begin
					dram1[addr[12:2]]<=data_in[7:0];
				end
				else if(sel==4'b0001)
				begin
					dram0[addr[12:2]]<=data_in[7:0];
				end
			end
		end
    end
	 always@(*)
	 begin
		if(wbh==2'b01)
		begin
			data_out<={dram3[addr[12:2]],dram2[addr[12:2]],dram1[addr[12:2]],dram0[addr[12:2]]};
		end
		else if(wbh==2'b10)
		begin
			if(sel==4'b1000)
			begin
				temp1<={dram3[addr[12:2]],dram2[addr[12:2]]};
				data_out<={{16{temp1[15]}},temp1};
			end
			else if(sel==4'b0100)
			begin
				temp1<={dram2[addr[12:2]],dram1[addr[12:2]]};
				data_out<={{16{temp1[15]}},temp1};
			end
			else if(sel==4'b0010)
			begin
				temp1<={dram1[addr[12:2]],dram0[addr[12:2]]};
				data_out<={{16{temp1[15]}},temp1};
			end
		end
		else if(wbh==2'b11)
		begin
			if(sel==4'b1000)
			begin
				temp2<=dram3[addr[12:2]];
				data_out<={{24{temp1[15]}},temp1};
			end
			else if(sel==4'b0100)
			begin
				temp2<=dram2[addr[12:2]];
				data_out<={{24{temp1[15]}},temp1};
			end
			else if(sel==4'b0010)
			begin
				temp2<=dram1[addr[12:2]];
				data_out<={{24{temp1[15]}},temp1};
			end
			else if(sel==4'b0001)
			begin
				temp2<=dram0[addr[12:2]];
				data_out<={{24{temp1[15]}},temp1};
			end
		end
	 end
endmodule
