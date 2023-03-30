`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2023 05:00:04 AM
// Design Name: 
// Module Name: Student_A
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


module Student_A(
    input basys_clock,
    input [11:0] MIC_in,
    input SW15,
    input [12:0] pixel_index,
    output [3:0] an,
    output [6:0] seg,
    output [15:0] led,
    output [15:0] oled_data
    );
    
    wire [8:0] led_task;
    wire [15:0] led_indiv;
    wire [3:0] an_task;
    wire [3:0] an_indiv;
    wire [6:0] seg_task;
    wire [6:0] seg_indiv;
    
    wire clk25mhz;
    wire clk_sampleinterval; // 20kHz
    clk_divider my_clk25mhz(.basys_clk(basys_clock), .m(1), .new_clk(clk25mhz));
    clk_divider clk_sample_interval(.basys_clk(basys_clock), .m(2499), .new_clk(clk_sampleinterval));
    
    
    Audio_In_Individual_Task IA (
        .MIC_in(MIC_in),
        .basys_clock(basys_clock),
        .an(an_task),
        .led(led_task), 
        .seg(seg_task)
    );
    
    wire [15:0] oled_data_SB;
        
    Sound_Bar SB(    
        .MIC_in(MIC_in),
        .basys_clock(basys_clock),
        .pixel_index(pixel_index),
        .an(an_indiv),
        .led(led_indiv),
        .seg(seg_indiv),
        .oled_data(oled_data_SB)
    );    

    assign led = SW15 ? led_task : led_indiv;
    assign an = SW15 ? an_task : an_indiv;
    assign seg = SW15 ? seg_task : seg_indiv;
    assign oled_data = SW15 ? 0 : oled_data_SB;
    
endmodule
