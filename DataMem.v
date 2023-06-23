`timescale 1ns / 1ps
/******************************************************************* *
* Module: DataMem.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: A module for the data memory where values can be stored*
* Change history: 03/20/23 - Created the module and added some intitial values
* **********************************************************************/


module DataMem
 (input clk, input MemRead, input MemWrite,
 input [5:0] addr, input [31:0] data_in,input [2:0] func3, output reg [31:0] data_out);
 reg [7:0] mem [0:500];
initial begin
mem[0]= 8'd250;
mem[1]=-8'd138; 
mem[2]=8'b11011000; 
mem[3]=8'b0;
mem[4]= 8'b10001010;
mem[8]=8'd5;
mem[9]=8'd0;
//mem[3]=-32'd3320;
//mem[4]=-32'd1220;
 end 
reg[31:0] temp;
always@(*) begin
if(MemRead) begin
temp=mem[addr];

case(func3) 
3'b000: data_out=$signed(mem[addr]); //lb
3'b001: data_out=$signed({mem[addr+1],mem[addr]}); //lhw
3'b010: data_out=$signed({mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]}); //lw
3'b100: data_out=$unsigned(mem[addr]); //lbu
3'b101: data_out=$unsigned({mem[addr+1],mem[addr]}); //lhu
endcase
end
else begin

data_out=32'd0;
end
end
always @(posedge clk) begin
if(MemWrite)begin 
case(func3)
3'b000: mem[addr]=data_in[7:0]; //sb
3'b001: {mem[addr+1],mem[addr]}=data_in[15:0]; //sh
3'b010: {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]}=data_in; //sw
endcase
end
end
endmodule