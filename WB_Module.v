`timescale 1ns / 1ps
`include "src/Registers_Module.v"

module WB_Module #(parameter XLEN=32)
                (
                input clk, 
                input [1:0] WBSel,
                input [XLEN-1:0] PC,
                input [XLEN-1:0]data_from_EX,
                input [XLEN-1:0]data_from_MEM,
                output [XLEN-1:0] data
                );

assign data = (WBSel == 2'b10) ? PC + 4 : (WBSel == 2'b01) ? data_from_EX : data_from_MEM;

endmodule