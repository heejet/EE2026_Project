`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2023 15:24:38
// Design Name: 
// Module Name: Random_Number_Generator
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


module Random_Number_Generator(
    input clock,
    output [3:0] random_number
    );
    wire D_in;
    wire [3:0] Q;
    assign D_in = ~(Q[2] ^ Q[3]);
    D_FF ff_1 (.clk(clock), .D(D_in), .Q(Q[0]));
    D_FF ff_2 (.clk(clock), .D(Q[0]), .Q(Q[1]));
    D_FF ff_3 (.clk(clock), .D(Q[1]), .Q(Q[2]));
    D_FF ff_4 (.clk(clock), .D(Q[2]), .Q(Q[3]));
    assign random_number = Q;
endmodule
