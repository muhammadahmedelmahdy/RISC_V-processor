`timescale 1ns / 1ps
`include"defines.v"
/******************************************************************* *
* Module: alu_control_unit.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Muhammad El-Mahdi
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description:  a module that determines the ALU select lines*
* Change history: 03/06/23 - Added support for ADD, SUB, AND, OR, LW, and SW
*04/05/23 - Added support for XOR, SLT, SLTU, SLL, SRL, SRA, SLLI, SRLI, SRAI, ADDI, SUBI, ANDI, ORI, XORI, SLTI, SLTUI
* 04/09/23 - Added support for BGE, BLTU, BGEU, BLT, BGU, BNE
* **********************************************************************/


module alu_control_unit(input [2:0] inst1,
input inst2,
input[1:0] two_bits,
input [1:0] ALUOP,
output reg [4:0] ALUsel);
always@(*) begin
if(ALUOP == 2'b00)
    ALUsel = 5'b00010;
//else 
//if(ALUOP == 2'b01 )
//    ALUsel = 4'b0110;
else
if(ALUOP == 2'b10 && inst1 == 3'b000 && inst2==1'b0 && two_bits !=2'b01) // add or sub or addi or subi
    ALUsel = `ALU_ADD;
else
if(ALUOP == 2'b10 && inst1 == 3'b000 && inst2==1'b1 && two_bits !=2'b01) // add or sub or addi or subi
    ALUsel = `ALU_SUB;
else
if(ALUOP == 2'b01 && inst1 == 3'b000 ) //BEQ
    ALUsel = `ALU_BEQ;
else
if(ALUOP == 2'b01 && inst1 == 3'b001) //BNE
    ALUsel = `ALU_BNE;
else
if(ALUOP == 2'b01 && inst1 == 3'b100 ) //BLT
    ALUsel = `ALU_BLT;
else
if(ALUOP == 2'b01 && inst1 == 3'b101 ) //BGE
    ALUsel = `ALU_BGE;
else
if(ALUOP == 2'b01 && inst1 == 3'b110 ) //BLTU
    ALUsel = `ALU_BLTU;
else
if(ALUOP == 2'b01 && inst1 == 3'b111 ) //BGEU
    ALUsel = `ALU_BGEU;
else
if((ALUOP == 2'b10 || ALUOP==2'b11) && inst1 == 3'b111 ) //AND OR ANDI
    ALUsel = `ALU_AND;
else
if((ALUOP == 2'b10 || ALUOP==2'b11) && inst1 == 3'b110 ) // OR or ORI
    ALUsel = `ALU_OR;
else
if((ALUOP == 2'b10 || ALUOP==2'b11) && inst1 == 3'b100 ) // XOR or XORI
    ALUsel = `ALU_XOR;
else
if((ALUOP == 2'b10 || ALUOP==2'b11) && inst1 == 3'b011 ) // SLTU or SLTUI
    ALUsel = `ALU_SLTU;
else
if((ALUOP == 2'b10 || ALUOP==2'b11) && inst1 == 3'b010 ) // SLT or SLTI
    ALUsel = `ALU_SLT;
else
if((ALUOP == 2'b10 || ALUOP==2'b11) && inst1 == 3'b001 ) // SLL or SLLI
    ALUsel = `ALU_SLL;
else
if(ALUOP==2'b11 && inst1 == 3'b101 &&inst2==1'b0 )  // SRL or SRLI
    ALUsel = `ALU_SRL;
else
if(ALUOP == 2'b10 && inst1 == 3'b101  && inst2==1'b0)  // SRL or SRLI
    ALUsel = `ALU_SRL;
else
if(ALUOP==2'b10 && inst1 == 3'b101 && inst2==1'b1 )  // SRA or SRAI
    ALUsel = `ALU_SRA;
else
if(ALUOP==2'b11 && inst1 == 3'b101 && inst2==1'b1  )  // SRA or SRAI
    ALUsel = `ALU_SRA;
else
if(ALUOP==2'b11 && inst1 == 3'b000 )
    ALUsel=`ALU_ADD;
else if(ALUOP == 2'b10 && inst1 == 3'b000 && two_bits==2'b01) // add or sub or addi or subi
    ALUsel = `ALU_MUL;
else if(ALUOP == 2'b10 && inst1 == 3'b001 && two_bits==2'b01) // add or sub or addi or subi
    ALUsel = `ALU_MULH;
else if(ALUOP == 2'b10 && inst1 == 3'b010 && two_bits==2'b01) // add or sub or addi or subi
    ALUsel = `ALU_MULHSU;
else if(ALUOP == 2'b10 && inst1 == 3'b011 && two_bits==2'b01) // add or sub or addi or subi
    ALUsel = `ALU_MULHU;
else if(ALUOP == 2'b10 && inst1 == 3'b100 && two_bits==2'b01) // add or sub or addi or subi
    ALUsel = `ALU_DIV;
else if(ALUOP == 2'b10 && inst1 == 3'b101 && two_bits==2'b01) // add or sub or addi or subi
    ALUsel = `ALU_DIVU;
else if(ALUOP == 2'b10 && inst1 == 3'b110 && two_bits==2'b01) // add or sub or addi or subi
    ALUsel = `ALU_REM;
else if(ALUOP == 2'b10 && inst1 == 3'b111 && two_bits==2'b01) // add or sub or addi or subi
    ALUsel = `ALU_REMU;
else
ALUsel=5'b00000;
    

end
endmodule