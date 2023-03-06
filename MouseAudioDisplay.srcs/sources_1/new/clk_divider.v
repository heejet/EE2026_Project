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
    output reg my_clk
);

    reg [31:0] COUNT = 0;

    always @ (posedge basys_clk) begin
        COUNT <= (COUNT == m) ? 0 : COUNT + 1;
        my_clk <= (COUNT == 0) ? ~my_clk : my_clk;
    end
    
endmodule
