`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2023 11:00:40 AM
// Design Name: 
// Module Name: custom_clock
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


module custom_clock (input CLOCK, input [31:0] m, output reg SLOW_CLOCK = 0

    );
    
    reg [31:0] count = 0;
    
    always @ (posedge CLOCK) begin
        count <= (count == m) ? 0 : count + 1;
        SLOW_CLOCK <= (count == 0)? ~SLOW_CLOCK : SLOW_CLOCK;
    end
endmodule
