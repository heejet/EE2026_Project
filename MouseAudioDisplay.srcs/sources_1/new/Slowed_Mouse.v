`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2023 10:52:31
// Design Name: 
// Module Name: Slowed_Mouse
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

module Slowed_Mouse(
    input clock,
    input [10:0] cursor_x_in,
    input [10:0] cursor_y_in,
    input [31:0] factor,
    output [10:0] cursor_x_out,
    output [10:0] cursor_y_out 
    );

    assign cursor_x_out = cursor_x_in / factor;
    assign cursor_y_out = cursor_y_in / factor;
endmodule
