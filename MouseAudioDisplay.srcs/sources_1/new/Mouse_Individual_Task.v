`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2023 16:45:20
// Design Name: 
// Module Name: Mouse_Individual_Task
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


module Mouse_Individual_Task(
    input basys_clock,
    input clk25mhz,
    input [6:0] cursor_x_pos,
    input [5:0] cursor_y_pos,
    input mouse_center_btn,
    input [12:0] pixel_index,
    output [3:0] an,
    output [7:0] seg,
    output reg [15:0] oled_data
    );
    wire [15:0] oled_cursor_1_data, oled_cursor_2_data;
    
    reg toggle = 0;
    
    mouse_task cursor_1 (
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .pixel_index(pixel_index),
        .oled_cursor_data(oled_cursor_1_data)
    );
    
    mouse_task_larger cursor_2 (
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .pixel_index(pixel_index),
        .oled_cursor_data(oled_cursor_2_data)
    );
    
    always @ (posedge basys_clock) begin
        if (mouse_center_btn) begin
            toggle <= toggle + 1;
        end
        oled_data <= (toggle == 0) ?  oled_cursor_1_data :  oled_cursor_2_data;
    end

    assign an = 4'b1111;
    assign seg = 7'b1111_111;
endmodule
