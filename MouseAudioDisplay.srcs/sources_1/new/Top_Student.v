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
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    inout ps2_clk,  
    inout ps2_data,
    input [15:0] sw,
    output [7:0] JC,
    output [7:0] JA,
    output reg [3:0] an,
    output reg [7:0] seg,
    output [3:0] JXADC,
    input J_MIC3_Pin3, 
    output J_MIC3_Pin1,
    output J_MIC3_Pin4,
    output reg [15:0] led
    );
    
//////////////////////////////////////////////////////////////////////////////////
// Set up L, R, U, D buttons
//////////////////////////////////////////////////////////////////////////////////  

    wire debounced_btnL, debounced_btnR, debounced_btnU, debounced_btnD;
    debounce debounceL (.clock(basys_clock), .input_signal(btnL), .output_signal(debounced_btnL));
    debounce debounceR (.clock(basys_clock), .input_signal(btnR), .output_signal(debounced_btnR));
    debounce debounceU (.clock(basys_clock), .input_signal(btnU), .output_signal(debounced_btnU));
    debounce debounceD (.clock(basys_clock), .input_signal(btnD), .output_signal(debounced_btnD));
    
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
//    wire [7:0] seg_IA;
//    wire [3:0] an_IA;
//    wire [8:0] led_IA;
    
//    Audio_In_Individual_Task IA (
//        .MIC_in(MIC_in),
//        .basys_clock(clk_sampleinterval),
//        .J_MIC3_Pin3(J_MIC3_Pin3),
//        .an(an_IA),
//        .led(led_IA),
//        .seg(seg_IA)
//    );

    wire [3:0] an_IA;
    wire [6:0] seg_IA;
    wire [15:0] led_IA;
    wire [15:0] oled_data_IA;

Student_A IA(
    .basys_clock(basys_clock),
    .MIC_in(MIC_in),
    .SW15(sw[15]),
    .pixel_index(pixel_index_1),
    .an(an_IA),
    .seg(seg_IA),
    .led(led_IA),
    .oled_data(oled_data_IA)
    );
    
//////////////////////////////////////////////////////////////////////////////////
// Student B: Audio Output Task
//////////////////////////////////////////////////////////////////////////////////
    wire [11:0] audio_out_IB;
    
    Audio_Out_Individual_Task IB (
        .basys_clock(basys_clock),
        .sw0(sw[0]),
        .btnC(btnC),
        .audio_out_final(audio_out_IB)
    );
//////////////////////////////////////////////////////////////////////////////////
// Student C: Computer Mouse Task
//////////////////////////////////////////////////////////////////////////////////
    wire [15:0] oled_data_IC;
    wire [7:0] seg_IC;
    wire [3:0] an_IC;
    
    wire [10:0] bound_x_IC;
    wire [10:0] bound_y_IC;
    
    Mouse_Individual_Task IC (
        .basys_clock(basys_clock),
        .clk25mhz(clk25mhz),
        .cursor_x_raw(cursor_x_raw),
        .cursor_y_raw(cursor_y_raw),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .mouse_left_btn(debounced_left), 
        .mouse_center_btn(debounced_center), 
        .pixel_index(pixel_index_1),
        .sw0(sw[0]),
        .sw1(sw[1]),
        .an(an_IC),
        .seg(seg_IC),
        .bound_x(bound_x_IC),
        .bound_y(bound_y_IC),
        .oled_data(oled_data_IC)
    );
//////////////////////////////////////////////////////////////////////////////////
// Student D: Display Task
//////////////////////////////////////////////////////////////////////////////////
    wire [15:0] oled_data_ID;
    
    Oled_Individual_Task ID (
        .clk25mhz(clk25mhz),
        .sw0(sw[0]),
        .sw1(sw[1]),
        .sw2(sw[2]),
        .sw3(sw[3]),
        .pixel_index(pixel_index_1),
        .oled_data(oled_data_ID)
    );
//////////////////////////////////////////////////////////////////////////////////
// Group Task
////////////////////////////////////////////////////////////////////////////////// 
    wire [15:0] oled_data_GT;
    wire [7:0] seg_GT;
    wire [3:0] an_GT;
    wire [11:0] audio_out_GT;
    wire led15_GT;
    
    Group_Task GT(
        .basys_clock(basys_clock), 
        .sw0(sw[0]),
        .sw15(sw[15]),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .mouse_left_btn(debounced_left), 
        .btnC(btnC),
        .pixel_index(pixel_index_1),
        .led15(led15_GT),
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
        .reset_btn(debounced_btnU),
        .pixel_index(pixel_index_1),
        .an(an_SIU),
        .seg(seg_SIU),
        .oled_data(oled_data_SIU)
    );
