`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:
// Module Name: Decode_module
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
module Decode_module(input [31:0] IR,
                input DecoderEnable,
                input wire rst, clk,

                output reg [6:0] opcode,
                output reg [2:0] funct3,
                output reg [6:0] funct7,
                output reg [4:0] src1, src2, dest
                );

initial
begin
    opcode <= 0;
end

always @(*)
begin
    if(rst) begin 
        src1   <= 0;
        src2   <= 0;
        dest   <= 0;
        funct3 <= 0;
        funct7 <= 0;
        opcode <= 0;
    end 
    else if (DecoderEnable) begin
        opcode <= IR[6:0];
        case(IR[6:0])
            `OP_OP:
            begin
                src1   <= IR[19:15];
                src2   <= IR[24:20];
                dest   <= IR[11:7];
                funct3 <= IR[14:12];
                funct7 <= IR[31:25];
            end
            `OP_OP_IMM:
            begin
                src1   <= IR[19:15];
                src2   <= 'bz;
                dest   <= IR[11:7];
                funct3 <= IR[14:12];
                funct7 <= 'b0;
            end
            `OP_LUI:
            begin
                src1   <= 'bz;
                src2   <= 'bz;
                dest   <= IR[11:7];
                funct3 <= 'b0;
                funct7 <= 'b0;
            end
            `OP_AUIPC:
            begin
                src1   <= 'bz;
                src2   <= 'bz;
                dest   <= IR[11:7];
                funct3 <= 'b0;
                funct7 <= 'b0;
            end
            `OP_JAL:
            begin
                src1   <= 'bz;
                src2   <= 'bz;
                dest   <= IR[11:7];
                funct3 <= 'b0;
                funct7 <= 'b0;
            end
            `OP_JALR:
            begin
                src1   <= IR[19:15];
                src2   <= 'bz;
                dest   <= IR[11:7];
                funct3 <= IR[14:12];
                funct7 <= 'b0;
            end
            `OP_BRANCH:
            begin
                src1   <= IR[19:15];
                src2   <= IR[24:20];
                dest   <= 'bz;
                funct3 <= IR[14:12];
                funct7 <= 'b0;
            end
            `OP_LOAD:
            begin
                src1   <= IR[19:15];
                src2   <= 'bz;
                dest   <= IR[11:7];
                funct3 <= IR[14:12];
                funct7 <= 'b0;
            end
            `OP_STORE:
            begin
                src1   <= IR[19:15];
                src2   <= IR[24:20];
                dest   <= 'bz;
                funct3 <= IR[14:12];
                funct7 <= 'b0;
            end
            default :
            ;
        endcase
    end
end

endmodule
