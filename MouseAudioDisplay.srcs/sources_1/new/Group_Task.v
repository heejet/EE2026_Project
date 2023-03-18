`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2023 12:57:54 AM
// Design Name: 
// Module Name: Group_Task
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


module Group_Task(
    input basys_clock, sw0, sw15,
    output [7:0] JC,
    
    input btnC, 
    inout ps2_clk, ps2_data,
    
    output led15,
    
    output [3:0] an,
    output [7:0] seg,
    
    output [3:0] JB
    );
    
//////////////////////////////////////////////////////////////////////////////////

    reg reset_flag = 0;
    
    wire [6:0] cursor_x_pos;
    wire [5:0] cursor_y_pos;
    
    always @ (*) begin
        if (sw15) begin
            reset_flag <= 1;
        end
        else begin
            reset_flag <= 0;
        end
    end

    wire [12:0] curr_display;
    wire [12:0] output_display;
    
    draw_module(
        .basys_clock(basys_clock), 
        .sw0(sw0),
        .sw15(sw15),
        .curr_display(curr_display),
        .output_display(output_display),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos), 
        .JC(JC)
    );

//////////////////////////////////////////////////////////////////////////////////
    
    parameter [6:0] bound_x = 94;
    parameter [6:0] bound_y = 62;
    reg setmax_x = 0;
    reg setmax_y = 1;
    reg [6:0] bound;
    
    wire left, middle, right;
    
    MouseCtl mouse_control(
        .clk(basys_clock), 
        .rst(btnC), 
        .value(bound), 
        .setx(0), 
        .sety(0), 
        .setmax_x(setmax_x), 
        .setmax_y(setmax_y),
        .left(left), 
        .middle(middle),
        .right(right),
        .ps2_clk(ps2_clk), 
        .ps2_data(ps2_data),
        .xpos(cursor_x_pos),
        .ypos(cursor_y_pos)
    );
    
    always @ (posedge basys_clock) begin
        setmax_x <= 1 - setmax_x;
        setmax_y <= 1 - setmax_y;
        if (setmax_x == 1) begin
            bound <= bound_y;
        end
        else if (setmax_y == 1) begin
            bound <= bound_x;
        end
    end

//////////////////////////////////////////////////////////////////////////////////
    
    Mouse_Click MC(
        .basys_clock(basys_clock),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .mouse_left_btn(left),
        .change(output_display)
    );
 
//////////////////////////////////////////////////////////////////////////////////
 
    wire is_valid;
    wire [3:0] digit_type; // 0 - 9 is valid, 10 is invalid
 
    is_valid_digit ivd(
        .basys_clock(basys_clock),
        .curr_display(curr_display),
        .sw15(sw15),
        .is_valid(is_valid),
        .digit_type(digit_type)
    );
    
    assign led15 = (is_valid) ? 1 : 0;
    
//////////////////////////////////////////////////////////////////////////////////

    Seven_segment SS(
        .basys_clock(basys_clock),
        .is_valid(is_valid),
        .digit_type(digit_type),
        .an(an),
        .seg(seg)
    );
    
//////////////////////////////////////////////////////////////////////////////////

    Speaker speaker(
        .basys_clock(basys_clock),
        .J1(JB[1]),
        .J2(JB[2]),
        .J3(JB[3]),
        .J0(JB[0]),
        .is_valid(is_valid),
        .digit_type(digit_type)
    );
 
endmodule
