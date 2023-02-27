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


module Top_Student (input CLOCK,
    // Delete this comment and include Basys3 inputs and outputs here
    output D1,
    output D2,
    output CLK_OUT,
    output nSYNC
    );
    
    wire clock_50MHz;
    wire clock_20kHz;
    wire clock_190Hz;
    wire [11:0] audio_out;
    
    custom_clock clk_50MHz(CLOCK, 0, clock_50MHz);
    custom_clock clk_20kHz(CLOCK, 2499, clock_20kHz);
    custom_clock clk_190Hz(CLOCK, 263156, clock_190Hz);
    
    assign audio_out [10:0] = 11'b00000000000;
    assign audio_out [11] = clock_190Hz;
    
    Audio_Output unit_my_audio_output (
    .CLK(clock_50MHz),  
    .START(clock_20kHz),
    .DATA1(audio_out),
    .DATA2(),
    .RST(0),
  

    .D1(D1),
    .D2(D2),
    .CLK_OUT(CLK_OUT),
    .nSYNC(nSYNC),
    .DONE()
    );
    
    
    
    // Delete this comment and write your codes and instantiations here

endmodule