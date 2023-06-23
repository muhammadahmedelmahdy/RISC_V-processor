`timescale 1ns / 1ps
/******************************************************************* *
* Module: top_tb.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: a test bench for the top module to check that it is functioning correctly *
* Change history: 03/25/23 - created the testbench and simulated it
* **********************************************************************/


module top_tb();

reg clk;
reg rst;

top CPU(.clk(clk),.rst(rst));
initial begin
clk=1'b0;
forever #10 clk <= ~clk;
end
initial begin
rst = 1'b1;
#1;
rst = 1'b0;
#100000;
$finish;
end
endmodule
