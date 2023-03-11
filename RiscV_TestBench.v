`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
// Design Name: 
// Module Name: RiscV_TestBench
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

module RiscV_TestBench;
    // Input
    reg clk = 1, rst = 0;
    // Output

    // DUT
    RiscV_core dut(.clk(clk),.rst(rst));

    // Clock
    always #10 clk = ~clk;

endmodule