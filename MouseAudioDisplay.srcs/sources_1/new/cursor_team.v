`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2023 23:10:49
// Design Name: 
// Module Name: cursor_team
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


module cursor_team(
    input basys_clk,
    input clk6p25m,
    input btn_C,
    input [6:0] cursor_x_pos,
    input [5:0] cursor_y_pos,
    input [12:0] pixel_index_2,
    output reg [15:0] oled_cursor_data
    );
    
    // Colours
    parameter [15:0] RED = 16'b1111100000000000;
    parameter [15:0] BLACK = 16'b0;
    
    //Get the x and y coord from pixel_index_2
    wire [6:0] pixel_x;
    wire [5:0] pixel_y;
    
    pixel_data_to_coordinate coverter (.pixel_index(pixel_index_2), .x_coord(pixel_x), .y_coord(pixel_y));
    
    //Invert x and y coordinates as screeen is upside down.
    wire [6:0] pixel_x_correct;
    wire [5:0] pixel_y_correct;
    
    always @ (posedge clk6p25m) begin
        if ((pixel_x == cursor_x_pos && pixel_y == cursor_y_pos) || 
            (pixel_x == cursor_x_pos + 1 && pixel_y == cursor_y_pos)||
            (pixel_x == cursor_x_pos && pixel_y == cursor_y_pos + 1) ||
            (pixel_x == cursor_x_pos + 1 && pixel_y == cursor_y_pos + 1)) begin
            oled_cursor_data <= RED;
        end
    end
    

endmodule
