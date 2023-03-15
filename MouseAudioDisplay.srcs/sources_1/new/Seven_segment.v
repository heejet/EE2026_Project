`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2023 03:39:40 AM
// Design Name: 
// Module Name: Seven_segment
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


module Seven_segment(
    input basys_clock,
    input is_valid,
    input [3:0] digit_type,
    output [3:0] an,
    output [7:0] seg
);

    reg [7:0] zero_seg_L = 8'b01000000;
    reg [7:0] zero_seg_R = 8'b11111001; 
    
    reg [7:0] one_seg_L = 8'b01000000;
    reg [7:0] one_seg_R = 8'b10100100; 

   
    reg [7:0] two_seg_L = 8'b01000000;
    reg [7:0] two_seg_R = 8'b10110000; 
    
    reg [7:0] three_seg_L = 8'b01000000;
    reg [7:0] three_seg_R = 8'b10011001;

    reg [7:0] four_seg_L = 8'b01000000;
    reg [7:0] four_seg_R = 8'b10010010; 

    reg [7:0] five_seg_L = 8'b01000000;
    reg [7:0] five_seg_R = 8'b10000010 ; 

    reg [7:0] six_seg_L = 8'b01000000;
    reg [7:0] six_seg_R = 8'b11111000;
    
    reg [7:0] seven_seg_L = 8'b01000000;
    reg [7:0] seven_seg_R = 8'b10000000; 
    
    reg [7:0] eight_seg_L = 8'b01000000;
    reg [7:0] eight_seg_R = 8'b10011000;
    
    reg [7:0] nine_seg_L = 8'b01000000;
    reg [7:0] nine_seg_R = 8'b11000000; 
        
    reg [3:0] temp_an;
    assign an = (is_valid == 1) ? temp_an : 4'b1111;    
    
    reg [7:0] temp_seg;
    assign seg = (is_valid == 1) ? temp_seg : 8'b11111111;

    reg display_flag = 0;
    reg [31:0] counter = 0;
    always @(posedge basys_clock) begin
        counter <= (counter == 800000) ? 0 : counter + 1;
        if (counter == 0) begin
        if (digit_type == 0) begin
            if (display_flag == 0) begin
                temp_seg <= zero_seg_L;
                temp_an <= 4'b0111;
            end
            else begin
                temp_seg <= zero_seg_R;
                temp_an <= 4'b1011;
            end
            display_flag <= ~display_flag;
        end
        
        else if (digit_type == 1) begin
            if (display_flag == 0) begin
                temp_seg <= one_seg_L;
                temp_an <= 4'b0111;
            end
            else begin
                temp_seg <= one_seg_R;
                temp_an <= 4'b1011;
            end
            display_flag <= ~display_flag;        
        end
        
        else if (digit_type == 2) begin
            if (display_flag == 0) begin
                temp_seg <= two_seg_L;
                temp_an <= 4'b0111;
            end
            else begin
                temp_seg <= two_seg_R;
                temp_an <= 4'b1011;
            end
            display_flag <= ~display_flag;            
        end
        
        else if (digit_type == 3) begin
            if (display_flag == 0) begin
                temp_seg <= three_seg_L;
                temp_an <= 4'b0111;
            end
            else begin
                temp_seg <= three_seg_R;
                temp_an <= 4'b1011;
            end
            display_flag <= ~display_flag;        
        end
        
        else if (digit_type == 4) begin
            if (display_flag == 0) begin
                temp_seg <= four_seg_L;
                temp_an <= 4'b0111;
            end
            else begin
                temp_seg <= four_seg_R;
                temp_an <= 4'b1011;
            end
            display_flag <= ~display_flag;        
        end
        
        else if (digit_type == 5) begin
            if (display_flag == 0) begin
                temp_seg <= five_seg_L;
                temp_an <= 4'b0111;
            end
            else begin
                temp_seg <= five_seg_R;
                temp_an <= 4'b1011;
            end
            display_flag <= ~display_flag;        
        end
        
        else if (digit_type == 6) begin
             if (display_flag == 0) begin
                temp_seg <= six_seg_L;
                temp_an <= 4'b0111;
            end
            else begin
                temp_seg <= six_seg_R;
                temp_an <= 4'b1011;
            end
            display_flag <= ~display_flag;       
        end
        
        else if (digit_type == 7) begin
             if (display_flag == 0) begin
                temp_seg <= seven_seg_L;
                temp_an <= 4'b0111;
            end
            else begin
                temp_seg <= seven_seg_R;
                temp_an <= 4'b1011;
            end
            display_flag <= ~display_flag;       
        end
        
        else if (digit_type == 8) begin
             if (display_flag == 0) begin
                temp_seg <= eight_seg_L;
                temp_an <= 4'b0111;
            end
            else begin
                temp_seg <= eight_seg_R;
                temp_an <= 4'b1011;
            end
            display_flag <= ~display_flag;       
        end
        
        else if (digit_type == 9) begin
            if (display_flag == 0) begin
                temp_seg <= nine_seg_L;
                temp_an <= 4'b0111;
            end
            else begin
                temp_seg <= nine_seg_R;
                temp_an <= 4'b1011;
            end
                display_flag <= ~display_flag;        
        end
        end  
    end
    
    
endmodule
