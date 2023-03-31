`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2023 03:54:11 AM
// Design Name: 
// Module Name: Audio_Out_Individual_Task
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


module Audio_Out_Individual_Task(
    input basys_clock,
    input [15:0] sw,
    output [15:0] led
    ,input btnC
    ,input btnU
    ,input btnD
    ,output [3:0] an
    ,output [7:0] seg
    ,input btnL
    ,output [11:0] audio_out
    
);


    wire clock_50MHz;
    wire clock_20kHz;
    wire clock_190Hz;
    wire clock_380Hz;
    wire clock_25MHz;

    clk_divider clk_50MHz(basys_clock, 0, clock_50MHz);
    clk_divider clk_20kHz(basys_clock, 2499, clock_20kHz);
    clk_divider clk_190Hz(basys_clock, 263156, clock_190Hz);
    clk_divider clk_380Hz(basys_clock, 131577, clock_380Hz);
    clk_divider clk_25MHz(basys_clock, 1, clock_25MHz);
    
    
    wire [11:0] audio_out_task_normal;
    wire [3:0] an_piano;
    wire [7:0] seg_piano;
    wire [11:0] audio_out_piano;
    wire [15:0] led_piano;
    Audio_out_main_task task_normal(basys_clock, sw[0], btnC, audio_out_task_normal);
    Audio_out_improvement task_piano(sw, basys_clock, led_piano, btnC, btnU, btnD, an_piano, seg_piano, audio_out_piano);
    
    
        //btnL debouncer code
    reg [31:0] count_debouncer = 0;
    reg stable_flag = 0;
    reg temp_btnL = 1; 
    reg temp_booting_flag = 0;
    reg assign_to_p_btnL_flag = 0;
    reg p_btnL = 0;

    

    always @ (posedge clock_25MHz) begin
    
        if (stable_flag == 1) begin
        
            if (btnL == 1 && assign_to_p_btnL_flag == 0) begin
                stable_flag <= 0;
                count_debouncer <= 0;
                temp_btnL <= 0; //shows that it is not yet fully pressed
            end 
            
            else if (btnL == 0 && assign_to_p_btnL_flag == 0) begin
                stable_flag <= 0;
                count_debouncer <= 0;
                temp_btnL <= 1; //shows that it is not yet fully released
            end
            
            else if (assign_to_p_btnL_flag == 1) begin
                    p_btnL <= temp_btnL;
                    assign_to_p_btnL_flag <= 0;

            end
            
        end
        
        else begin
        
            if (count_debouncer != 250000) begin
                count_debouncer <= count_debouncer + 1;
            end
            
            else begin
                stable_flag <= 1; //system is stable when the delay time of 250000 is reached
                if (temp_booting_flag == 0) begin //its the first iteration, where the sytem has just booted
                    temp_booting_flag <= 1;
                    temp_btnL <= ~temp_btnL;
                end
                
                else begin
                    temp_btnL <= ~temp_btnL; //shows that it has fully become the other state that it intended to go towards
                    assign_to_p_btnL_flag <= 1;
                end
                
            end
            
        end
        
    end
    //btnL debouncer code
    
    reg state = 0; // 0 is for normal task, 1 is for improvement
    always @ (posedge clock_190Hz) begin
        if (p_btnL == 1) begin
            state <= ~state;
        end
    end
    
   
    
    
    assign audio_out = (state == 0) ? audio_out_task_normal : audio_out_piano; 
    assign an = (state == 0) ? 4'b1111 : an_piano; 
    assign seg = (state == 0) ? 8'b11111111 : seg_piano;
    assign led = (state == 0) ? 16'b0000000000000000 : led_piano;


endmodule
