`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2023 02:23:49 AM
// Design Name: 
// Module Name: Mouse_Click
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


module Mouse_Click(
    input [6:0] xpos,
    input [5:0] ypos,
    input left,
    output [12:0] output_display
);
    
    assign output_display = 13'b1;

endmodule
