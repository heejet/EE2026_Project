`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2023 02:18:20 AM
// Design Name: 
// Module Name: Oled_Individual_Task
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


module Oled_Individual_Task(
    input clk25mhz,
    input sw0, sw1, sw2, sw3,
    input [12:0] pixel_index,
    output reg [15:0] oled_data
);

    parameter GREEN = 16'h07E0;
    parameter RED = 16'hF800;
    parameter BLACK = 16'h0000;
    parameter WHITE = 16'hFFFF;
    
    wire [6:0] x;
    wire [5:0] y;
        
    assign x = (pixel_index % 96); // from 0 to 95
    assign y = (pixel_index / 96); // from 0 to 63
    
    always @ (posedge clk25mhz) begin
        // Green border
        if ((sw3) &&
            ((x == 56 && y <= 56) || 
             (x <= 56 && y == 56) ||
             (x == 57 && y <= 57) || 
             (x <= 57 && y == 57) ||
             (x == 58 && y <= 58) ||
             (x <= 58 && y == 58))) begin
            oled_data <= GREEN;
        end
        
        // 0 Digit -> sw[0]
        else if ((sw0 && ~sw1 && ~sw2) &&
                 ((x >= 10 && x <= 45 && y >= 6 && y <= 12) ||
                  (x >= 10 && x <= 45 && y >= 43 && y <= 49) ||
                  (x >= 10 && x <= 16 && y >= 13 && y <= 42) ||
                  (x >= 39 && x <= 45 && y >= 13 && y <= 42))) begin
            oled_data <= WHITE;
        end
        
        // 1 Digit -> sw[1]
        else if ((sw1 && ~sw2) &&
                 ((x >= 24 && x <= 32 && y >= 6 && y <= 49))) begin
            oled_data <= WHITE;      
        end
        
        // 2 Digit -> sw[2]
        else if ((sw2) &&
                 ((x >= 10 && x <= 45 && y >= 6 && y <= 11) ||
                  (x >= 40 && x <= 45 && y >= 12 && y <= 23) ||
                  (x >= 10 && x <= 45 && y >= 24 && y <= 31) ||
                  (x >= 10 && x <= 15 && y >= 32 && y <= 43) ||
                  (x >= 10 && x <= 45 && y >= 44 && y <= 49))) begin
            oled_data <= WHITE;
        end
        
        else begin
            oled_data <= BLACK;
        end
    end

endmodule
