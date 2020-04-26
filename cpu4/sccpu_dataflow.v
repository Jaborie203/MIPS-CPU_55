`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:11:24 05/03/2016 
// Design Name: 
// Module Name:    sccpu_dataflow 
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
module sccpu_dataflow(clock,reset,pc_out,inst,dmemwena,aluout,dmemdata,dmemout,wbh,wbh_fh);
    /*******BODY*******/        
	 input clock,reset;
	 input [31:0] inst,dmemout;
	 output dmemwena;
	 output [31:0] pc_out,aluout,dmemdata;
	 output [1:0]wbh;
	 output wbh_fh;
	 
	 
	 /*******CU*******/           
	 wire m2reg;
	 wire [1:0]pcsource;
	 wire wmem;
	 wire [3:0]aluc;
	 wire shift;
	 wire [1:0]aluimm;
	 wire wreg;
    wire regrt;
	 wire jal;
	 wire sext;
	 wire [1:0]wbh_temp;
	 wire ena_hi,ena_lo;
	 wire [2:0]jal1;
	 wire [2:0]hi_c,lo_c;
	 wire pc_ena;
	 wire start_m1,start_d1,start_d2;
	 wire wbh_fh_t;
	 wire cp0_ena;
	 wire [1:0]type;
	 wire [1:0]selpc;
	 /*******ALU*******/
	 wire z,c,n,o;
	 wire [31:0]r;                 //Ϊ�˲��������ӹ�ϵ��������һwire����
    /*******Regfiles*******/
	 wire [31:0]qa,qb;
	 /*******Inst Mem*******/
	 wire [5:0]op;
	 assign op=inst[31:26];
	 wire [5:0]func;
	 assign func=inst[5:0];
	 wire [4:0]rs;
	 assign rs=inst[25:21];
	 wire [4:0]rt;
	 assign rt=inst[20:16];
	 wire [4:0]rd;
	 assign rd=inst[15:11];
	 wire [4:0]sa;
	 assign sa=inst[10:6];
	 wire [15:0]imm;
	 assign imm=inst[15:0];
	 wire [25:0]addr;
	 assign addr=inst[25:0];
	 /*******Data Mem*******/
	 wire [31:0]dmemout_wire;
	 assign dmemout_wire=dmemout;
	 /*******PC*******/
	 wire [31:0]pc_out_wire;
	 /*******HILO*******/
	 wire [31:0]hi_o,lo_o;
	 /*******FUN*******/
	 wire [31:0]r_d1,r_d2,q_d1,q_d2;
	 wire [63:0]result_m1,result_m2;
	 wire busy_m1,busy_d1,busy_d2;
	 /*******CP0*******/
	 wire [31:0]data_o,status_o,cause_o,epc_o;
	 /*******Little Unit*******/
	 wire [31:0]pc_next;            //��һ��ָ��
	 assign pc_next=pc_out_wire+4;
	 wire [4:0]regrt_mux;
	 wire [4:0]wn;
	 assign wn=regrt_mux|{5{jal}};   //ͼ��С����f
	 wire [31:0]jal_mux;             //jalָ��������ָ�����ѡ��
	 wire [31:0]sa_ext;
	 wire [31:0]imm_ext;
	 wire [31:0]shift_mux;
	 wire [31:0]aluimm_mux;
	 wire [31:0]imm_ext_sl;
	 assign imm_ext_sl={imm_ext[29:0],2'b0};
	 wire [31:0]branch_plus;          //bne,beqָ����ת
	 assign branch_plus=imm_ext_sl+pc_out_wire;
	 wire [27:0]addr_sl;
	 assign addr_sl={addr,2'b0};
	 wire [31:0]addr_pc;
	 assign addr_pc={pc_next[31:28],addr_sl};
	 wire [31:0]m2reg_mux;
	 wire [31:0]pc_mux;
	 wire rf_we,alu_o;
	 wire [31:0]hi_mux,lo_mux;
	 wire [31:0]pc_mux1;
	 
	 assign dmemwena=wmem;
	 assign wbh=wbh_temp;
	 assign wbh_fh=wbh_fh_t;
	 assign aluout=r;
	 assign dmemdata=qb;
	 assign pc_out=pc_out_wire;
	 assign alu_o = !m2reg & !jal & o;
	 assign rf_we = wreg & !alu_o;
	 
	 ext #(5) ext_sa(sa,1'b0,sa_ext);
	 ext ext_imm(imm,sext,imm_ext);
	 sccu_dataflow cu(op,func,rs,rt,z,n,busy_m1,busy_d1,busy_d2,status_o[2:0],regrt,jal,sext,m2reg,pcsource,wmem,aluc,shift,aluimm,wreg,wbh_temp,wbh_fh_t,ena_hi,ena_lo,jal1,pc_ena,hi_c,lo_c,start_m1,start_d1,start_d2,cp0_ena,type,selpc);
	 pc_reg pc(clock,reset,pc_ena,pc_mux,pc_out_wire);
	 mux2c1 #(5) mux_regrt(rd,rt,regrt,regrt_mux);
	 mux5c1 mux_jal(m2reg_mux,pc_next+4,hi_o,lo_o,data_o,jal1,jal_mux);
	 mux2c1 mux_alu_a(qa,sa_ext,shift,shift_mux);
	 mux3c1 mux_alu_b(qb,imm_ext,32'b0,aluimm,aluimm_mux);
	 mux2c1 mux_m2reg(r,dmemout_wire,m2reg,m2reg_mux);
	 mux4c1 mux_pc(pcsource,pc_next,branch_plus,qa,addr_pc,pc_mux1);
	 mux3c1 mux_pc2(pc_mux1,epc_o,32'h4,selpc,pc_mux);
	 regfiles rf(clock,reset,rf_we,rs,rt,wn,jal_mux,qa,qb);
	 //fun f(clock,fun_c,start,reset,qa,qb,hi,lo,busy);
	 multu m1(qa, qb, start_m1, clock, reset, result_m1, busy_m1);
	 mult m2(qa,qb,result_m2);
	 divu d1(qa,qb,start_d1,clock,reset,q_d1,r_d1,busy_d1);
	 div d2(qa,qb,start_d2,clock,reset,q_d2,r_d2,busy_d2);
	 mux5c1 mux_hi(qa,result_m1[63:32],result_m2[63:32],r_d1,r_d2,hi_c,hi_mux);
	 mux5c1 mux_lo(qa,result_m1[31:0],result_m2[31:0],q_d1,q_d2,lo_c,lo_mux);	
	 hilo_reg hi_m(clock,reset,ena_hi,hi_mux,hi_o);
	 hilo_reg lo_m(clock,reset,ena_lo,lo_mux,lo_o);
	 alu alu_unit(shift_mux,aluimm_mux,aluc,r,z,c,n,o);
	 cp0 cpo_m(clock,reset,cp0_ena,type,pc_out_wire,rd,rd,qb,data_o,status_o,cause_o,epc_o);
endmodule
