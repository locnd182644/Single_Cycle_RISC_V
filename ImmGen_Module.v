`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:
// Module Name: ImmGen_Module
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
module ImmGen_Module #(parameter XLEN = 32)(
input [XLEN-1:0] In,
output reg [XLEN-1:0] Out);
always @(*)
begin
case(In[6:0])
    `OP_OP:     Out <= 'b0;
    `OP_OP_IMM: Out <= {{20{In[31]}},In[31:20]};
    `OP_LUI:    Out <= {In[31:12],{12{1'b0}}};
    `OP_AUIPC:  Out <= {In[31:12],{12{1'b0}}};
    `OP_JAL:    Out <= {In[31], In[19:12], In[20], In[30:21]};
    `OP_JALR:   Out <= In[31:20];
    `OP_BRANCH: Out <= {{20{In[31]}},In[7],In[30:25],In[11:8],1'b0};
    `OP_LOAD:   Out <= {{20{{In[31]}}},In[31:20]};
    `OP_STORE:  Out <= {{20{{In[31]}}},In[31:25],In[11:7]};
    default :   Out <= {32{1'h0}};
endcase
end
endmodule
