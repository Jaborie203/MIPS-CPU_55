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
	 input [1:0]wbh,
    input wena, // 存储器写有效信号，与ram_ena 同时有效时才可写存储器
    input [12:0] addr, // 输入地址，指定数据读写的地址
    input [31:0] data_in, // 存储器写入的数据，在clk 上升沿时被写入
    output reg[31:0] data_out // 存储器读出的数据，ram 工作时持续输出相应地址的数据
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
