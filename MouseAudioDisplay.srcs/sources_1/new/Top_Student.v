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
    // Delete this comment and include Basys3 inputs and outputs here
    input basys_clock,
    input [4:0] sw,
    output [7:0] JC
    );
    
    siu siuuu (.basys_clock(basys_clock), .sw(sw), .JC(JC));
    
endmodule