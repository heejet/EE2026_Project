`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2023 09:50:07
// Design Name: 
// Module Name: Siu_Meter
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


module Siu_Meter(
    input basys_clock,
    input [6:0] cursor_x_pos,
    input [5:0] cursor_y_pos,
    input mouse_left_btn,
    output [3:0] an,
    output reg [7:0] seg
    );
    reg [31:0] meter = 0;
    reg [31:0] count = 0;
    
    assign an = 4'b0000;
    
    always @ (posedge basys_clock) begin
        count <= (count == 24_999_999) ? 0 : count + 1;
        if (mouse_left_btn) begin
            meter <= (meter == 9) ? 9 : meter + 1;
        end
        else begin
            meter <= (count == 0) ? (meter == 0) ? 0 : meter - 1 : meter;
        end
        case (meter)
            0: begin
                seg <= 7'b1000000;
            end
            1: begin
                seg <= 7'b1111001;
            end
            2: begin
                seg <= 7'b0100100;
            end
            3: begin
                seg <= 7'b0110000;
            end
            4: begin
                seg <= 7'b0011001;
            end
            5: begin
                seg <= 7'b0010010;
            end
            6: begin
                seg <= 7'b0000010;
            end
            7: begin
                seg <= 7'b1111000;
            end
            8: begin
                seg <= 7'b0000000;
            end
            9: begin
                seg <= 7'b0010000;
            end
        endcase
    end
endmodule
