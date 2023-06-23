`timescale 1ns / 1ps
/******************************************************************* *
* Module: cputop.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: CPU top module for connecting top module with board *
* Change history: 03/06/23 - created the module and tested it 
* **********************************************************************/


module cputop (input clk, input rst,input [1:0] ledSel,input [3:0] ssdSel,input SSDclk,input numsel,output [3:0] Anode,
output [6:0] LED_out, output [15:0] leds);

wire [12:0] ssd;
wire[15:0] muxout;
top cpu(.clk(SSDclk),.rst(rst),.ledSel(ledSel),.ssdSel(ssdSel),.SSDclk(clk),.leds(leds),.ssd(ssd));
Four_Digit_Seven_Segment_Driver driver(.clk(clk),.num(ssd),.Anode(Anode),.LED_out(LED_out));



endmodule
