`timescale 1ns / 1ps
/******************************************************************* *
* Module: top.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
* Description: a module that connects all the modules of the processor*
* Change history: 03/25/23 - created the module and added all the needed connections
*04/10/23 - added the jal_jalr_unit module and some multiplexers
* 04/20/23 - added the single memory
* 04/25/23 - added the pipeline registers
* 04/27/23 - Fixed the branching, auipc, lui, jal, and jalr to work with pipelining.
Supported forwarding by creating its module and adding it to the top module and the forwarding multiplexers.
* 04/28/23 - Added the flushing to the top module.
* 05/01/2023 - Added support for the FPGA.
* **********************************************************************/


module top #(parameter N=32)(input clk, input rst,input [1:0] ledSel,input [3:0] ssdSel,input SSDclk,output reg [15:0] leds,output reg [12:0] ssd);
wire branch, memread, memtoreg, memwrite, alusrc, regwrite,auipc,lui,jal_jalr,fence,ebreak;
wire [31:0] InstAddress;
wire [31:0] instruction;
wire [4:0]alusel;
wire [1:0] aluop;
wire [N-1:0] R1Data;
wire [N-1:0] R2Data;
wire [31:0] immOutput;
wire [31:0] mux1_out;
wire [31:0] mux2_out;
wire [31:0] mux3_out;
wire [31:0] mux4_out;
wire [31:0] mux5_out;
wire [31:0] mux6_out;
wire [31:0] mux7_out;
wire [31:0] mux8_out;
wire [31:0] mux9_out;
wire [31:0] fmux1_out,fmux2_out;
wire [31:0] alu_result;
wire zeroflag;
wire [31:0] data_memory_out;
wire[31:0] shiftout;
wire [31:0]  jj_out;
wire[31:0] shifted_address;
wire[31:0] mem_mux_out;
wire[5:0] shamt;
wire branch_anding;
wire [31:0] data;
wire [1:0] forwardA, forwardB;
wire [12:0] control_mux_out;
//IF_ID
wire [31:0] IF_ID_PC, IF_ID_Inst;
//ID_EX inputs
wire [12:0] ID_EX_Ctrl;
wire [4:0] ID_EX_Rs1;
wire [4:0] ID_Ex_Rs2;
wire [31:0] ID_EX_Rs1_Data;
wire [31:0] ID_EX_RS2_Data;
wire [4:0] ID_EX_Rd;
wire [31:0] ID_EX_PC;
wire [31:0] ID_EX_Imm;
wire [3:0] ID_EX_Func;
wire [31:0] ID_EX_Inst;

//EX_MEM
wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_Rs2_Data;
wire [9:0] EX_MEM_Ctrl;
wire [4:0] EX_MEM_Rd;
wire EX_MEM_Zero;
wire [31:0] EX_MEM_imm;
wire [31:0] EX_MEM_PC;
wire [3:0] EX_MEM_func;
wire [31:0] EX_MEM_JJout;
wire [31:0] MEM_WB_mux9_out;
//Mem_WB
wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out;
wire [7:0] MEM_WB_Ctrl;
wire [4:0] MEM_WB_Rd;
wire [31:0] MEM_WB_mux;
wire [31:0] MEM_WB_PC;
wire [31:0] MEM_WB_Imm;
N_bit_register #(64) IF_ID (~clk,rst,1'b1,
 {InstAddress,data_memory_out},
 {IF_ID_PC,IF_ID_Inst} );

N_bit_register #(194) ID_EX(clk,rst,1'b1,
{control_mux_out,IF_ID_PC,R1Data,R2Data,immOutput,{IF_ID_Inst[30],IF_ID_Inst[14:12]},IF_ID_Inst[19:15],IF_ID_Inst[24:20],IF_ID_Inst[11:7],IF_ID_Inst},
{ID_EX_Ctrl,ID_EX_PC, ID_EX_Rs1_Data, ID_EX_RS2_Data, ID_EX_Imm,  ID_EX_Func,ID_EX_Rs1, ID_Ex_Rs2,ID_EX_Rd,ID_EX_Inst});


N_bit_register #(212) EX_MEM (~clk,rst,1'b1,
 {{ID_EX_Ctrl[12:5],ID_EX_Ctrl[2],ID_EX_Ctrl[0]},shifted_address,zeroflag,alu_result,fmux1_out,ID_EX_Rd,ID_EX_Imm,ID_EX_PC,ID_EX_Func,jj_out},
 {EX_MEM_Ctrl, EX_MEM_BranchAddOut, EX_MEM_Zero,
 EX_MEM_ALU_out, EX_MEM_Rs2_Data, EX_MEM_Rd,EX_MEM_imm,EX_MEM_PC,EX_MEM_func,EX_MEM_JJout} );

 N_bit_register #(205) MEM_WB (clk,rst,1'b1,
 {EX_MEM_Ctrl[9:5],EX_MEM_Ctrl[3],EX_MEM_Ctrl[2],EX_MEM_Ctrl[0],data_memory_out,EX_MEM_ALU_out,EX_MEM_Rd,mux5_out,mux9_out,EX_MEM_PC,EX_MEM_imm},
 {MEM_WB_Ctrl,MEM_WB_Mem_out, MEM_WB_ALU_out,
 MEM_WB_Rd,MEM_WB_mux,MEM_WB_mux9_out,MEM_WB_PC,MEM_WB_Imm} );


assign shifted_address=ID_EX_PC+ID_EX_Imm;
assign branch_anding=EX_MEM_Zero&&EX_MEM_Ctrl[4];


assign shamt=((ID_EX_Ctrl[4:3]==2'b11)? ID_Ex_Rs2 : mux1_out);
//InstMem instmem(.addr({2'b00,InstAddress[31:2]}), .data_out(instruction));
control_unit cont(.inst(IF_ID_Inst[6:2]),.inst2(IF_ID_Inst[20]), .branch(branch),.memread(memread),.memtoreg(memtoreg),.aluop(aluop), .memwrite(memwrite),.alusrc(alusrc),.regwrite(regwrite),.auipc(auipc),.lui(lui),.jal_jalr(jal_jalr),.fence(fence),.ebreak(ebreak));
register_file regfile(.regWrite(MEM_WB_Ctrl[0]),.writeAddress(MEM_WB_Rd),.writeData(mux4_out),.R1Address(IF_ID_Inst[19:15]),.R2Address(IF_ID_Inst[24:20]), .clk(~clk), .rst(rst), .R1Data(R1Data), .R2Data(R2Data));
ImmGen immediate(.Imm(immOutput), .IR(IF_ID_Inst)); 
MUX m1(.in1(fmux1_out),.in2(ID_EX_Imm),.select(ID_EX_Ctrl[1]),.out(mux1_out));
alu_control_unit alu_cont(.inst1(ID_EX_Func[2:0]),.inst2(ID_EX_Func[3]),.ALUOP(ID_EX_Ctrl[4:3]),.two_bits(ID_EX_Inst[26:25]), .ALUsel(alusel));
ALU alu(.alufn(alusel), .a(fmux2_out),.b(mux1_out),.shamt(shamt),.r(alu_result), .branch(zeroflag));
MUX m5(.in1(EX_MEM_ALU_out),.in2(EX_MEM_imm),.select(EX_MEM_Ctrl[9]||EX_MEM_Ctrl[8]),.out(mux5_out));
MUX m9(.in1(EX_MEM_imm),.in2(EX_MEM_imm+MEM_WB_PC),.select(EX_MEM_Ctrl[9]),.out(mux9_out));
//DataMem datamemory(.clk(clk), .MemRead(EX_MEM_Ctrl[2]), .MemWrite(EX_MEM_Ctrl[1]),.addr(EX_MEM_ALU_out),.func3(EX_MEM_func), .data_in(EX_MEM_Rs2_Data), .data_out(data_memory_out));
MUX m2(.in1(MEM_WB_mux),.in2(MEM_WB_Mem_out),.select(MEM_WB_Ctrl[2]),.out(mux2_out));
MUX m3(.in1(InstAddress+4),.in2(EX_MEM_BranchAddOut),.select(branch_anding),.out(mux3_out));
MUX2x4 m4(.s0(MEM_WB_Ctrl[5]),.s1(MEM_WB_Ctrl[7]||MEM_WB_Ctrl[6]),.a(mux2_out),.b(EX_MEM_PC+4),.c(MEM_WB_mux9_out),.d('d0),.out(mux4_out));
jal_jalr_unit jjunit(.rs1(ID_EX_Rs1_Data),.imm(ID_EX_Imm),.inst(ID_EX_Inst[3]),.PC(ID_EX_PC),.out(jj_out));
MUX m6 (.in1(mux3_out),.in2(jj_out),.select(ID_EX_Ctrl[10]),.out(mux6_out));
MUX m7(.in1(32'b0),.in2(InstAddress),.select(ebreak),.out(mux7_out));
MUX m8(.in1(mux6_out),.in2(mux7_out),.select(fence||ebreak),.out(mux8_out));
MUX mem_mux(.in1(EX_MEM_ALU_out),.in2(InstAddress),.select(clk),.out(mem_mux_out));
N_bit_register PC(.clk(~clk), .rst(rst), .load(1'b1),.Data(mux8_out), .Q(InstAddress));
Memory mem(.clk(clk), .MemRead(EX_MEM_Ctrl[2]),
    .MemWrite(EX_MEM_Ctrl[1]),.data_in(EX_MEM_Rs2_Data),
    .func3(EX_MEM_func), .addr(mem_mux_out),
    .data_out(data_memory_out));
ForwardingUnit forward(
    .ID_EX_RegisterRs1(ID_EX_Rs1), .ID_EX_RegisterRs2(ID_Ex_Rs2), .EX_MEM_RegisterRd(EX_MEM_Rd), .MEM_WB_RegisterRd(MEM_WB_Rd),
    .EX_MEM_RegWrite(EX_MEM_Ctrl[0]), .MEM_WB_RegWrite(MEM_WB_Ctrl[0]),
    .forwardA(forwardA), .forwardB(forwardB)
    ); 
MUX2x4 fmux1(.s0(forwardB[0]),.s1(forwardB[1]),.a(ID_EX_RS2_Data),.b(EX_MEM_ALU_out),.c(mux2_out),.d('d0),.out(fmux1_out));  
MUX2x4 fmux2(.s0(forwardA[0]),.s1(forwardA[1]),.a(ID_EX_Rs1_Data),.b(EX_MEM_ALU_out),.c(mux2_out),.d('d0),.out(fmux2_out));    
MUX #(13) controlmux(.in1({auipc,lui,jal_jalr,fence,ebreak,branch,memread,memtoreg,aluop,memwrite,alusrc,regwrite}),.in2(12'd0),.select(branch_anding||ID_EX_Ctrl[10]),.out(control_mux_out)); 
always @(*)begin

case(ssdSel)
4'b0000:ssd=InstAddress;
4'b0001: ssd=InstAddress+4;
4'b0010: ssd=InstAddress+shiftout;
4'b0011: ssd=mux3_out;
4'b0100: ssd=R1Data;
4'b0101: ssd=R2Data;
4'b0110: ssd=mux4_out;
4'b0111: ssd=immOutput;
4'b1000:ssd=shiftout;
4'b1001: ssd=mux1_out;
4'b1010: ssd=alu_result;
4'b1011:ssd=data_memory_out;
default:ssd = 0;
endcase

case(ledSel)
2'b00:leds=instruction[15:0];
2'b01: leds=instruction[31:16];
2'b10: leds={aluop,alusel,zeroflag,branch&&zeroflag};
default :leds= 0;
endcase
end


endmodule
