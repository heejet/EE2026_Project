`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2023 04:42:02 AM
// Design Name: 
// Module Name: Audio_In_Individual_Task
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


module Audio_In_Individual_Task ( 
    input [11:0] MIC_in,
    input basys_clock,
    output [3:0] an,
    output reg [8:0] led,
    output reg [6:0] seg
    ); 

    wire clk_sampleinterval; // f = 20kHz (sample interval for highest value in sampleframe)
    reg [11:0] peak_value; // record the peak value of each MIC_in
    reg [11:0] count; // when count exceeds 4000, reset and find new peak in new sampleframe

    clk_divider clk_sample_interval(basys_clock, 2499, clk_sampleinterval);

    assign an[0] = 0; // active-low, always on
    assign an[1] = 1; // active-high, always off
    assign an[2] = 1; // active-high, always off
    assign an[3] = 1; // active-high, always off

    always @ (posedge clk_sampleinterval)
    begin
        count <= count + 1;
        if (MIC_in > peak_value) begin
            peak_value <= MIC_in;
        end
        if (count >= 4000) begin // 4000 * 50 * 10^-6  = 0.2s
            if (peak_value > 3860 && peak_value <= 4095) begin
                seg <= 7'b0000000; // 8
                led <= 9'b011111111;
            end
            else if (peak_value > 3630 && peak_value <= 3860) begin
                seg <= 7'b1111000; // 7
                led <= 9'b001111111;
            end
            else if (peak_value > 3400 && peak_value <= 3630) begin
                seg <= 7'b0000010; // 6
                led <= 9'b000111111;
            end
            else if (peak_value > 3170 && peak_value <= 3400) begin
                seg <= 7'b0010010; // 5
                led <= 9'b000011111;
            end
            else if (peak_value > 2940 && peak_value <= 3170) begin
                seg <= 7'b0011001; // 4
                led <= 9'b000001111;
            end
            else if (peak_value > 2710 && peak_value <= 2940) begin
                seg <= 7'b0110000; // 3
                led <= 9'b000000111;
            end
            else if (peak_value > 2480 && peak_value <= 2710) begin
                seg <= 7'b0100100; // 2
                led <= 9'b00000011;
            end
            else if (peak_value > 2250 && peak_value <= 2480) begin
                seg <= 7'b1111001; // 1
                led <= 9'b000000001;
            end
            else begin
                seg <= 7'b1000000; // 0
                led <= 9'b000000000;
            end
            count <= 0;
            peak_value <= 0;
        end
    end

endmodule
