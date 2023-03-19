`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2023 22:39:10
// Design Name: 
// Module Name: create_oled_7seg
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


module create_oled_7seg(
  input basys_clock,
  input [6:0] cursor_x_pos,
  input [5:0] cursor_y_pos,
  input [4:0] sw,
  input [12:0] pixel_index,
  output reg [15:0] oled_data
  );
  
  parameter GREEN = 16'h07E0;
  parameter RED = 16'hF800;
  parameter BLACK = 16'h0000;
  parameter WHITE = 16'hFFFF; 
  
  wire frame_begin, sending_pixels, sample_pixel;
  wire [6:0] x;
  wire [5:0] y;
  pixel_data_to_coordinate coverter (.pixel_index(pixel_index), .x_coord(x), .y_coord(y));
  
  wire clk6p25m;
  clk_divider my_clk6p25m(.basys_clk(basys_clock), .m(7), .new_clk(clk6p25m));

  always @ (posedge clk6p25m) begin // CHANGE TO 25MHz clock!!
      if ((x == cursor_x_pos && y == cursor_y_pos) || 
          (x == cursor_x_pos + 1 && y == cursor_y_pos)||
          (x == cursor_x_pos && y == cursor_y_pos + 1) ||
          (x == cursor_x_pos + 1 && y == cursor_y_pos + 1)) begin
          oled_data <= RED;
      end
      else begin
          if (sw[4]) begin
          
              // Green border
              if ((x == 56 && y <= 56) || 
                  (x <= 56 && y == 56) ||
                  (x == 57 && y <= 57) || 
                  (x <= 57 && y == 57) ||
                  (x == 58 && y <= 58) ||
                  (x <= 58 && y == 58)) begin
                  oled_data <= GREEN;
              end
              // 7-segment OLED template
              else if ((sw[3]) && 
                       ((x >= 10 && x <= 45 && y == 6) ||
                        (x >= 10 && x <= 45 && y == 12) ||
                        (x >= 10 && x <= 45 && y == 25) ||
                        (x >= 10 && x <= 45 && y == 31) ||
                        (x >= 10 && x <= 45 && y == 43) ||
                        (x >= 10 && x <= 45 && y == 49) ||
                        (x == 10 && y >= 6 && y <= 49) ||
                        (x == 16 && y >= 6 && y <= 49) ||
                        (x == 39 && y >= 6 && y <= 49) ||
                        (x == 45 && y >= 6 && y <= 49))) begin
                  oled_data <= WHITE;
              end
              else begin
                  oled_data <= 0;
              end
          end
          else begin
              oled_data <= 0;
          end
      end
  end
endmodule
