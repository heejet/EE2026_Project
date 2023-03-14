`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2023 09:26:30 AM
// Design Name: 
// Module Name: clock20hz
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


module clock20hz (input CLOCK, output reg SLOW_CLOCK = 0

    );
    
    reg [31:0] count = 0;
    
    always @ (posedge CLOCK) begin
        count <= (count == 2499) ? 0 : count + 1;
        SLOW_CLOCK <= (count == 0)? ~SLOW_CLOCK : SLOW_CLOCK;
    end
endmodule
