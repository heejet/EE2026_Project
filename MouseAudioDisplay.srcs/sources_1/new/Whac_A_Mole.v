`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2023 15:47:10
// Design Name: 
// Module Name: Whac_A_Mole
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


module Whac_A_Mole(
    input basys_clock,
    input clk25mhz,
    input mouse_left_button,
    input [6:0] cursor_x_pos,
    input [5:0] cursor_y_pos,
    input [12:0] pixel_index,
    output reg [15:0] oled_data
    );
    
    parameter [2:0] NONE = 0;
    parameter [2:0] LEFT = 1;
    parameter [2:0] RIGHT = 2;
    parameter [2:0] COOLDOWN = 3;
    
    wire [15:0] none_oled_data, left_oled_data, right_oled_data, both_oled_data;
    Display_None none (.clk25mhz(clk25mhz), .cursor_x_pos(cursor_x_pos), .cursor_y_pos(cursor_y_pos), .pixel_index(pixel_index), .oled_data(none_oled_data));
    Display_Left left (.clk25mhz(clk25mhz), .cursor_x_pos(cursor_x_pos), .cursor_y_pos(cursor_y_pos), .pixel_index(pixel_index), .oled_data(left_oled_data));
    Display_Right right (.clk25mhz(clk25mhz), .cursor_x_pos(cursor_x_pos), .cursor_y_pos(cursor_y_pos), .pixel_index(pixel_index), .oled_data(right_oled_data));
        
    reg [2:0] current_state = NONE;
    wire [2:0] next_state;
    
    Whac_A_Mole_Mouse whac_a_mole_mouse (
        .basys_clock(basys_clock),
        .mouse_left_button(mouse_left_button),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .pixel_index(pixel_index),
        .current_state(current_state),
        .next_state(next_state)
    );
  
    always @ (posedge basys_clock) begin
        current_state <= next_state;
        case (current_state)
            LEFT: begin
                oled_data <= left_oled_data;
            end
            RIGHT: begin
                oled_data <= right_oled_data;
            end
            NONE: begin
                oled_data <= none_oled_data;
            end
            default: begin
                oled_data <= 0;
            end
        endcase
    end    
endmodule
