`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2023 11:25:35 AM
// Design Name: 
// Module Name: Clock_Divider_mkHz
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


module Clock_Divider_20kHz(
    input clock,
    input [31:0] m,
    output reg my_clock = 0
    );
    
    reg [31:0] count = 0;
    
    always @ (posedge clock)
        begin
            count <= (count == m) ? 0 : count + 1;
            my_clock <= (count == 0) ? ~my_clock : my_clock;
        end
    
endmodule
