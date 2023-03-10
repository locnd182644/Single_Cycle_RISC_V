module PC_Module #(parameter XLEN=32)
                (
                    input clk, PCSel,
                    input [XLEN-1:0] PC_add,
                    input [XLEN-1:0] PC_br_jmp,
                    output reg [XLEN-1:0] PC
                );

wire [XLEN-1:0] PC_next;

MUX mux1(.a(PC_add),.b(PC_br_jmp),.s(PCSel),.out(PC_next)); 

initial begin
    PC = 32'hffffffff;
end

always @(negedge clk) begin
    PC <= PC_next;
end

endmodule