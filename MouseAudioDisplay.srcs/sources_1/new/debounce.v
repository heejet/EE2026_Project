`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2023 11:50:15
// Design Name: 
// Module Name: debounce
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


module debounce(
    input clock, 
    input input_signal, 
    output output_signal
    );
    wire Q_1, QB_1, Q_2, QB_2;
    
    D_FF ff_1 (.clk(clock), .D(input_signal), .Q(Q_1), .QB(QB_1));
    D_FF ff_2 (.clk(clock), .D(Q_1), .Q(Q_2), .QB(QB_2));
    
    assign output_signal = Q_1 & QB_2;
    
endmodule
