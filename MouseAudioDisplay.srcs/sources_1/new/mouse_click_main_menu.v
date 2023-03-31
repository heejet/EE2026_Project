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
    parameter [31:0] MAIN_MENU = 1;
    parameter [31:0] GROUP_TASK = 2;
    parameter [31:0] INDIVIDUAL_MENU = 3;
    parameter [31:0] INDIVIDUAL_A = 4;
    parameter [31:0] INDIVIDUAL_B = 5;
    parameter [31:0] INDIVIDUAL_C = 6;
    parameter [31:0] INDIVIDUAL_D = 7;
    parameter [31:0] SIU = 8;
    parameter [31:0] GROUP_MENU = 9;
    parameter [31:0] GROUP_MENU2 = 10;
    parameter [31:0] GRAPH_MENU = 11;
    parameter [31:0] DIRECTED_GRAPH = 12;
    parameter [31:0] UNDIRECTED_GRAPH = 13;
    
    always @ (*) begin
        if (mouse_left_btn) begin
            case (current_state)
                MAIN_MENU: begin
                    // Individual
                    if ((cursor_x_pos >= 19 && cursor_x_pos <= 75) && 
                        (cursor_y_pos >= 26 && cursor_y_pos <= 36)) begin
                        change_state <= INDIVIDUAL_MENU;
                    end
                    //  Group
                    else if ((cursor_x_pos >= 19 && cursor_x_pos <= 75) && 
                            (cursor_y_pos >= 41 && cursor_y_pos <= 51)) begin
                        change_state <= GROUP_MENU;
                    end
                    else begin
                        change_state <= current_state;
                    end
                end
                INDIVIDUAL_MENU: begin
                    // A
                    if ((cursor_x_pos >= 9 && cursor_x_pos <= 44) && 
                        (cursor_y_pos >= 20 && cursor_y_pos <= 30)) begin
                        change_state <= INDIVIDUAL_A;
                    end
                    //  B
                    else if ((cursor_x_pos >= 50 && cursor_x_pos <= 85) && 
                            (cursor_y_pos >= 20 && cursor_y_pos <= 30)) begin
                        change_state <= INDIVIDUAL_B;
                    end
                    //  C
                    else if ((cursor_x_pos >= 9 && cursor_x_pos <= 44) && 
                            (cursor_y_pos >= 35 && cursor_y_pos <= 45)) begin
                        change_state <= INDIVIDUAL_C;
                    end
                    //  D
                    else if ((cursor_x_pos >= 50 && cursor_x_pos <= 85) && 
                            (cursor_y_pos >= 35 && cursor_y_pos <= 45)) begin
                        change_state <= INDIVIDUAL_D;
                    end
                    //  Back
                    else if ((cursor_x_pos >= 29 && cursor_x_pos <= 64) && 
                            (cursor_y_pos >= 50 && cursor_y_pos <= 60)) begin
                        change_state <= MAIN_MENU;
                    end
                    else begin
                        change_state <= current_state;
                    end
                end
                GROUP_MENU: begin
                    // integration
                    if ((cursor_x_pos >= 16 && cursor_x_pos <= 78) && 
                        (cursor_y_pos >= 19 && cursor_y_pos <= 29)) begin
                        change_state <= GROUP_TASK;
                    end
                    //  graph algo
                    else if ((cursor_x_pos >= 16 && cursor_x_pos <= 78) && 
                            (cursor_y_pos >= 34 && cursor_y_pos <= 44)) begin
                        change_state <= GRAPH_MENU;
                    end
                    //  back
                    else if ((cursor_x_pos >= 16 && cursor_x_pos <= 44) && 
                            (cursor_y_pos >= 49 && cursor_y_pos <= 59)) begin
                        change_state <= MAIN_MENU;
                    end
                    //  next
                    else if ((cursor_x_pos >= 50 && cursor_x_pos <= 78) && 
                            (cursor_y_pos >= 49 && cursor_y_pos <= 58)) begin
                        change_state <= GROUP_MENU2;
                    end
                    else begin
                        change_state <= current_state;
                    end
                end
                GROUP_MENU2: begin
                    // siumulation
                    if ((cursor_x_pos >= 16 && cursor_x_pos <= 78) && 
                        (cursor_y_pos >= 19 && cursor_y_pos <= 29)) begin
                        change_state <= SIU;
                    end
                    //  back
                    else if ((cursor_x_pos >= 33 && cursor_x_pos <= 62) && 
                            (cursor_y_pos >= 49 && cursor_y_pos <= 59)) begin
                        change_state <= GROUP_MENU;
                    end
                    else begin
                        change_state <= current_state;
                    end
                end
                GRAPH_MENU: begin
                    // directed
                    if ((cursor_x_pos >= 16 && cursor_x_pos <= 78) && 
                        (cursor_y_pos >= 19 && cursor_y_pos <= 29)) begin
                        change_state <= DIRECTED_GRAPH;
                    end
                    //  undirected
                    else if ((cursor_x_pos >= 16 && cursor_x_pos <= 78) && 
                            (cursor_y_pos >= 34 && cursor_y_pos <= 44)) begin
                        change_state <= UNDIRECTED_GRAPH;
                    end
                    //  back
                    else if ((cursor_x_pos >= 33 && cursor_x_pos <= 62) && 
                            (cursor_y_pos >= 49 && cursor_y_pos <= 59)) begin
                        change_state <= GROUP_MENU;
                    end
                    else begin
                        change_state <= current_state;
                    end
                end
                default: begin
                    change_state <= current_state;
                end
            endcase
        end
        else begin
            change_state <= current_state;
        end
    end
endmodule
