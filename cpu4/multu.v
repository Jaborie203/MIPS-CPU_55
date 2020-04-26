`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:02:12 07/20/2016 
// Design Name: 
// Module Name:    multu 
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
module multu(a, b, start, clk, resetn, result, busy);
    input clk,start,resetn;
    input [31:0] a, b;
	 output reg busy;
    output [63:0] result;

    reg [4:0] count = 0;
    //reg [1:0] state = 0;
    reg [63:0] P, T;
    reg [31:0] b_reg;
	 assign result=P;
    always @(negedge clk or posedge resetn) 
	 begin
		if(resetn)
		begin
			count<=0;
			busy<=0;
		end
		else
		begin
			if(start)
			begin
				P <= 0;
            b_reg <= b;
            T <= {{32{1'b0}}, a};
				busy<=1;
			end
			else if(busy)
			begin
				if(b_reg[0] == 1'b1)
					P <= P + T;
            else
               P <= P;
            b_reg <= b_reg >> 1;
            T <= T << 1;
            count <= count + 1;
				if(count==5'b11111) busy<=0;				
			end
		end
    end
endmodule
/*case (state)
            s0: begin
                count <= 0;
                P <= 0;
                b_reg <= b;
                T <= {{32{1'b0}}, a};
                state <= s1;
					 busy=1;
            end
            s1: begin
                if(count == 3'b11111)
                    state <= s2;
                else begin
                    if(b_reg[0] == 1'b1)
                        P <= P + T;
                    else
                        P <= P;
                    b_reg <= b_reg >> 1;
                    T <= T << 1;
                    count <= count + 1;
                    state <= s1;
                end
            end
            s2: begin
                result <= P;
                state <= s0;
            end
            default: ;
        endcase*/