module Top_Student ( 
    input clock,
    input J_MIC3_Pin3, 
    output J_MIC3_Pin1,
    output J_MIC3_Pin4,
    output J0, J1, J2, J3,
    output [3:0] an,
    output [15:0] led,
    output [6:0] seg,
    output [7:0] JC
    );
   
    wire clk25mhz;
    clk_divider my_clk25mhz(.basys_clk(clock), .m(1), .my_clk(clk25mhz));
    
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
    
    wire [15:0] oled_data_sb;

    Sound_Bar sb(    
    .clock(clock),
    .J_MIC3_Pin3(J_MIC3_Pin3), 
    .pixel_index(pixel_index),
    .J_MIC3_Pin1(J_MIC3_Pin1),
    .J_MIC3_Pin4(J_MIC3_Pin4),
    .J0(J0),.J1(J1),.J2(J2),.J3(J3),
    .an(an),
    .led(led),
    .seg(seg),
    .oled_data(oled_data_sb));
    
    always @ (posedge clock) begin
        oled_data <= oled_data_sb;
    end    

endmodule