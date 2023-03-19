`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////

module Top_Student (
    input basys_clock,
    input btnC,
    inout ps2_clk,  
    inout ps2_data,
    input sw0, sw15, sw1,
    output led15,
    output [7:0] JC,
    output reg [3:0] an,
    output reg [7:0] seg,
    output [3:0] JB
    );
    
//////////////////////////////////////////////////////////////////////////////////
// Set up mouse
//////////////////////////////////////////////////////////////////////////////////  
    parameter [6:0] bound_x = 94;
    parameter [6:0] bound_y = 62;
    reg setmax_x = 0;
    reg setmax_y = 1;
    reg [6:0] bound;
    
    wire left, middle, right;
    wire [6:0] cursor_x_pos;
    wire [5:0] cursor_y_pos;
    
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
    wire debounced_left, debounced_center;
    debounce debounce_mouse_left_btn (
        .clock(basys_clock), 
        .input_signal(left), 
        .output_signal(debounced_left)
    );
    debounce debounce_mouse_center_btn (
        .clock(basys_clock), 
        .input_signal(middle), 
        .output_signal(debounced_center)
    );
//////////////////////////////////////////////////////////////////////////////////
// Set up OLED
////////////////////////////////////////////////////////////////////////////////// 
    wire clk25mhz;
    clk_divider my_clk25mhz(.basys_clk(basys_clock), .m(1), .new_clk(clk25mhz));
    
    reg [15:0] oled_data = 0;
    wire frame_begin, sending_pixels, sample_pixel;
    wire [12:0] pixel_index;
    
    Oled_Display oled_unit_one(
        .clk(clk25mhz), 
        .reset(0), 
        .frame_begin(frame_begin), 
        .sending_pixels(sending_pixels), 
        .sample_pixel(sample_pixel), 
        .pixel_index(pixel_index), 
        .pixel_data(oled_data), 
        .cs(JC[0]), 
        .sdin(JC[1]), 
        .sclk(JC[3]), 
        .d_cn(JC[4]), 
        .resn(JC[5]), 
        .vccen(JC[6]),
        .pmoden(JC[7])
    );
//////////////////////////////////////////////////////////////////////////////////
// Student C: Computer Mouse Task
//////////////////////////////////////////////////////////////////////////////////
    wire [15:0] oled_data_IC;
    wire [7:0] seg_IC;
    wire [3:0] an_IC;
    
    Mouse_Individual_Task IC (
        .basys_clock(basys_clock),
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .mouse_center_btn(debounced_center), 
        .pixel_index(pixel_index),
        .an(an_IC),
        .seg(seg_IC),
        .oled_data(oled_data_IC)
    );
//////////////////////////////////////////////////////////////////////////////////
// Group Task
////////////////////////////////////////////////////////////////////////////////// 
    wire [15:0] oled_data_GT;
    wire [7:0] seg_GT;
    wire [3:0] JB_GT, an_GT;
    
    Group_Task GT(
        .basys_clock(basys_clock), 
        .sw0(sw0),
        .sw15(sw15),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .mouse_left_btn(debounced_left), 
        .btnC(btnC),
        .pixel_index(pixel_index),
        .led15(led15),
        .an(an_GT),
        .seg(seg_GT),
        .oled_data(oled_data_GT)
    );
//////////////////////////////////////////////////////////////////////////////////
// Main Menu
//////////////////////////////////////////////////////////////////////////////////    
    wire [15:0] oled_data_MM, oled_data_IM;
    
    display_main_menu MM(
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .pixel_index(pixel_index),
        .oled_data(oled_data_MM)
    );
    
    Display_Individual_Menu IM(
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .pixel_index(pixel_index),
        .oled_data(oled_data_IM)
    );    
//////////////////////////////////////////////////////////////////////////////////
// Control
//////////////////////////////////////////////////////////////////////////////////        
    parameter [31:0] MAIN_MENU = 1;
    parameter [31:0] GROUP_TASK = 2;
    parameter [31:0] INDIVIDUAL_MENU = 3;
    parameter [31:0] INDIVIDUAL_A = 4;
    parameter [31:0] INDIVIDUAL_B = 5;
    parameter [31:0] INDIVIDUAL_C = 6;
    parameter [31:0] INDIVIDUAL_D = 7;
    
    wire [31:0] change_state;
    reg [31:0] current_state = MAIN_MENU;
    
    mouse_click_main_menu MC_MM(
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .mouse_left_btn(debounced_left),
        .current_state(current_state),
        .change_state(change_state)
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
        
        current_state <= change_state;
        
        case (current_state)
            MAIN_MENU: begin
                oled_data <= oled_data_MM;
                an <= 4'b1111;
                seg <= 7'b1111_111;
            end
            INDIVIDUAL_MENU: begin
                oled_data <= oled_data_IM;
                an <= 4'b1111;
                seg <= 7'b1111_111;
            end            
            INDIVIDUAL_C: begin
                oled_data <= oled_data_IC;
                an <= an_IC;
                seg <= seg_IC;
            end
            GROUP_TASK: begin
                oled_data <= oled_data_GT;
                an <= an_GT;
                seg <= seg_GT;
            end
            default: begin
                oled_data <= 0;
            end
        endcase
    end
//////////////////////////////////////////////////////////////////////////////////
endmodule