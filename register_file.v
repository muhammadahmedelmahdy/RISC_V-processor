`timescale 1ns / 1ps
/******************************************************************* *
* Module: register_file.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: a register file to read registers and write to registers *
* Change history: 03/20/23 - created the register file 
* **********************************************************************/


module register_file #(parameter N = 32)(
    input regWrite,
    input[4:0] writeAddress,
    input[N-1:0] writeData,
    input[4:0] R1Address,
    input[4:0] R2Address,
    input clk,
    input rst, 
    output[N-1:0] R1Data,
    output[N-1:0] R2Data
    );
    reg [N-1:0] regFile [31:0];
    integer i;
    assign R1Data= regFile[R1Address];
    assign R2Data=regFile[R2Address];
    always @(posedge clk or posedge rst)
    begin
    if(rst)
    begin
        for(i=0;i<32;i=i+1)
        begin
        regFile[i]='d0;
        end
    end
    else
    begin
    if(regWrite)
    begin
    if(writeAddress!=32'd0)
    begin
    regFile[writeAddress]=writeData;
    end
    end
    end
    end
endmodule
