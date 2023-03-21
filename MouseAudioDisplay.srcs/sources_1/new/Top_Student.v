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
    // Delete this comment and include Basys3 inputs and outputs here
    input basys_clock,
    input btnC,
    inout ps2_clk,  
    inout ps2_data,
    input sw0, sw15, sw1, sw2, sw3,
    output led15,
    output [7:0] JC,
    output reg [3:0] an,
    output reg [7:0] seg,
    output [3:0] JXADC,
    input J_MIC3_Pin3, 
    output J_MIC3_Pin1,
    output J_MIC3_Pin4,
    output reg [7:0] led
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
// Set up Audio Output
//////////////////////////////////////////////////////////////////////////////////
    wire clock_50MHz, clock_20kHz, clock_190Hz, clock_380Hz, clock_25MHz;
    
    clk_divider clk_50MHz(.basys_clk(basys_clock), .m(0), .new_clk(clock_50MHz));
    clk_divider clk_20kHz(.basys_clk(basys_clock), .m(2499), .new_clk(clock_20kHz));
    
    reg [11:0] audio_out = 0;
    
    Audio_Output unit_my_audio_output (
        .CLK(clock_50MHz),  
        .START(clock_20kHz),
        .DATA1(audio_out),
        .DATA2(),
        .RST(0),
    
        .D1(JXADC[1]),
        .D2(JXADC[2]),
        .CLK_OUT(JXADC[3]),
        .nSYNC(JXADC[0]),
        .DONE()
    );
//////////////////////////////////////////////////////////////////////////////////
// Set up Audio Input
//////////////////////////////////////////////////////////////////////////////////
    wire clk_sampleinterval; // f = 20kHz (sample interval for highest value in sampleframe)
    wire [11:0] MIC_in;

    clk_divider clk_sample_interval(basys_clock, 2499, clk_sampleinterval);
    
    Audio_Input audio_input(
        .CLK(basys_clock),
        .cs(clk_sampleinterval),
        .MISO(J_MIC3_Pin3),
        .clk_samp(J_MIC3_Pin1),
        .sclk(J_MIC3_Pin4),
        .sample(MIC_in)
    );
//////////////////////////////////////////////////////////////////////////////////
// Student A: Audio Input Task
//////////////////////////////////////////////////////////////////////////////////
    reg [11:0] MIC_in_IA = 0;
    wire [7:0] seg_IA;
    wire [3:0] an_IA;
    wire [8:0] led_IA;
    
    Audio_In_Individual_Task IA (
        .clk_sampleinterval(clk_sampleinterval),
        .MIC_in(MIC_in),
        .an(an_IA),
        .seg(seg_IA),
        .led(led_IA)
    );
//////////////////////////////////////////////////////////////////////////////////
// Student B: Audio Output Task
//////////////////////////////////////////////////////////////////////////////////
    wire [11:0] audio_out_IB;
    
    Audio_Out_Individual_Task IB (
        .basys_clock(basys_clock),
        .sw0(sw0),
        .btnC(btnC),
        .audio_out_final(audio_out_IB)
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
// Student D: Display Task
//////////////////////////////////////////////////////////////////////////////////
    wire [15:0] oled_data_ID;
    
    Oled_Individual_Task ID (
        .clk25mhz(clk25mhz),
        .sw0(sw0),
        .sw1(sw1),
        .sw2(sw2),
        .sw3(sw3),
        .pixel_index(pixel_index),
        .oled_data(oled_data_ID)
    );
//////////////////////////////////////////////////////////////////////////////////
// Group Task
////////////////////////////////////////////////////////////////////////////////// 
    wire [15:0] oled_data_GT;
    wire [7:0] seg_GT;
    wire [3:0] an_GT;
    wire [11:0] audio_out_GT;
    
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
        .oled_data(oled_data_GT),
        .audio_out(audio_out_GT)
    );
//////////////////////////////////////////////////////////////////////////////////
// Siuuumulator
////////////////////////////////////////////////////////////////////////////////// 
    wire [7:0] seg_SIU;
    wire [3:0] an_SIU;
    wire [15:0] oled_data_SIU;
    
    Siu_Meter(
        .basys_clock(basys_clock),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .mouse_left_btn(debounced_left),
        .pixel_index(pixel_index),
        .an(an_SIU),
        .seg(seg_SIU),
        .oled_data(oled_data_SIU)
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
    parameter [31:0] SIU = 8;
    
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
        
        if (sw0) begin
            current_state <= SIU;
        end
        else begin
            current_state <= change_state;
        end
        
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
            INDIVIDUAL_A: begin
                oled_data <= 0;
                MIC_in_IA <= MIC_in;
                an <= an_IA;
                seg <= seg_IA;
                led[7:0] <= led_IA;
            end
            INDIVIDUAL_B: begin
                oled_data <= 0;
                audio_out <= audio_out_IB;
            end
            INDIVIDUAL_C: begin
                oled_data <= oled_data_IC;
                an <= an_IC;
                seg <= seg_IC;
            end
            INDIVIDUAL_D: begin
                oled_data <= oled_data_ID;
            end
            GROUP_TASK: begin
                oled_data <= oled_data_GT;
                an <= an_GT;
                seg <= seg_GT;
                audio_out <= audio_out_GT;
            end
            SIU: begin
                oled_data <= 0;
                an <= an_SIU;
                seg <= seg_SIU;
                oled_data <= oled_data_SIU;
            end
            default: begin
                oled_data <= 0;
            end
        endcase
    end
//////////////////////////////////////////////////////////////////////////////////
endmodule