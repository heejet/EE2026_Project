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
    input sw0, sw1,
    input clk25mhz,
    input [12:0] pixel_index,
    input [6:0] cursor_x_pos,
    input [5:0] cursor_y_pos,
    input mouse_left_btn,
    output reg [15:0] oled_data
);
   
    parameter WHITE = 16'hFFFF;
    parameter RED = 16'hF800;
    
    // Declare the BRAM
    (* ram_style = "block" *)
    reg [15:0] rom [6143:0];

    wire [6:0] x;
    wire [5:0] y;
           
    assign x = (pixel_index % 96); // from 0 to 95
    assign y = (pixel_index / 96); // from 0 to 63
    
    wire [12:0] pixel_index_mouse;
        
    assign pixel_index_mouse = (cursor_y_pos * 96) + (cursor_x_pos); 
        
    always @ (posedge clk25mhz) begin
        if ((x == cursor_x_pos && y == cursor_y_pos) || 
           (x == cursor_x_pos + 1 && y == cursor_y_pos)||
           (x == cursor_x_pos && y == cursor_y_pos + 1) ||
           (x == cursor_x_pos + 1 && y == cursor_y_pos + 1)) begin
           oled_data <= RED;
        end
        else begin
            oled_data <= rom[pixel_index];
        end 
    end
    
    // Update the rom
    always @ (posedge basys_clock) begin
        if (mouse_left_btn && !sw0 && !sw1) begin
            // save data into BRAM
            rom[pixel_index_mouse] <= WHITE;
        end
        else if (mouse_left_btn && sw0) begin
            rom[pixel_index_mouse] <= 0;
        end
        else if (mouse_left_btn && sw1) begin
            rom[pixel_index_mouse] <= RED;
        end
    end
    
endmodule
