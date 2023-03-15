`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input basys_clock,
    input btnC,
    inout ps2_clk,  
    inout ps2_data,
    input sw0, sw15,
    output led15,
    output [7:0] JC,
    output [3:0] an,
    output [7:0] seg,
    output [3:0] JB
    );
    
    Group_Task GT(
        .basys_clock(basys_clock), 
        .sw0(sw0),
        .sw15(sw15), 
        .JC(JC),
        .btnC(btnC), 
        .ps2_clk(ps2_clk), 
        .ps2_data(ps2_data),
        .led15(led15),
        .an(an),
        .seg(seg),
        .JB(JB)
    );

endmodule