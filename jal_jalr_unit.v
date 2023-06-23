`timescale 1ns / 1ps
/******************************************************************* *
* Module: jal_jalr_unit.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: a module that determines whether the instruction is jal or jalr and does the computation of the outpu accordingly *
* Change history: 04/10/23 - created the module and tested it
* **********************************************************************/

module jal_jalr_unit(input [4:0] rs1,
input [19:0] imm,
input inst,
input [31:0] PC,
output reg [31:0] out);
always@(*)
begin
if(inst=='d1) begin //JAL
out=PC+imm;
end
else
begin
if(inst=='d0) begin //JALR
out=imm+rs1;
end
end
end
endmodule
