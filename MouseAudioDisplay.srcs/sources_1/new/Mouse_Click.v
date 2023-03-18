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
    input basys_clock,
    input [6:0] cursor_x_pos,
    input [5:0] cursor_y_pos,
    input mouse_left_btn,
    output reg [12:0] change
);

    always @ (*) begin
        if (mouse_left_btn) begin
            if (cursor_x_pos >= 11 && cursor_x_pos <= 15 && cursor_y_pos >= 7 && cursor_y_pos <= 11) begin
                change <= (1 << 0);
            end
            else if (cursor_x_pos >= 17 && cursor_x_pos <= 38 && cursor_y_pos >= 7 && cursor_y_pos <= 11) begin
                change <= (1 << 1);
            end
            else if (cursor_x_pos >= 40 && cursor_x_pos <= 44 && cursor_y_pos >= 7 && cursor_y_pos <= 11) begin
                change <= (1 << 2);
            end
            else if (cursor_x_pos >= 11 && cursor_x_pos <= 15 && cursor_y_pos >= 13 && cursor_y_pos <= 24) begin
                change <= (1 << 11);
            end
            else if (cursor_x_pos >= 40 && cursor_x_pos <= 44 && cursor_y_pos >= 13 && cursor_y_pos <= 24) begin
                change <= (1 << 3);
            end
            else if (cursor_x_pos >= 11 && cursor_x_pos <= 15 && cursor_y_pos >= 26 && cursor_y_pos <= 30) begin
                change <= (1 << 10);
            end
            else if (cursor_x_pos >= 17 && cursor_x_pos <= 38 && cursor_y_pos >= 26 && cursor_y_pos <= 30) begin
                change <= (1 << 12);
            end
            else if (cursor_x_pos >= 40 && cursor_x_pos <= 44 && cursor_y_pos >= 26 && cursor_y_pos <= 30) begin
                change <= (1 << 4);
            end  
            else if (cursor_x_pos >= 11 && cursor_x_pos <= 15 && cursor_y_pos >= 32 && cursor_y_pos <= 42) begin
                change <= (1 << 9);
            end
            else if (cursor_x_pos >= 40 && cursor_x_pos <= 44 && cursor_y_pos >= 32 && cursor_y_pos <= 42) begin
                change <= (1 << 5);
            end
            else if (cursor_x_pos >= 11 && cursor_x_pos <= 15 && cursor_y_pos >= 44 && cursor_y_pos <= 48) begin
                change <= (1 << 8);
            end
            else if (cursor_x_pos >= 17 && cursor_x_pos <= 38 && cursor_y_pos >= 44 && cursor_y_pos <= 48) begin
                change <= (1 << 7);
            end
            else if (cursor_x_pos >= 40 && cursor_x_pos <= 44 && cursor_y_pos >= 44 && cursor_y_pos <= 48) begin
                change <= (1 << 6);
            end
            else begin
                change <= 0;
            end         
        end
        else begin
            change <= 0;
        end
    end
endmodule
