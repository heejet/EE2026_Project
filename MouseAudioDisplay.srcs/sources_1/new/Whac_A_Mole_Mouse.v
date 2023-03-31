`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2023 10:24:10
// Design Name: 
// Module Name: Whac_A_Mole_Mouse
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


module Whac_A_Mole_Mouse(
    input basys_clock,
    input mouse_left_button,
    input [6:0] cursor_x_pos,
    input [5:0] cursor_y_pos,
    input [12:0] pixel_index,
    input [2:0] current_state,
    output reg [2:0] next_state
    );
    parameter [2:0] NONE = 0;
    parameter [2:0] LEFT = 1;
    parameter [2:0] RIGHT = 2;
    parameter [2:0] COOLDOWN = 3;
    
    reg [31:0] count = 0;
    reg [31:0] count_cooldown = 0;
    
    wire [3:0] random_unbounded;
    Random_Number_Generator(.clock(basys_clock), .random_number(random_unbounded));
    
    reg [2:0] generated_state;
    
    always @ (posedge basys_clock) begin
        generated_state <= random_unbounded % 3;
        case (current_state)
            LEFT: begin
                count_cooldown <= 0;
                count <= (count == 9999_9999) ? 0 : count + 1;
                if (count == 9999_9998) begin
                    next_state <= NONE;
                end
                if (mouse_left_button && cursor_x_pos >= 18 && cursor_x_pos <= 37 && cursor_y_pos >= 22 && cursor_y_pos <= 40) begin
                    next_state <= NONE;
                end
            end
            RIGHT: begin
                count_cooldown <= 0;
                count <= (count == 9999_9999) ? 0 : count + 1;
                if (count == 9999_9998) begin
                    next_state <= NONE;
                end
                if (mouse_left_button && cursor_x_pos >= 58 && cursor_x_pos <= 77 && cursor_y_pos >= 22 && cursor_y_pos <= 40) begin
                    next_state <= NONE;
                end
            end
            NONE: begin
                count_cooldown <= 0;
                count <= (count == 9999_9999) ? 0 : count + 1;
                if (count == 9999_9999) begin
                    next_state <= COOLDOWN;
                end
            end
            default: begin 
               next_state <= generated_state;
           end
        endcase
    end
endmodule
