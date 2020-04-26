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
module sccpu_dataflow(clock,reset,pc_out,inst,dmemwena,aluout,dmemdata,dmemout);
    /*******BODY*******/        
	 input clock,reset;
	 input [31:0] inst,dmemout;
	 output dmemwena;
	 output [31:0] pc_out,aluout,dmemdata;
	 
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
	 wire sext1;
	 wire [1:0]lbh_c;
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
	 
	 assign dmemwena=wmem;
	 assign aluout=r;
	 assign dmemdata=qb;
	 assign pc_out=pc_out_wire;
	 assign alu_o = !m2reg & !jal & o;
	 assign rf_we = wreg & !alu_o;
	 
	 ext #(5) ext_sa(sa,1'b0,sa_ext);
	 ext ext_imm(imm,sext,imm_ext);
	 sccu_dataflow cu(op,func,rt,z,n,regrt,jal,sext,m2reg,pcsource,wmem,aluc,shift,aluimm,wreg,sext1,lbh_c);
	 pc_reg pc(clock,reset,pc_mux,pc_out_wire);
	 mux2c1 #(5) mux_regrt(rd,rt,regrt,regrt_mux);
	 mux2c1 mux_jal(lbh_mux,pc_next+4,jal,jal_mux);
	 mux2c1 mux_alu_a(qa,sa_ext,shift,shift_mux);
	 mux3c1 mux_alu_b(qb,imm_ext,32'b0,aluimm,aluimm_mux);
	 mux2c1 mux_m2reg(r,dmemout_wire,m2reg,m2reg_mux);
	 lbh lbh_f(lbh_c,sext1,r[1:0],m2reg_mux,lbh_mux);
	 mux4c1 mux_pc(pcsource,pc_next,branch_plus,qa,addr_pc,pc_mux);
	 regfiles rf(clock,reset,rf_we,rs,rt,wn,jal_mux,qa,qb);
	 alu alu_unit(shift_mux,aluimm_mux,aluc,r,z,c,n,o);
endmodule
