`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2023 02:43:15 AM
// Design Name: 
// Module Name: is_valid_digit
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


module is_valid_digit(
    input [12:0] curr_display,
    input sw15,
    output reg is_valid,
    output reg [3:0] digit_type
);

    always @ (*) begin
        if (sw15) begin
            case (curr_display)
                13'b0111111111111: begin
                    is_valid <= 1;
                    digit_type <= 0;
                end
                13'b0000001111100: begin
                    is_valid <= 1;
                    digit_type <= 1;
                end
                13'b1011111011111: begin
                    is_valid <= 1;
                    digit_type <= 2;
                end
                13'b1010111111111: begin
                    is_valid <= 1;
                    digit_type <= 3;
                end
                13'b1110001111101: begin
                    is_valid <= 1;
                    digit_type <= 4;
                end
                13'b1110111110111: begin
                    is_valid <= 1;
                    digit_type <= 5;
                end
                13'b1111111110111: begin
                    is_valid <= 1;
                    digit_type <= 6;
                end
                13'b0000001111111: begin
                    is_valid <= 1;
                    digit_type <= 7;
                end
                13'b1111111111111: begin
                    is_valid <= 1;
                    digit_type <= 8;
                end
                13'b1110001111111: begin
                    is_valid <= 1;
                    digit_type <= 9;
                end
            endcase
        end
        else begin
            is_valid <= 0;
            digit_type <= 10; // signifies invalid digit
        end
    end
endmodule
