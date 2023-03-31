`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2023 09:18:37 PM
// Design Name: 
// Module Name: Paint
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


module Paint(
    input basys_clock,
    input [15:0] sw,
    input clk25mhz,
    input [12:0] pixel_index,
    input [6:0] cursor_x_pos,
    input [5:0] cursor_y_pos,
    input mouse_left_btn,
    input mouse_right_btn,
    input mouse_center_btn,
    input isUsingPaint,
    output reg [15:0] oled_data
);
   
    parameter WHITE = 16'hFFFF;
    parameter RED = 16'hF800;
    parameter PINK = 16'b1111100000010010;
    
    // Declare the BRAM
    (* ram_style = "block" *)
    reg [15:0] rom [6143:0];

    wire [6:0] x;
    wire [5:0] y;
           
    assign x = (pixel_index % 96); // from 0 to 95
    assign y = (pixel_index / 96); // from 0 to 63
    
    wire [12:0] pixel_index_mouse;
        
    assign pixel_index_mouse = (cursor_y_pos * 96) + (cursor_x_pos);
    
    reg erase = 0;
    reg colour = 0;
    
    always @ (posedge basys_clock) begin
        if (mouse_right_btn) begin
            erase <= ~erase;
        end
        else if (mouse_center_btn) begin
            colour <= ~colour;
        end
    end
        
    always @ (posedge clk25mhz) begin
        if (!erase && !colour &&
           (((x == cursor_x_pos && y == cursor_y_pos) || 
           (x == cursor_x_pos + 1 && y == cursor_y_pos)||
           (x == cursor_x_pos && y == cursor_y_pos + 1) ||
           (x == cursor_x_pos + 1 && y == cursor_y_pos + 1)))) begin
           oled_data <= RED;
        end
        else if (erase &&
                (((x == cursor_x_pos && y == cursor_y_pos) || 
                (x == cursor_x_pos + 1 && y == cursor_y_pos)||
                (x == cursor_x_pos && y == cursor_y_pos + 1) ||
                (x == cursor_x_pos + 1 && y == cursor_y_pos + 1)))) begin
           oled_data <= PINK;
        end
        else if (colour && !erase &&
                (((x == cursor_x_pos && y == cursor_y_pos) || 
                (x == cursor_x_pos + 1 && y == cursor_y_pos)||
                (x == cursor_x_pos && y == cursor_y_pos + 1) ||
                (x == cursor_x_pos + 1 && y == cursor_y_pos + 1)))) begin
            oled_data <= sw;
        end
        else begin
            oled_data <= rom[pixel_index];
        end 
    end
    
    // Update the rom
    always @ (posedge basys_clock) begin
        if (isUsingPaint) begin
        if (mouse_left_btn && !colour && !erase) begin
            // save data into BRAM
            rom[pixel_index_mouse] <= WHITE;
        end
        else if (mouse_left_btn && erase) begin
            rom[pixel_index_mouse] <= 0;
        end
        else if (mouse_left_btn && colour && !erase) begin
            rom[pixel_index_mouse] <= sw;
        end
        end
    end
    
endmodule
