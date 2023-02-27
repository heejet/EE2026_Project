`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2023 11:18:03 AM
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
    input basys_clk,
    input [31:0] m,
    output reg new_clk = 0
);

    reg [31:0] COUNT = 0;

    always @ (posedge basys_clk) begin
        COUNT <= (COUNT == m) ? 0 : COUNT + 1;
        new_clk <= (COUNT == 0) ? ~new_clk : new_clk;
    end
    
endmodule
