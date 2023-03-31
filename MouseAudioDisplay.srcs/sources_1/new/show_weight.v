`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2023 17:15:58
// Design Name: 
// Module Name: show_weight
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


module show_weight(
    input [31:0] weight,
    output reg [7:0] seg_tens,
    output reg [7:0] seg_ones
    );
    wire [4:0] tens_place = weight / 10;
    wire [4:0] ones_place = weight % 10;
    always @ (*) begin
        case (tens_place)
            0: begin
                seg_tens <= 7'b1000000;
            end
            1: begin
                seg_tens <= 7'b1111001;
            end
            2: begin
                seg_tens <= 7'b0100100;
            end
            3: begin
                seg_tens <= 7'b0110000;
            end
            4: begin
                seg_tens <= 7'b0011001;
            end
            5: begin
                seg_tens <= 7'b0010010;
            end
            6: begin
                seg_tens <= 7'b0000010;
            end
            7: begin
                seg_tens <= 7'b1111000;
            end
            8: begin
                seg_tens <= 7'b0000000;
            end
            9: begin
                seg_tens <= 7'b0010000;
            end
        endcase
        case (ones_place)
            0: begin
                seg_ones <= 7'b1000000;
            end
            1: begin
                seg_ones <= 7'b1111001;
            end
            2: begin
                seg_ones <= 7'b0100100;
            end
            3: begin
                seg_ones <= 7'b0110000;
            end
            4: begin
                seg_ones <= 7'b0011001;
            end
            5: begin
                seg_ones <= 7'b0010010;
            end
            6: begin
                seg_ones <= 7'b0000010;
            end
            7: begin
                seg_ones <= 7'b1111000;
            end
            8: begin
                seg_ones <= 7'b0000000;
            end
            9: begin
                seg_ones <= 7'b0010000;
            end
        endcase
    end   
endmodule

