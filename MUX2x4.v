`timescale 1ns / 1ps
/******************************************************************* *
* Module: MUX2x4.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: a module 4x1 multiplexer *
* Change history: 04/10/23 - created the module and tested it
* **********************************************************************/


module MUX2x4 #(parameter N = 32)( input [N-1:0] a,  
input [N-1:0] b,  
input [N-1:0] c,  
input [N-1:0] d,  
input s0, s1, 
output[N-1:0] out);

assign out = s1 ? (s0 ? d : c) : (s0 ? b : a);
endmodule
