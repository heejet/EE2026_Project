`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2023 04:11:19 AM
// Design Name: 
// Module Name: Student_D
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


module Student_D(
    input basys_clock,
    input clk25mhz,
    input sw0, sw1, sw2, sw3, sw15,
    input [12:0] pixel_index,
    input [6:0] cursor_x_pos,
    input [5:0] cursor_y_pos,
    input mouse_left_btn,
    output [15:0] oled_data
);

    wire [15:0] oled_data_IT;

    Oled_Individual_Task IT (
        .clk25mhz(clk25mhz),
        .sw0(sw0),
        .sw1(sw1),
        .sw2(sw2),
        .sw3(sw3),
        .pixel_index(pixel_index),
        .oled_data(oled_data_IT)
    );
    
    wire [15:0] oled_data_P;
    
    Paint P (
        .basys_clock(basys_clock),
        .sw0(sw0),
        .sw1(sw1),
        .clk25mhz(clk25mhz),
        .pixel_index(pixel_index),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .mouse_left_btn(mouse_left_btn),
        .oled_data(oled_data_P)
    );
    
    assign oled_data = (sw15) ? oled_data_P : oled_data_IT;

endmodule
