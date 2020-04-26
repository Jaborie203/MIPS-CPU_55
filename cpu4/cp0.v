`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:52 07/22/2016 
// Design Name: 
// Module Name:    cp0 
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
module cp0(clk,rst,we_i,type,cur_inst_addr,raddr_i,waddr_i,wdata_i,data_o,status_o,cause_o,epc_o);
	input clk;
	input rst;
	input we_i;
	input [1:0]type;
	input [31:0]cur_inst_addr;
	input [4:0]raddr_i;
	input [4:0]waddr_i;
	input [31:0]wdata_i;
	output reg [31:0]data_o;
	output reg [31:0]status_o;
	output reg [31:0]cause_o;
	output reg [31:0]epc_o;
	always@(posedge clk or posedge rst)
	begin
		if(rst==1)
		begin
			status_o<=0;
			cause_o<=0;
			epc_o<=0;
		end
		else
		begin
			if(we_i==1)
			begin
				case(waddr_i)
				5'b01100:
				begin
					status_o<=wdata_i;
				end
				5'b01101:
				begin
					cause_o[9:8]<=wdata_i[9:8];
				end
				5'b01110:
				begin
					epc_o<=wdata_i;
				end
				endcase
			end
			case(type)
			2'b01://系统调用异常syscall
			begin
				if((status_o[1]==1'b0)&&(status_o[0]==1'b0))
				begin
					epc_o<=cur_inst_addr;
				end
				status_o[1]<=1'b1;
				cause_o[7:3]<=5'b01000;
			end
			2'b10://断点break
			begin
				if((status_o[2]==1'b0)&&(status_o[0]==1'b0))
				begin
					epc_o<=cur_inst_addr;
				end
				status_o[2]<=1'b1;
				cause_o[7:3]<=5'b01001;
			end
			2'b11://返回
			begin
				status_o[1]<=1'b0;
				status_o[2]<=1'b0;
			end
			default:
			begin
			end
			endcase
		end
	end
	always@(*)
	begin
		if(rst==1)
		begin
			data_o<=0;
		end
		else
		begin
			case(raddr_i)
			5'b01100:
			begin
				data_o<=status_o;
			end
			5'b01101:
			begin
				data_o<=cause_o;
			end
			5'b01110:
			begin
				data_o<=epc_o;
			end
			endcase
		end
	end
endmodule
