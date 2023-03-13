`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2023 03:41:04 AM
// Design Name: 
// Module Name: Speaker
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


module Speaker(
    input CLOCK,
    output J1,
    output J2,
    output J3,
    output J0,
    input is_valid,
    input [3:0] digit_type
);

    wire clock_50MHz, clock_20kHz, clock_190Hz, clock_380Hz, clock_25MHz;

    clk_divider clk_50MHz(.basys_clk(CLOCK), .m(0), .new_clk(clock_50MHz));
    clk_divider clk_20kHz(.basys_clk(CLOCK), .m(2499), .new_clk(clock_20kHz));
    clk_divider clk_190Hz(.basys_clk(CLOCK), .m(263156), .new_clk(clock_190Hz));
    clk_divider clk_380Hz(.basys_clk(CLOCK), .m(131577), .new_clk(clock_380Hz));
    clk_divider clk_25MHz(.basys_clk(CLOCK), .m(1), .new_clk(clock_25MHz));

    wire [11:0] audio_out;

    Audio_Output unit_my_audio_output (
    .CLK(clock_50MHz),  
    .START(clock_20kHz),
    .DATA1(audio_out),
    .DATA2(),
    .RST(0),

    .D1(J1),
    .D2(J2),
    .CLK_OUT(J3),
    .nSYNC(J0),
    .DONE()
    );

endmodule
