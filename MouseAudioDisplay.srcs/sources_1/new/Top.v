`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2023 04:33:35 PM
// Design Name: 
// Module Name: Top
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


module Top(
input basys_clock,
input [15:0] sw,
input btnC, btnU, btnD, btnL, btnR,
inout ps2_clk,  
inout ps2_data,
output reg [3:0] an,
output reg [7:0] seg,
output [7:0] JC,
output [7:0] JA,
output reg [7:0] led
);

//////////////////////////////////////////////////////////////////////////////////
// Set up OLED 1
////////////////////////////////////////////////////////////////////////////////// 
    wire clk25mhz;
    clk_divider my_clk25mhz(.basys_clk(basys_clock), .m(1), .new_clk(clk25mhz));
    
    reg [15:0] oled_data_1 = 0;
    wire frame_begin_1, sending_pixels_1, sample_pixel_1;
    wire [12:0] pixel_index_1;
    
    Oled_Display oled_unit_one(
        .clk(clk25mhz), 
        .reset(0), 
        .frame_begin(frame_begin_1), 
        .sending_pixels(sending_pixels_1), 
        .sample_pixel(sample_pixel_1), 
        .pixel_index(pixel_index_1), 
        .pixel_data(oled_data_1), 
        .cs(JC[0]), 
        .sdin(JC[1]), 
        .sclk(JC[3]), 
        .d_cn(JC[4]), 
        .resn(JC[5]), 
        .vccen(JC[6]),
        .pmoden(JC[7])
    );
//////////////////////////////////////////////////////////////////////////////////
// Set up OLED 2
//////////////////////////////////////////////////////////////////////////////////         
        reg [15:0] oled_data_2 = 0;
        wire frame_begin_2, sending_pixels_2, sample_pixel_2;
        wire [12:0] pixel_index_2;
        
        Oled_Display oled_unit_two(
            .clk(clk25mhz), 
            .reset(0), 
            .frame_begin(frame_begin_2), 
            .sending_pixels(sending_pixels_2), 
            .sample_pixel(sample_pixel_2), 
            .pixel_index(pixel_index_2), 
            .pixel_data(oled_data_2), 
            .cs(JA[0]), 
            .sdin(JA[1]), 
            .sclk(JA[3]), 
            .d_cn(JA[4]), 
            .resn(JA[5]), 
            .vccen(JA[6]),
            .pmoden(JA[7])
        );
//////////////////////////////////////////////////////////////////////////////////
// Set up mouse
//////////////////////////////////////////////////////////////////////////////////  
        parameter [6:0] bound_x = 94;
        parameter [6:0] bound_y = 62;
    
        reg setmax_x = 0;
        reg setmax_y = 1;
        reg [10:0] bound;
        
        wire left, middle, right;
        
        wire [10:0] cursor_x_raw;
        wire [10:0] cursor_y_raw;
        
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
            .xpos(cursor_x_raw),
            .ypos(cursor_y_raw)
        );
        
        assign cursor_x_pos = cursor_x_raw;
        assign cursor_y_pos = cursor_y_raw;
        
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
// Paint
////////////////////////////////////////////////////////////////////////////////// 

//    wire [15:0] oled_data_P;

//    Paint P (
//        .basys_clock(basys_clock),
//        .sw0(sw[0]),
//        .sw1(sw[1]),
//        .clk25mhz(clk25mhz),
//        .pixel_index(pixel_index),
//        .cursor_x_pos(cursor_x_pos),
//        .cursor_y_pos(cursor_y_pos),
//        .mouse_left_btn(left),
//        .oled_data(oled_data_P)
//    );

//////////////////////////////////////////////////////////////////////////////////
// Case rom example
////////////////////////////////////////////////////////////////////////////////// 

//    wire [15:0] oled_data_CE;
  
//    case_example CE (
//        .CLOCK(basys_clock),
//        .address(pixel_index),
//        .data_out(oled_data_CE)
//    );

//////////////////////////////////////////////////////////////////////////////////
// Siu-Meter
////////////////////////////////////////////////////////////////////////////////// 
//    wire [15:0] oled_data_SM;
//    wire [3:0] an_SM;
//    wire [7:0] seg_SM;

//    Siu_Meter SM (
//    .basys_clock(basys_clock),
//    .cursor_x_pos(cursor_x_pos),
//    .cursor_y_pos(cursor_y_pos),
//    .mouse_left_btn(debounced_left),
//    .btnC(btnD),
//    .pixel_index(pixel_index),
//    .an(an_SM),
//    .seg(seg_SM),
//    .oled_data(oled_data_SM)
//    );
 
//////////////////////////////////////////////////////////////////////////////////
// Graphs
//////////////////////////////////////////////////////////////////////////////////
    wire debounced_btnL, debounced_btnR, debounced_btnU, debounced_btnD;
    debounce debounceL (.clock(basys_clock), .input_signal(btnL), .output_signal(debounced_btnL));
    debounce debounceR (.clock(basys_clock), .input_signal(btnR), .output_signal(debounced_btnR));
    debounce debounceU (.clock(basys_clock), .input_signal(btnU), .output_signal(debounced_btnU));
    debounce debounceD (.clock(basys_clock), .input_signal(btnD), .output_signal(debounced_btnD));

    wire [6:0] directed_seg, undirected_seg;
    wire [3:0] directed_an, undirected_an;
    wire directed_is_cyclic;
    
    wire [15:0] oled_data_DG;

    Directed show_directed_graph(
        .basys_clock(basys_clock),
        .sw(sw),
        .btnU(debounced_btnU),
        .btnD(debounced_btnD),
        .btnL(debounced_btnL),
        .btnR(debounced_btnR),
        .pixel_index(pixel_index_1),
        .seg(directed_seg),
        .an(directed_an),
        .oled_data_1(oled_data_DG),
        .is_cyclic(directed_is_cyclic)
    );
    
    wire [15:0] oled_data_UG_1, oled_data_UG_2;

    Undirected show_undirected_graph(
        .basys_clock(basys_clock),
        .sw(sw),
        .btnU(debounced_btnU),
        .btnD(debounced_btnD),
        .btnL(debounced_btnL),
        .btnR(debounced_btnR),
        .pixel_index_1(pixel_index_1),
        .pixel_index_2(pixel_index_2),
        .seg(undirected_seg),
        .an(undirected_an),
        .oled_data_1(oled_data_UG_1),
        .oled_data_2(oled_data_UG_2)
    );
 
////////////////////////////////////////////////////////////////////////////////// 

    always @ (posedge basys_clock) begin
        setmax_x <= 1 - setmax_x;
        setmax_y <= 1 - setmax_y;
        
        if (setmax_x == 1) begin
            bound <= bound_y;
        end
        else if (setmax_y == 1) begin
            bound <= bound_x;
        end
        
        an <= directed_an;
        seg <= directed_seg;
        oled_data_1 <= oled_data_UG_1;
        oled_data_2 <= oled_data_UG_2;
    end

////////////////////////////////////////////////////////////////////////////////// 


endmodule
