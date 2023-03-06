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
    input clock,
    input J_MIC_Pin3,
    input SW1,
    output J_MIC_Pin1,
    output J_MIC_Pin4,
    output [11:0] led
    );
    
    wire clk10k;
    wire clk20k;
    wire main_clk;
    wire [11:0] MIC_in;
    
    clk_divider my_10khz_clock(.basys_clk(clock),.m(4999999),.new_clk(clk10k));
    clk_divider my_20khz_clock(.basys_clk(clock),.m(2499),.new_clk(clk20k));
    Audio_Input AI_dut(.CLK(clock),.cs(main_clk),.MISO(J_MIC_Pin3),.clk_samp(J_MIC_Pin1),.sclk(J_MIC_Pin4),.sample(MIC_in));

    assign main_clk = (SW1 == 1) ? clk10k : clk20k;
    assign led = MIC_in;

endmodule