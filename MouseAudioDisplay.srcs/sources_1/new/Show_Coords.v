`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2023 08:35:15
// Design Name: 
// Module Name: Show_Coords
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


module Show_Coords(
    input [10:0] pos,
    output reg [7:0] seg_tens,
    output reg [7:0] seg_ones
    );
    wire [4:0] tens_place = pos / 10;
    wire [4:0] ones_place = pos % 10;
    always @ (*) begin
        case (tens_place)
            0: begin
                seg_tens <= 8'b11000000;
            end
            1: begin
                seg_tens <= 8'b11111001;
            end
            2: begin
                seg_tens <= 8'b10100100;
            end
            3: begin
                seg_tens <= 8'b10110000;
            end
            4: begin
                seg_tens <= 8'b10011001;
            end
            5: begin
                seg_tens <= 8'b10010010;
            end
            6: begin
                seg_tens <= 8'b10000010;
            end
            7: begin
                seg_tens <= 8'b11111000;
            end
            8: begin
                seg_tens <= 8'b10000000;
            end
            9: begin
                seg_tens <= 8'b10010000;
            end
        endcase
        case (ones_place)
            0: begin
                seg_ones <= 8'b11000000;
            end
            1: begin
                seg_ones <= 8'b11111001;
            end
            2: begin
                seg_ones <= 8'b10100100;
            end
            3: begin
                seg_ones <= 8'b10110000;
            end
            4: begin
                seg_ones <= 8'b10011001;
            end
            5: begin
                seg_ones <= 8'b10010010;
            end
            6: begin
                seg_ones <= 8'b10000010;
            end
            7: begin
                seg_ones <= 8'b11111000;
            end
            8: begin
                seg_ones <= 8'b10000000;
            end
            9: begin
                seg_ones <= 8'b10010000;
            end
        endcase
    end   
endmodule
