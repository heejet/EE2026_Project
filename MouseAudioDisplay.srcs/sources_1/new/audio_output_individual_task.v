`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2023 05:39:52 PM
// Design Name: 
// Module Name: audio_output_individual_task
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


module audio_output_individual_task(
input CLOCK,
    // Delete this comment and include Basys3 inputs and outputs here
    output J1,
    output J2,
    output J3,
    output J0,
    input sw0,
    input btnC
    );
    
    
    wire clock_50MHz;
    wire clock_20kHz;
    wire clock_190Hz;
    wire clock_380Hz;
    wire clock_25MHz;

    
    custom_clock clk_50MHz(CLOCK, 0, clock_50MHz);
    custom_clock clk_20kHz(CLOCK, 2499, clock_20kHz);
    custom_clock clk_190Hz(CLOCK, 263156, clock_190Hz);
    custom_clock clk_380Hz(CLOCK, 131577, clock_380Hz);
    custom_clock clk_25MHz(CLOCK, 1, clock_25MHz);


    wire [11:0] audio_out;
    
    
    Audio_Output unit_my_audio_output (
    .CLK(clock_50MHz),  
    .START(clock_20kHz),
    .DATA1(audio_out),
    .DATA2(),
    .RST(0),
  

    .D1(J1),
    .D2(J2),
    .CLK_OUT(J3),
    .nSYNC(J0),
    .DONE()
    );
    
    
//    wire p_btnC;
//    fourB unit_my_btnC(clock_25MHz, btnC, p_btnC);
    



    
//    module fourB(input clock_25MHz, input btnC, output reg p_btnC
//    );
    
    reg p_btnC;
    reg [31:0] count_debouncer = 0;
    reg stable_flag = 0;
    reg temp_btnC = 1; 
    reg temp_booting_flag = 0;
    reg assign_to_p_btnC_flag = 0;

    

    always @ (posedge clock_25MHz) begin
    
        if (stable_flag == 1) begin
        
            if (btnC == 1 && assign_to_p_btnC_flag == 0) begin
                stable_flag <= 0;
                count_debouncer <= 0;
                temp_btnC <= 0; //shows that it is not yet fully pressed
            end 
            
            else if (btnC == 0 && assign_to_p_btnC_flag == 0) begin
                stable_flag <= 0;
                count_debouncer <= 0;
                temp_btnC <= 1; //shows that it is not yet fully released
            end
            
            else if (assign_to_p_btnC_flag == 1) begin
                    p_btnC <= temp_btnC;
                    assign_to_p_btnC_flag <= 0;

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
                    temp_btnC <= ~temp_btnC;
                end
                
                else begin
                    temp_btnC <= ~temp_btnC; //shows that it has fully become the other state that it intended to go towards
                    assign_to_p_btnC_flag <= 1;
                end
                
            end
            
        end
        
    end
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    wire [11:0] p_audio_out;
    reg [11:0] switchon_audio_out = 12'hFFF;
    reg [11:0] switchoff_audio_out = 12'h800;
    reg long_btnC = 0;
    reg ready_to_start = 1;
    
    assign p_audio_out = (sw0 == 1) ? switchon_audio_out : switchoff_audio_out;
    
    always @ (posedge clock_190Hz) begin
        switchon_audio_out <= (switchon_audio_out == 12'hFFF) ? 0 : 12'hFFF;
    end
    
    always @ (posedge clock_380Hz) begin
        switchoff_audio_out <= (switchoff_audio_out == 12'h800) ? 0 : 12'h800;
    end
    
    assign audio_out = long_btnC ? p_audio_out : 0;
    
    reg [31:0] count; //24999998 to count 1 sec
    always @ (posedge clock_25MHz) begin
        if (p_btnC == 1 && ready_to_start == 1) begin
            long_btnC <= 1;
            count <= 1;
            ready_to_start <= 0;
        end
        else begin
            count <= (count == 24999998) ? 0 : count + 1;
            long_btnC <= (count == 0) ? 0 : long_btnC;
            if (p_btnC == 0) begin
                ready_to_start <= 1;
            end
        end
    end

    
    
endmodule
