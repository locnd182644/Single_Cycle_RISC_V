`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03.10.2020 13:00:11
// Design Name:
// Module Name: ControlUnit
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
`include "src/defines.v"

`timescale 1ns / 1ps

module ControlUnit#(parameter XLEN = 32)
                   (input clk,
                    input rst,
                    input[6:0] opcode,
                    output reg[1:0] alu_op,
                    output reg [1:0] WBSel,
                    output reg  mem_read,
                                mem_write,
                                mem_to_reg,
                                reg_write,
                                branch,
                                jump,
                                ASel,
                                BSel);
    
    always @(*)
    begin
        case(opcode)
            `OP_OP:
            begin
                reg_write   <= 1'b1;
                mem_read    <= 1'b0;
                mem_write   <= 1'b0;
                branch      <= 1'b0;
                jump        <= 1'b0;
                alu_op      <= 2'b10;
                ASel        <= 1'b0;
                BSel        <= 1'b0;
                WBSel       <= 2'b01;
            end
            `OP_OP_IMM:
            begin
                reg_write   <= 1'b1;
                mem_read    <= 1'b0;
                mem_write   <= 1'b0;
                branch      <= 1'b0;
                jump        <= 1'b0;
                alu_op      <= 2'b10;
                ASel        <= 1'b0;
                BSel        <= 1'b1;
                WBSel       <= 2'b01;
            end
            `OP_LOAD:
            begin
                reg_write   <= 1'b1;
                mem_read    <= 1'b1;
                mem_write   <= 1'b0;
                branch      <= 1'b0;
                jump        <= 1'b0;
                alu_op      <= 2'b00;
                ASel        <= 1'b0;
                BSel        <= 1'b1;
                WBSel       <= 2'b00;
            end
            `OP_STORE:
            begin
                reg_write   <= 1'b0;
                mem_read    <= 1'b0;
                mem_write   <= 1'b1;
                branch      <= 1'b0;
                jump        <= 1'b0;
                alu_op      <= 2'b00;
                BSel        <= 1'b1;
                ASel        <= 1'b0;
                WBSel       <= 2'bxx;
            end
            `OP_BRANCH:
            begin
                reg_write   <= 1'b0;
                mem_read    <= 1'b0;
                mem_write   <= 1'b0;
                branch      <= 1'b1;
                jump        <= 1'b0;
                alu_op      <= 2'b01;
                ASel        <= 1'b1;
                BSel        <= 1'b1;
                WBSel       <= 2'bxx;
            end
            `OP_JALR:
            begin
                reg_write   <= 1'b1;
                mem_read    <= 1'b0;
                mem_write   <= 1'b0;
                branch      <= 1'b0;
                jump        <= 1'b1;
                alu_op      <= 2'b11;
                ASel        <= 1'b0;
                BSel        <= 1'b1;
                WBSel       <= 2'b10;
            end
            `OP_JAL:
            begin
                reg_write   <= 1'b1;
                mem_read    <= 1'b0;
                mem_write   <= 1'b0;
                branch      <= 1'b0;
                jump        <= 1'b1;
                alu_op      <= 2'b11;
                ASel        <= 1'b1;
                BSel        <= 1'b1;
                WBSel       <= 2'b10;
            end
            `OP_AUIPC:
            begin
                reg_write   <= 1'b1;
                mem_read    <= 1'b0;
                mem_write   <= 1'b0;
                branch      <= 1'b0;
                jump        <= 1'b0;
                alu_op      <= 2'b11;
                ASel        <= 1'b1;
                BSel        <= 1'b1;
                WBSel       <= 2'b01;
            end
            `OP_LUI:
            begin
                reg_write   <= 1'b1;
                mem_read    <= 1'b0;
                mem_write   <= 1'b0;
                branch      <= 1'b0;
                jump        <= 1'b0;
                alu_op      <= 2'b11;
                ASel        <= 1'b1;
                BSel        <= 1'b1;
                WBSel       <= 2'b01;
            end
            
            default:
            begin
                reg_write   <= 1'bz;
                mem_read    <= 1'bz;
                mem_write   <= 1'bz;
                branch      <= 1'bz;
                alu_op      <= 2'bzz;
                jump        <= 1'bz;
                ASel        <= 1'bz;
                BSel        <= 1'bz;
                WBSel       <= 2'bzz;
            end
            
        endcase
    end
    
endmodule
