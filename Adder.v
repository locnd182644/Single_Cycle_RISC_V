module Adder #(parameter XLEN = 32)(
                input [XLEN-1:0] PC,
                output [XLEN-1:0] PC_add);
    assign PC_add = PC + 1;     
endmodule
