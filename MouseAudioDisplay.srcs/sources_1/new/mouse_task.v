`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2023 10:17:23
// Design Name: 
// Module Name: mouse_task
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


module mouse_task(
    input clk25mhz,
    input [6:0] cursor_x_pos,
    input [5:0] cursor_y_pos,
    input [12:0] pixel_index,
    output reg [15:0] oled_cursor_data
    );
    
    // Colours
    parameter [15:0] RED = 16'b1111100000000000;
    parameter [15:0] BLACK = 16'b0;
    
    //Get the x and y coord from pixel_index_2
    wire [6:0] pixel_x;
    wire [5:0] pixel_y;
    
    pixel_data_to_coordinate coverter (.pixel_index(pixel_index), .x_coord(pixel_x), .y_coord(pixel_y));
    
    //Invert x and y coordinates as screeen is upside down.
    wire [6:0] pixel_x_correct;
    wire [5:0] pixel_y_correct;
    assign pixel_x_correct = pixel_x;
    assign pixel_y_correct = pixel_y;
    
    always @ (posedge clk25mhz) begin
        if ((pixel_x_correct == cursor_x_pos && pixel_y_correct == cursor_y_pos) || 
            (pixel_x_correct == cursor_x_pos + 1 && pixel_y_correct == cursor_y_pos)||
            (pixel_x_correct == cursor_x_pos && pixel_y_correct == cursor_y_pos + 1) ||
            (pixel_x_correct == cursor_x_pos + 1 && pixel_y_correct == cursor_y_pos + 1)) begin
            oled_cursor_data <= RED;
        end
        else begin
            oled_cursor_data <= BLACK;
        end
    end
    

endmodule
