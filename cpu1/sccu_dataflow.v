`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:49:46 05/05/2016 
// Design Name: 
// Module Name:    sccu_dataflow 
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
module sccu_dataflow(op,func,rt,z,n,regrt,jal,sext,m2reg,pcsource,wmem,aluc,shift,aluimm,wreg,sext1,lbh_c);
    input [5:0]op,func;
	 input [4:0]rt;
	 input z,n;
	 output regrt,jal,sext,m2reg,wmem,shift,wreg,sext;
	 output [1:0]aluimm;
	 output [1:0]pcsource;
	 output [3:0]aluc;
	 output [1:0]lbh_c;

	 wire r_type=~|op;
	 wire i_add=r_type&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
	 wire i_sub=r_type&func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0];
	 wire i_and=r_type&func[5]&~func[4]&~func[3]&func[2]&~func[1]&~func[0];
	 wire i_or=r_type&func[5]&~func[4]&~func[3]&func[2]&~func[1]&func[0];
	 wire i_xor=r_type&func[5]&~func[4]&~func[3]&func[2]&func[1]&~func[0];
	 wire i_sll=r_type&~func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
	 wire i_srl=r_type&~func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0];
	 wire i_sra=r_type&~func[5]&~func[4]&~func[3]&~func[2]&func[1]&func[0];
	 wire i_jr=r_type&~func[5]&~func[4]&func[3]&~func[2]&~func[1]&~func[0];
	 
	 wire i_addu=r_type&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&func[0];
	 wire i_subu=r_type&func[5]&~func[4]&~func[3]&~func[2]&func[1]&func[0];
	 wire i_nor=r_type&func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0];
	 wire i_slt=r_type&func[5]&~func[4]&func[3]&~func[2]&func[1]&~func[0];
	 wire i_sltu=r_type&func[5]&~func[4]&func[3]&~func[2]&func[1]&func[0];
	 wire i_sllv=r_type&~func[5]&~func[4]&~func[3]&func[2]&~func[1]&~func[0];
	 wire i_srlv=r_type&~func[5]&~func[4]&~func[3]&func[2]&func[1]&~func[0];
	 wire i_srav=r_type&~func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0];
	 
    wire i_addi=~op[5]&~op[4]&op[3]&~op[2]&~op[1]&~op[0];
	 wire i_andi=~op[5]&~op[4]&op[3]&op[2]&~op[1]&~op[0];
	 wire i_ori=~op[5]&~op[4]&op[3]&op[2]&~op[1]&op[0];
	 wire i_xori=~op[5]&~op[4]&op[3]&op[2]&op[1]&~op[0];
	 wire i_lw=op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
	 wire i_sw=op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0];
	 wire i_beq=~op[5]&~op[4]&~op[3]&op[2]&~op[1]&~op[0];
	 wire i_bne=~op[5]&~op[4]&~op[3]&op[2]&~op[1]&op[0];
	 wire i_lui=~op[5]&~op[4]&op[3]&op[2]&op[1]&op[0];
	 wire i_j=~op[5]&~op[4]&~op[3]&~op[2]&op[1]&~op[0];
	 wire i_jal=~op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
	 
	 wire i_addiu=~op[5]&~op[4]&op[3]&~op[2]&~op[1]&op[0];
	 wire i_slti=~op[5]&~op[4]&op[3]&~op[2]&op[1]&~op[0];
	 wire i_sltiu=~op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0];
	 
	 wire i_bgez=~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&op[0]&~rt[4]&~rt[3]&~rt[2]&~rt[1]&rt[0];
	 wire i_bgtz=~op[5]&~op[4]&~op[3]&op[2]&op[1]&op[0]&~rt[4]&~rt[3]&~rt[2]&~rt[1]&~rt[0];
	 wire i_blez=~op[5]&~op[4]&~op[3]&op[2]&op[1]&~op[0]&~rt[4]&~rt[3]&~rt[2]&~rt[1]&~rt[0];
	 wire i_bltz=~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&op[0]&~rt[4]&~rt[3]&~rt[2]&~rt[1]&~rt[0];
	 
	 wire i_jalr=~func[5]&~func[4]&func[3]&~func[2]&~func[1]&func[0];
	 wire i_lb=op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0];
	 wire i_lbu=op[5]&~op[4]&~op[3]&op[2]&~op[1]&~op[0];
	 wire i_lh=op[5]&~op[4]&~op[3]&~op[2]&~op[1]&op[0];
	 wire i_lh=op[5]&~op[4]&~op[3]&op[2]&~op[1]&op[0];
	 wire i_sb=op[5]&~op[4]&op[3]&~op[2]&~op[1]&~op[0];
	 wire i_sb=op[5]&~op[4]&op[3]&~op[2]&~op[1]&op[0];
    
	 assign regrt=i_addi|i_andi|i_ori|i_xori|i_lw|i_lui|i_addiu|i_slti|i_sltiu;
	 assign jal=i_jal|i_jalr;
	 assign sext=i_addi|i_lw|i_sw|i_beq|i_bne|i_addiu|i_slti|i_sltiu|i_bgez|i_bgtz|i_blez|i_bltz;
	 assign m2reg=i_lw;
	 assign pcsource[1]=i_jr|i_j|i_jal|i_jalr;
	 assign pcsource[0]=i_beq&z|i_bne&~z|i_j|i_jal|i_bgez&~n|i_bgtz&~z&~n|i_bltz&~z&n|i_blez&z&~n|i_blez&~z&n;
	 assign wmem=i_sw;
	 assign aluc[3]=i_sll|i_srl|i_sra|i_lui|i_slt|i_sltu|i_sllv|i_srlv|i_srav|i_slti|i_sltiu;
	 assign aluc[2]=i_and|i_or|i_xor|i_sll|i_srl|i_sra|i_andi|i_ori|i_xori|i_beq|i_bne|i_nor|i_sllv|i_srlv|i_srav;
	 assign aluc[1]=i_add|i_sub|i_xor|i_sll|i_addi|i_xori|i_lw|i_sw|i_beq|i_bne|i_nor|i_slt|i_sltu|i_sllv|i_slti|i_sltiu|i_bgez|i_bgtz|i_blez|i_bltz;
	 assign aluc[0]=i_sub|i_or|i_srl|i_ori|i_subu|i_nor|i_slt|i_srlv|i_slti|i_bgez|i_bgtz|i_blez|i_bltz;
	 assign shift=i_sll|i_srl|i_sra;
	 assign aluimm[0]=i_addi|i_andi|i_ori|i_xori|i_lw|i_lui|i_sw|i_addiu|i_slti|i_sltiu;
	 assign aluimm[1]=i_bgez|i_bgtz|i_blez|i_bltz;
	 assign wreg=i_add|i_sub|i_and|i_or|i_xor|i_sll|i_srl|i_sra|i_addi|i_andi|i_ori|i_xori|i_lw|i_lui|i_jal|i_addu|i_subu|i_nor|i_slt|i_sltu|i_sllv|i_srlv|i_srav|i_addiu|i_slti|i_sltiu|i_jalr; 
	 assign sext1=i_lb|i_lh;
	 assign lbh_c[0]=i_lb|i_lbu;
	 assign lbh_c[1]=i_lh|i_lhu;
endmodule 