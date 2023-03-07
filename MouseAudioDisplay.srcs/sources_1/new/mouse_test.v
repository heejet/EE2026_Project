`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2023 09:40:29
// Design Name: 
// Module Name: mouse_test
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


module mouse_test(
    input basys_clk,
    input mouse_left_btn,
    input mouse_middle_btn,
    input mouse_right_btn,
    output reg [15:13] led
    );
    always @ (posedge basys_clk) begin
        led[15] <= mouse_left_btn;
        led[14] <= mouse_middle_btn;
        led[13] <= mouse_right_btn;
    end
endmodule
