`timescale 1ns / 1ps

/******************************************************************* *
* Module: InstMem.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: A module for instruction memory where instructions can be saved in it and accessed *
* Change history: 03/20/23 - created the module and added some instructions
* **********************************************************************/
module InstMem(input [5:0]addr, output [31:0] data_out);

reg [31:0] mem [0:63];

initial begin
    
$readmemh("test1.mem", mem);

 end 
assign data_out = mem[addr];

endmodule