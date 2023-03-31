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
    input [15:0] sw,
    input [12:0] pixel_index,
    input [6:0] cursor_x_pos,
    input [5:0] cursor_y_pos,
    input mouse_left_btn,
    input mouse_right_btn,
    input mouse_center_btn,
    input btnU,
    input isUsingPaint,
    output [15:0] oled_data
);

    reg toggle = 0;
    
    always @ (posedge basys_clock) begin
        if (btnU) begin
            toggle <= ~toggle;
        end
    end

    wire [15:0] oled_data_IT;

    Oled_Individual_Task IT (
        .clk25mhz(clk25mhz),
        .sw0(sw[0]),
        .sw1(sw[1]),
        .sw2(sw[2]),
        .sw3(sw[3]),
        .pixel_index(pixel_index),
        .oled_data(oled_data_IT)
    );
    
    wire [15:0] oled_data_P;
    
    Paint P (
        .basys_clock(basys_clock),
        .sw(sw),
        .clk25mhz(clk25mhz),
        .pixel_index(pixel_index),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .mouse_left_btn(mouse_left_btn),
        .mouse_right_btn(mouse_right_btn),
        .mouse_center_btn(mouse_center_btn),
        .isUsingPaint(isUsingPaint),
        .oled_data(oled_data_P)
    );
    
    assign oled_data = (toggle) ? oled_data_P : oled_data_IT;

endmodule
