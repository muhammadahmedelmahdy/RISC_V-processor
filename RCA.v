`timescale 1ns / 1ps
/******************************************************************* *
* Module: RCA.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: a ripple carry adder module to support addition and suptraction *
* Change history: 03/15/23 - created the module and tested it
* **********************************************************************/


module RCA(input [31:0] a,b,input cin,output[31:0] sum,output cout);

assign  {cout, sum } = a+ b+ cin ;
endmodule
