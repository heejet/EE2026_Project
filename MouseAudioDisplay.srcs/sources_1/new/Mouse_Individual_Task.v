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
    input [10:0] cursor_x_raw,
    input [10:0] cursor_y_raw,
    input [6:0] cursor_x_pos,
    input [5:0] cursor_y_pos,
    input mouse_center_btn,
    input [12:0] pixel_index,
    input sw0,
    output [3:0] an,
    output [7:0] seg,
    output reg [10:0] bound_x,
    output reg [10:0] bound_y,
    output reg [15:0] oled_data
    );
    parameter [6:0] bound_x_normal = 94;
    parameter [6:0] bound_y_normal = 62;
    parameter [31:0] bound_x_slow = 474;
    parameter [31:0] bound_y_slow = 314;
    
    wire [15:0] oled_cursor_1_data, oled_cursor_2_data, oled_cursor_1_slowed_data, oled_cursor_2_slowed_data;
    
    wire [10:0] cursor_x_slow;
    wire [10:0] cursor_y_slow;
    
    reg toggle = 0;
    
    mouse_task cursor_1 (
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .pixel_index(pixel_index),
        .oled_cursor_data(oled_cursor_1_data)
    );
    
    mouse_task cursor_1_slowed (
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_slow),
        .cursor_y_pos(cursor_y_slow),
        .pixel_index(pixel_index),
        .oled_cursor_data(oled_cursor_1_slowed_data)
    );
    
    mouse_task_larger cursor_2 (
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .pixel_index(pixel_index),
        .oled_cursor_data(oled_cursor_2_data)
    );
    
    mouse_task_larger cursor_2_slowed (
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_slow),
        .cursor_y_pos(cursor_y_slow),
        .pixel_index(pixel_index),
        .oled_cursor_data(oled_cursor_2_slowed_data)
    );

    Slowed_Mouse cursor_slow (
        .clock(clk25mhz),
        .cursor_x_in(cursor_x_raw),
        .cursor_y_in(cursor_y_raw),
        .factor(5),
        .cursor_x_out(cursor_x_slow),
        .cursor_y_out(cursor_y_slow)
    );
    
    always @ (posedge basys_clock) begin
        if (mouse_center_btn) begin
            toggle <= toggle + 1;
        end
        if (sw0) begin
            bound_x <= bound_x_slow;
            bound_y <= bound_y_slow;
            oled_data <= (toggle == 0) ?  oled_cursor_1_slowed_data :  oled_cursor_2_slowed_data;
        end
        else begin
            bound_x <= bound_x_normal;
            bound_y <= bound_y_normal;
            oled_data <= (toggle == 0) ?  oled_cursor_1_data :  oled_cursor_2_data;
        end
    end

    assign an = 4'b1111;
    assign seg = 7'b1111_111;
endmodule
