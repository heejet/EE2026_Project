module Top_Student ( 
    input clock,
    input J_MIC3_Pin3, 
    input SW15,
    output J_MIC3_Pin1,
    output J_MIC3_Pin4,
    output [3:0] an,
    output [15:0] led,
    output [6:0] seg,
    output [7:0] JC
    );
   
   // CLOCKS
    wire clk25mhz;
    wire clk_sampleinterval; // 20kHz
    clk_divider my_clk25mhz(.basys_clk(clock), .m(1), .my_clk(clk25mhz));
    clk_divider clk_sample_interval(clock, 2499, clk_sampleinterval);
    
    // OLED
    reg [15:0] oled_data = 0;
    wire frame_begin, sending_pixels, sample_pixel;
    wire [12:0] pixel_index;
    
    wire [8:0] led_task;
    wire [15:0] led_indiv;
    wire [3:0] an_task;
    wire [3:0] an_indiv;
    wire [6:0] seg_task;
    wire [6:0] seg_indiv;
    wire pin1_task; 
    wire pin1_indiv;
    wire pin4_task;
    wire pin4_indiv;
    
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

    Sound_Bar SB(    
        .clock(clock),
        .J_MIC3_Pin3(J_MIC3_Pin3), 
        .pixel_index(pixel_index),
        .J_MIC3_Pin1(pin1_indiv),
        .J_MIC3_Pin4(pin4_indiv),
        .an(an_indiv),
        .led(led_indiv),
        .seg(seg_indiv),
        .oled_data(oled_data_sb)
    );
    
    Student_A_Task SAT(
        .clock(clock),
        .J_MIC3_Pin3(J_MIC3_Pin3), 
        .J_MIC3_Pin1(pin1_task),
        .J_MIC3_Pin4(pin4_task),
        .an(an_task),
        .led(led_task),
        .seg(seg_task)
    ); 
    
    always @ (posedge clock) begin
        if (SW15 == 0) oled_data <= oled_data_sb;
    end    
    
    assign J_MIC3_Pin1 = SW15 ? pin1_task : pin1_indiv;
    assign J_MIC3_Pin4 = SW15 ? pin4_task : pin4_indiv;
    assign led = SW15 ? led_task : led_indiv;
    assign an = SW15 ? an_task : an_indiv;
    assign seg = SW15 ? seg_task : seg_indiv;

endmodule