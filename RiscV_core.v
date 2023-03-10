`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
// Design Name: 
// Module Name: RiscV_core
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module RiscV_core #(parameter WORD_LENGTH = 32,
                    parameter XLEN = 32)(
    input clk,
    input rst
);

wire en = 1;

// PC_Module
// BranchControl
wire PCSel;
wire [XLEN-1:0] PC, PC_add;

// ROM_Module
wire [XLEN-1:0] Instr;

// Decode_module
wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;
wire [4:0] src1, src2, dest;

// ControUnit
wire [1:0] alu_op, WBSel;
wire mem_read, mem_write, RegWEn, branch, jump, ASel, BSel;

// Registers_Module
wire [XLEN-1:0] rd;
wire [XLEN-1:0] rs1, rs2;

// Alu_Control
wire [4:0] ALU_control_line;

// Mux
wire [XLEN-1:0] out_mux2;
wire [XLEN-1:0] out_mux3;

// ALU_Module
wire [XLEN-1:0] result;
wire zero_flag;

// WB Modules
wire [XLEN-1:0] data_from_MEM;

// Imm.Gen
wire [XLEN-1:0] imm;


// --------------------- IF ---------------------
Adder add(.PC(PC),.PC_add(PC_add));
PC_Module pc(.clk(clk),.PCSel(PCSel),.PC_add(PC_add),.PC_br_jmp(result),.PC(PC));

ROM_Module ro(.clk(clk),.Addr(PC),.ROM_Enable(en),.Instr(Instr),.ROM_Rst(rst));

// --------------------- ID ---------------------
Decode_module de(.clk(clk),.rst(rst),.DecoderEnable(en),.IR(Instr),.opcode(opcode),
                .funct3(funct3),.funct7(funct7),.src1(src1),.src2(src2),.dest(dest));

ControlUnit cu(.clk(clk),.rst(rst),.opcode(opcode),
                .alu_op(alu_op),
                .mem_read(mem_read),
                .mem_write(mem_write),
                .reg_write(RegWEn),
                .branch(branch),
                .jump(jump),
                .ASel(ASel),
                .BSel(BSel),
                .WBSel(WBSel));

ImmGen_Module im(.In(Instr),.Out(imm));

Registers_Module rm(.clk(clk),.src1(src1),.src2(src2),.dest(dest),
                    .we(RegWEn),  
                    .rd(rd),.rs1(rs1),.rs2(rs2));

BranchControl br(.rst(rst),.data1(rs1),.data2(rs2),.branch(branch),
                    .jump(jump),.funct3(funct3),.take_branch(PCSel));

MUX mux2(.a(rs1),.b(PC),.s(ASel),.out(out_mux2)); 
MUX mux3(.a(rs2),.b(imm),.s(BSel),.out(out_mux3));                       
                
// --------------------- EX ---------------------
ALU_control ac(.clk(clk),.rst(clk),.ALUOp(alu_op),.funct7(funct7),
                .funct3(funct3),.ALU_control_line(ALU_control_line));

ALU_Module alu(.ALU_Reset(rst),.rs1(out_mux2),.rs2(out_mux3),
                    .ALU_Enable(en),.ALUOp(ALU_control_line),
                    .result(result),
                    .zero_flag(zero_flag));

// --------------------- MEM ---------------------
DataMemory dm(.clk(clk),.MemWrite(mem_write),.MemRead(mem_read),.address(result),
                .WriteData(rs2),.ReadData(data_from_MEM));

// --------------------- WB ---------------------
WB_Module wb(.clk(clk),.WBSel(WBSel),.PC(PC_add),.data_from_EX(result),.data_from_MEM(data_from_MEM),.data(rd));
    
endmodule