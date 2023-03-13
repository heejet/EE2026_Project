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
    input btn_C,
    inout ps2_clk,  
    inout ps2_data,
    input sw4,
    output [7:0] JC,
    output reg [15:13] led
    );
    // Mouse Test 
    wire left, middle, right;

    MouseCtl mouse_test(
        .clk(basys_clock), .rst(btn_C), .value(0), .setx(0), 
        .sety(0), .setmax_x(0), .setmax_y(0),
        .left(left), .middle(middle), .right(right),
        .ps2_clk(ps2_clk), .ps2_data(ps2_data)
    );
    
    always @ (posedge basys_clock) begin
        led[15] <= left;
        led[14] <= middle;
        led[13] <= right;
    end

    // Display Test

    reg [15:0] oled_data = (sw4) ? 16'hF800 : 16'h07E0;
    wire frame_begin, sending_pixels, sample_pixel;
    wire [12:0] pixel_index;
    
    wire clk6p25m;
    clk_divider my_clk6p25m(.basys_clk(basys_clock), .m(7), .new_clk(clk6p25m));
    
    Oled_Display oled_unit_one(
        .clk(clk6p25m), 
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
endmodule