`timescale 1ns / 1ps
/******************************************************************* *
* Module: control_unit.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: control unit module that takes opcode and determines the value of the control signals*
* Change history: 03/15/23 - Created the module and added the control signals
* **********************************************************************/


module control_unit(input [4:0] inst,
input inst2,
 output reg branch,
 output reg memread,
 output reg memtoreg,
 output reg [1:0] aluop,
 output reg memwrite,
 output reg alusrc,
 output reg regwrite,
 output reg auipc,
 output reg lui,
 output reg jal_jalr,
 output reg fence,
 output reg ebreak );
always@(*)
begin
casex(inst) 
5'b01100:begin // R-Format
branch='d0;
memread='d0;
memtoreg='d0;
aluop=2'b10;
memwrite='d0;
alusrc='d0;
regwrite='d1;
auipc='d0;
lui='d0;
jal_jalr='d0;
fence='d0;
ebreak='d0;
end
5'b00100:begin // I-Format
branch='d0;
memread='d0;
memtoreg='d0;
aluop=2'b11;
memwrite='d0;
alusrc='d1;
regwrite='d1;
auipc='d0;
lui='d0;
jal_jalr='d0;
fence='d0;
ebreak='d0;
end
5'b00000:begin // LW
branch='d0;
memread='d1;
memtoreg='d1;
aluop=2'b00;
memwrite='d0;
alusrc='d1;
regwrite='d1;
auipc='d0;
lui='d0;
jal_jalr='d0;
fence='d0;
ebreak='d0;
end
5'b01000:begin // SW
branch='d0;
memread='d0;
memtoreg=1'bx;
aluop=2'b00;
memwrite='d1;
alusrc='d1;
regwrite='d0;
auipc='d0;
lui='d0;
jal_jalr='d0;
fence='d0;
ebreak='d0;
end
5'b11000:begin // All branching
branch='d1;
memread='d0;
memtoreg=1'bx;
aluop=2'b01;
memwrite='d0;
alusrc='d0;
regwrite='d0;
auipc='d0;
lui='d0;
jal_jalr='d0;
fence='d0;
ebreak='d0;
end
5'b00101:begin //auipc
branch='d0;
memread='d0;
memtoreg='d0;
aluop=2'b11;
memwrite='d0;
alusrc='d1;
regwrite='d1;
auipc='d1;
lui='d0;
jal_jalr='d0;
fence='d0;
ebreak='d0;
end
5'b01101:begin //lui
branch='d0;
memread='d0;
memtoreg='d0;
aluop=2'b11;
memwrite='d0;
alusrc='d1;
regwrite='d1;
auipc='d0;
lui='d1;
jal_jalr='d0;
fence='d0;
ebreak='d0;
end
5'b11001:begin // JALR
branch='d0;
memread='d0;
memtoreg='d0;
aluop=2'b11;
memwrite='d0;
alusrc='d0;
regwrite='d1;
auipc='d0;
lui='d0;
jal_jalr='d1;
fence='d0;
ebreak='d0;
end
5'b11011:begin // JAL
branch='d0;
memread='d0;
memtoreg='d0;
aluop=2'b11;
memwrite='d0;
alusrc='d0;
regwrite='d1;
auipc='d0;
lui='d0;
jal_jalr='d1;
fence='d0;
ebreak='d0;
end
5'b00011:begin
branch='d0;
memread='d0;
memtoreg='d0;
aluop=2'b11;
memwrite='d0;
alusrc='d0;
regwrite='d1;
auipc='d0;
lui='d0;
jal_jalr='d0;
fence='d1;
ebreak='d0;
end
5'b11100:begin
if(inst2) begin
branch='d0;
memread='d0;
memtoreg='d0;
aluop=2'b11;
memwrite='d0;
alusrc='d0;
regwrite='d1;
auipc='d0;
lui='d0;
jal_jalr='d0;
fence='d0;
ebreak='d1;
end
else
begin
branch='d0;
memread='d0;
memtoreg='d0;
aluop=2'b11;
memwrite='d0;
alusrc='d0;
regwrite='d1;
auipc='d0;
lui='d0;
jal_jalr='d0;
fence='d1;
ebreak='d0;
end
end
endcase
end
endmodule

