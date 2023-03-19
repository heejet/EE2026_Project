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


module Audio_In_Individual_Task(
    input clk_sampleinterval,
    input [11:0] MIC_in,
    output [3:0] an,
    output reg [7:0] seg,
    output reg [7:0] led
);

    assign an[0] = 0; // active-low, always on
    assign an[1] = 1; // active-high, always off
    assign an[2] = 1; // active-high, always off
    assign an[3] = 1; // active-high, always off
    
    reg [11:0] peak_value; // record the peak value of each MIC_in
    reg [11:0] count; // when count exceeds 4000, reset and find new peak in new sampleframe
    
    always @ (posedge clk_sampleinterval)
    begin
        count <= count + 1;
        if (MIC_in > peak_value) begin
            peak_value <= MIC_in;
        end
        if (count >= 4000) begin // 4000 * 50 * 10^-6  = 0.2s
            if (peak_value > 3825 && peak_value <= 4095) begin
                seg <= 7'b0000000; // 8
                led <= 9'b011111111;
            end
            else if (peak_value > 3550 && peak_value <= 3825) begin
                seg <= 7'b1111000; // 7
                led <= 9'b001111111;
            end
            else if (peak_value > 3275 && peak_value <= 3550) begin
                seg <= 7'b0000010; // 6
                led <= 9'b000111111;
            end
            else if (peak_value > 3000 && peak_value <= 3275) begin
                seg <= 7'b0010010; // 5
                led <= 9'b000011111;
            end
            else if (peak_value > 2725 && peak_value <= 3000) begin
                seg <= 7'b0011001; // 4
                led <= 9'b000001111;
            end
            else if (peak_value > 2450 && peak_value <= 2725) begin
                seg <= 7'b0110000; // 3
                led <= 9'b000000111;
            end
            else if (peak_value > 2175 && peak_value <= 2450) begin
                seg <= 7'b0100100; // 2
                led <= 9'b00000011;
            end
            else if (peak_value > 1900 && peak_value <= 2175) begin
                seg <= 7'b1111001; // 1
                led <= 9'b000000001;
            end
            else begin
                seg <= 7'b0000001; // 0
                led <= 9'b000000000;
            end
            count <= 0;
            peak_value <= 0;
        end
    end
endmodule
