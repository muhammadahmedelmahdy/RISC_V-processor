`timescale 1ns / 1ps
/******************************************************************* *
* Module: Memory.v
* Project: Pipeline RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: CPU top module for connecting top module with board *
* Change history: 04/20/2023- created the module 
* 04/26/2023- fixed problem wit the clock
* **********************************************************************/


module Memory(input clk, input MemRead,
    input MemWrite,input [31:0] data_in,
    input [2:0] func3, input [10:0] addr,
    output reg [31:0] data_out );
     wire [11:0] off;
    reg [7:0] mem[0:5000];
    assign off = 12'd2048;
   initial begin
   




























$readmemh("test1.mem", mem);
   




{mem[2051],mem[2050],mem[2049],mem[2048]}=32'd250;
{mem[2055],mem[2054],mem[2053],mem[2052]}=-32'd138;
{mem[2059],mem[2058],mem[2057],mem[2056]}=32'd10;

   
   
   end
    always@(* )
    begin
    if(clk) begin
    data_out={mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]}; //inst
    end
    else
    begin
    if(MemRead) begin
    case(func3) //data
    3'b000: data_out=$signed(mem[addr+off]); //lb
    3'b001: data_out=$signed({mem[addr+off+1],mem[addr+off]}); //lhw
    3'b010: data_out=$signed({mem[addr+off+3],mem[addr+off+2],mem[addr+off+1],mem[addr+off]}); //lw
    3'b100: data_out=$unsigned(mem[addr+off]); //lbu
    3'b101: data_out=$unsigned({mem[addr+off+1],mem[addr+off]}); //lhu
    endcase
    end
    end
    end
    always@(negedge clk)begin
    if(MemWrite)begin
    case(func3)
    3'b000: mem[addr+off]=data_in[7:0]; //sb
    3'b001: {mem[addr+off+1],mem[addr+off]}=data_in[15:0]; //sh
    3'b010: {mem[addr+off+3],mem[addr+off+2],mem[addr+off+1],mem[addr+off]}=data_in; //sw
    endcase
    end
   
   
    end
   
   
   
   
   
endmodule