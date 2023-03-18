`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2023 20:10:04
// Design Name: 
// Module Name: mouse_click_main_menu
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


module mouse_click_main_menu(
    input [6:0] cursor_x_pos,
    input [5:0] cursor_y_pos,
    input mouse_left_btn,
    input [31:0] current_state,
    output reg [31:0] change_state
    );
    always @ (*) begin
        if (mouse_left_btn) begin
            if ((cursor_x_pos >= 19 && cursor_x_pos <= 75) && 
                (cursor_y_pos >= 26 && cursor_y_pos <= 36)) begin
                change_state <= current_state;
            end
            else if ((cursor_x_pos >= 19 && cursor_x_pos <= 75) && 
                    (cursor_y_pos >= 41 && cursor_y_pos <= 51)) begin
                change_state <= 2;
            end
            else begin
                change_state <= current_state;
            end
        end
        else begin
            change_state <= current_state;
        end
    end
endmodule
