`timescale 1ns / 1ps
/******************************************************************* *
* Module: ForwardingUnit.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: CPU top module for connecting top module with board *
* Change history: 04/27/2023- created the module 
* **********************************************************************/

module ForwardingUnit(
    input [4:0] ID_EX_RegisterRs1, ID_EX_RegisterRs2, EX_MEM_RegisterRd, MEM_WB_RegisterRd,
    input EX_MEM_RegWrite, MEM_WB_RegWrite,
    output reg [1:0] forwardA, forwardB
    );
   
    always @(*) begin
        if ( (EX_MEM_RegWrite & (EX_MEM_RegisterRd != 0)) && (EX_MEM_RegisterRd == ID_EX_RegisterRs1) ) begin
      forwardA = 2'b10;
   end
   else  if ( (MEM_WB_RegWrite && (MEM_WB_RegisterRd != 0)) && (MEM_WB_RegisterRd == ID_EX_RegisterRs1)
    && !( EX_MEM_RegWrite && (EX_MEM_RegisterRd != 0) && (EX_MEM_RegisterRd == ID_EX_RegisterRs1) ) ) begin
      forwardA = 2'b01;
    end
    else begin
      forwardA = 2'b00;
    end
   if ( (EX_MEM_RegWrite & (EX_MEM_RegisterRd != 0) ) && (EX_MEM_RegisterRd == ID_EX_RegisterRs2) ) begin
      forwardB = 2'b10;
   end
    else if ( (MEM_WB_RegWrite && (MEM_WB_RegisterRd != 0) ) && (MEM_WB_RegisterRd == ID_EX_RegisterRs2)
    && !(EX_MEM_RegWrite && (EX_MEM_RegisterRd != 0) && (EX_MEM_RegisterRd == ID_EX_RegisterRs2))) begin
      forwardB = 2'b01;
    end
    else begin
      forwardB = 2'b00;
    end
    end
   
endmodule
