`timescale 1 ns/ 1ps
/*
ALU Control Unit sends control signals to the ALU for performing different operations like add,subtract,AND,OR.
The convention followed for decoding is in accordance to Computer Organisation for RISCV book by Patterson. 
Inputs:
ALUOp - Input from control unit
Funct7, funct3 : Certain sections of instruction word 
Output(To ALU):
ALU_control_line : output signal, 
*/
`include "src/defines.v"

module ALU_control( input clk,
                    input rst,
                    input[1:0] ALUOp, input[6:0] funct7,
                    input[2:0] funct3, output reg [4:0] ALU_control_line);

always @(*)
begin
    if (rst)
        ALU_control_line = 0;
    else begin 
        case(ALUOp)
            2'b00: ALU_control_line = `EXE_ADD_OP; // Load and Store instructions   
            2'b01: ALU_control_line = (funct3 == `FUNCT3_BEQ) ? `EXE_BEQ_OP :     // Arithmetic and Logic Instructions
                                      (funct3 == `FUNCT3_BNE) ? `EXE_BNE_OP :
                                      (funct3 == `FUNCT3_BLT) ? `EXE_BLT_OP :
                                      (funct3 == `FUNCT3_BGE) ? `EXE_BGE_OP:
                                      (funct3 == `FUNCT3_BLTU) ? `EXE_BLTU_OP :
                                      (funct3 == `FUNCT3_BGEU) ? `EXE_BGEU_OP : ALU_control_line;             //Branching instructions
            
            2'b10: ALU_control_line = (funct7 == `FUNCT7_ADD && funct3 == `FUNCT3_ADD_SUB) ? `EXE_ADD_OP :     // Arithmetic and Logic Instructions
                                      (funct7 == `FUNCT7_SUB && funct3 == `FUNCT3_ADD_SUB) ? `EXE_SUB_OP :
                                      (funct7 == `FUNCT7_AND && funct3 == `FUNCT3_AND) ? `EXE_AND_OP :
                                      (funct7 == `FUNCT7_OR && funct3 == `FUNCT3_OR) ? `EXE_OR_OP :
                                      (funct7 == `FUNCT7_SLL && funct3 == `FUNCT3_SLL) ? `EXE_SLL_OP :
                                      (funct7 == `FUNCT7_SRL && funct3 == `FUNCT3_SRL_SRA) ? `EXE_SRL_OP :
                                      (funct7 == `FUNCT7_SLT && funct3 == `FUNCT3_SLT) ? `EXE_SLT_OP : ALU_control_line; 
            2'b11: ;                                //Jump and pc instructions
            default: ALU_control_line = 4'bzzzz;

        endcase 
    end
end
endmodule