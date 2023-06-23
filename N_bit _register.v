`timescale 1ns / 1ps
/******************************************************************* *
* Module: N_bit_register.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: a N-bit register that can be used as the PC *
* Change history: 03/15/23 - created the module and tested it
* **********************************************************************/


module N_bit_register #(parameter N = 32)(
    input clk, 
    input rst, 
    input load,
    input [N-1:0] Data,
    output reg [N-1:0] Q
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            Q <= 'd0;
           end else
           begin
           if(load==1'b1)
           Q<=Data;
          
           end
    end
endmodule
