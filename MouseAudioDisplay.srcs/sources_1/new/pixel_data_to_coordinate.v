`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2023 10:16:25
// Design Name: 
// Module Name: pixel_data_to_coordinate
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


module pixel_data_to_coordinate(
    input [12:0] pixel_index,
    output [6:0] x_coord,
    output [5:0] y_coord
    );
    assign x_coord = (pixel_index % 96);
    assign y_coord = (pixel_index / 96);
endmodule
