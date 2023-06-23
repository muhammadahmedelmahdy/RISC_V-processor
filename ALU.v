`timescale 1ns / 1ps
`include "defines.v"
/******************************************************************* *
* Module: ALU.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: ALU module that supports all instructions *
* Change history: 03/06/23 - Added support for ADD, SUB, OR, and AND
* 04/06/23 - Added support for XOR, SLT, SLTU, SLL, SRL, SRA,SLTI, SLTIU, SLLI, SRLI, SRAI
* 04/09/23 - Added support for BGE, BLTU, BGEU, BLT, BGU, BNE
* **********************************************************************/

module ALU(
	input   wire [31:0] a, b,
	input   wire [4:0]  shamt,
	output  reg  [31:0] r,
	output  reg branch,
	input   wire [4:0]  alufn
);
    wire  cf, zf, vf, sf;
    wire [31:0] add, sub, op_b;
    wire cfa, cfs;
    
    assign op_b = (~b);
    
    assign {cf, add} = alufn[0] ? (a + op_b + 1'b1) : (a + b);
    
    assign zf = (add == 0);
    assign sf = add[31];
    assign vf = (a[31] ^ (op_b[31]) ^ add[31] ^ cf);
    
    wire[31:0] sh;
    wire [63:0] mult;
    assign mult=a*b;
    wire[63:0] mult2;
    assign mult2=(a*$unsigned(b));
    always @ * begin
        r = 0;
        (* parallel_case *)
        case (alufn)
            // arithmetic
            `ALU_ADD : r = add;
            `ALU_SUB : r = add;
            //`ALU_PASS : r = b;
            // logic
            `ALU_OR:  r = a | b;
            `ALU_AND :  r = a & b;
            `ALU_XOR:  r = a ^ b;
            // shift
            `ALU_SRL:  r=a>>shamt;
            `ALU_SLL:  r=a<<shamt;
            `ALU_SRA:  r=$signed(a)>>>shamt;
            // slt & sltu
            `ALU_SLT:  r = {31'b0,(sf != vf)}; 
            `ALU_SLTU:  r = {31'b0,(~cf)};
            //branching
            `ALU_BEQ:begin //BEQ
            r=add;
            branch=zf;
            end
            `ALU_BNE:begin //BNE
            r=add;
            branch=~zf;
            end
            `ALU_BLT:begin//BLT
            r=add;
            branch=(sf!=vf);
            end
            `ALU_BGE:begin //BGE 
            r=add;
            branch=(sf==vf);
            end
            `ALU_BLTU:begin
            r=add;
            branch=(~cf);
            end
            `ALU_BGEU:begin
            r=add;
            branch=(cf);
            end
            `ALU_MUL: begin
            r=a*b;
            end
            `ALU_MULH: begin
            r=(mult[63:32]);
            end
            `ALU_MULHU: begin
            r=$unsigned(mult[63:32]);
            end
            `ALU_MULHSU:begin
            r=mult2[63:32];
            end
            `ALU_DIV: begin
            if(b!=0) begin
            r=a/b;
            end
            end
            `ALU_DIVU: begin
            if(b!=0) begin
            r=$unsigned(a/b);
            end
            end
            `ALU_REM:begin
            r=a%b;
            
            end
            `ALU_REMU:begin
            r=$unsigned(a%b);
            end
            
                        	
        endcase
    end
endmodule