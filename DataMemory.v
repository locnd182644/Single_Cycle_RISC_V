module DataMemory #(parameter XLEN = 32)
                    (input clk, MemWrite, MemRead, [XLEN-1:0] address, WriteData,
                    output reg [XLEN-1:0] ReadData);
                    reg [XLEN-1:0] mem1[511:0];

always @(negedge clk)
begin
    if(MemRead == 1'b1)
        ReadData <= mem1[address];
    else if(MemWrite == 1'b1)
        mem1[address] = WriteData;
end
endmodule