//////////////////////////////////////////////////////////////////////////////////
// Graph Algos
//////////////////////////////////////////////////////////////////////////////////    
    wire [6:0] directed_seg, undirected_seg;
    wire [3:0] directed_an, undirected_an;
    wire directed_is_cyclic;
    wire directed_is_connected;
    wire directed_is_tree;
    
    Directed show_directed_graph(
        .basys_clock(basys_clock),
        .sw(sw),
        .btnU(debounced_btnU),
        .btnD(debounced_btnD),
        .btnL(debounced_btnL),
        .btnR(debounced_btnR),
        .seg(directed_seg),
        .an(directed_an),
        .is_cyclic(directed_is_cyclic),
        .is_connected(directed_is_connected),
        .is_tree(directed_is_tree)
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
// Library Simulator
//////////////////////////////////////////////////////////////////////////////////
    
//    wire [15:0] led_indiv;
//    wire [3:0] an_indiv;
//    wire [6:0] seg_indiv;
//    wire [15:0] oled_data_sb;
    
//    Sound_Bar SB(    
//        .MIC_in(MIC_in),
//        .basys_clock(basys_clock),
//        .J_MIC3_Pin3(J_MIC3_Pin3), 
//        .pixel_index(pixel_index_1),
//        .an(an_indiv),
//        .led(led_indiv),
//        .seg(seg_indiv),
//        .oled_data(oled_data_sb)
//    );    
    

//////////////////////////////////////////////////////////////////////////////////
// Main Menu
//////////////////////////////////////////////////////////////////////////////////    
    wire [15:0] oled_data_MM, oled_data_IM, oled_data_GM, oled_data_GM2, oled_data_GRAPH;
    
    display_main_menu MM(
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .pixel_index(pixel_index_1),
        .oled_data(oled_data_MM)
    );
    
    Display_Individual_Menu IM(
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .pixel_index(pixel_index_1),
        .oled_data(oled_data_IM)
    );
    Display_Group_Menu GM(
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .pixel_index(pixel_index_1),
        .oled_data(oled_data_GM)
    );
    Display_Group_Menu2 GM2(
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .pixel_index(pixel_index_1),
        .oled_data(oled_data_GM2)
    );
    Display_Graph_Menu GRAPH(
        .clk25mhz(clk25mhz),
        .cursor_x_pos(cursor_x_pos),
        .cursor_y_pos(cursor_y_pos),
        .pixel_index(pixel_index_1),
        .oled_data(oled_data_GRAPH)
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
    parameter [31:0] GROUP_MENU = 9;
    parameter [31:0] GROUP_MENU2 = 10;
    parameter [31:0] GRAPH_MENU = 11;
    parameter [31:0] DIRECTED_GRAPH = 12;
    parameter [31:0] UNDIRECTED_GRAPH = 13;
    
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
            bound <= (current_state == INDIVIDUAL_C) ? bound_y_IC : bound_y;
        end
        else if (setmax_y == 1) begin
            bound <= (current_state == INDIVIDUAL_C) ? bound_x_IC : bound_x;
        end
        
        current_state <= change_state;
        
        case (current_state)
            MAIN_MENU: begin
                oled_data_1 <= oled_data_MM;
                an <= 4'b1111;
                seg <= 7'b1111_111;
            end
            INDIVIDUAL_MENU: begin
                oled_data_1 <= oled_data_IM;
                an <= 4'b1111;
                seg <= 7'b1111_111;
            end
            INDIVIDUAL_A: begin
                oled_data_1 <= oled_data_IA;
                led <= led_IA;
                an <= an_IA;
                seg <= seg_IA;
                current_state <= (debounced_btnD) ? INDIVIDUAL_MENU : INDIVIDUAL_A;
            end
            INDIVIDUAL_B: begin
                oled_data_1 <= 0;
                audio_out <= audio_out_IB;
                current_state <= (debounced_btnD) ? INDIVIDUAL_MENU : INDIVIDUAL_B;
            end
            INDIVIDUAL_C: begin
                oled_data_1 <= oled_data_IC;
                an <= an_IC;
                seg <= seg_IC;
                current_state <= (debounced_btnD) ? INDIVIDUAL_MENU : INDIVIDUAL_C;
            end
            INDIVIDUAL_D: begin
                oled_data_1 <= oled_data_ID;
                current_state <= (debounced_btnD) ? INDIVIDUAL_MENU : INDIVIDUAL_D;
            end
            GROUP_TASK: begin
                oled_data_1 <= oled_data_GT;
                an <= an_GT;
                seg <= seg_GT;
                led[15] <= led15_GT;
                audio_out <= audio_out_GT;
                current_state <= (debounced_btnD) ? GROUP_MENU : GROUP_TASK;
            end
            SIU: begin
                oled_data_1 <= oled_data_SIU;
                an <= an_SIU;
                seg <= seg_SIU;
                current_state <= (debounced_btnD) ? GROUP_MENU2 : SIU;
            end
            GROUP_MENU: begin
                oled_data_1 <= oled_data_GM;
            end
            GROUP_MENU2: begin
                oled_data_1 <= oled_data_GM2;
            end
            GRAPH_MENU: begin
                oled_data_1 <= oled_data_GRAPH;
            end
            DIRECTED_GRAPH: begin
                oled_data_1 <= 0;
                an <= directed_an;
                seg [6:0] <= directed_seg;
                seg[7] <= 1;
                led[15] <= directed_is_cyclic;
                led[14] <= directed_is_connected;
                led[13] <= directed_is_tree;
                current_state <= (btnC) ? GRAPH_MENU : DIRECTED_GRAPH;
            end
            UNDIRECTED_GRAPH: begin
                oled_data_1 <= oled_data_UG_1;
                oled_data_2 <= oled_data_UG_2;
                an <= undirected_an;
                seg [6:0] <= undirected_seg;
                seg[7] <= 1;
                current_state <= (btnC) ? GRAPH_MENU : UNDIRECTED_GRAPH;
            end
            default: begin
                oled_data_1 <= 0;
                oled_data_2 <= 0;
            end
        endcase
    end
//////////////////////////////////////////////////////////////////////////////////
endmodule