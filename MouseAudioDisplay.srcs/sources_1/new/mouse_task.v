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
    input basys_clk,
    input btn_c
    );

    wire [9:0] x_pos, y_pos;
    wire left_btn, right_btn, middle_btn;

    MouseCtl mouse_control(
        .clk(basys_clock),
        .rst(btn_C),
        .value(0),
        .setx(0), 
        .sety(0),
        .setmax_x(0),
        .setmax_y(0),
        .left(left_btn), 
        .middle(middle_btn),
        .right(right_btn),
        .xpos(x_pos),
        .ypos(y_pos),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data)
    );

endmodule
