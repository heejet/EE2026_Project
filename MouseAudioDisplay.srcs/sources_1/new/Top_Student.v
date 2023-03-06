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
    output reg [11:0] led = 0
    );
    
    wire clk10;
    wire clk20k;
    reg main_clk;
    wire [11:0] MIC_in;
    
    clk_divider my_10hz_clock(.basys_clk(clock),.m(4999999),.my_clk(clk10));
    clk_divider my_20khz_clock(.basys_clk(clock),.m(2499),.my_clk(clk20k));
    Audio_Input AI_dut(.CLK(clock),.cs(clk20k),.MISO(J_MIC_Pin3),.clk_samp(J_MIC_Pin1),.sclk(J_MIC_Pin4),.sample(MIC_in));

    always @ (posedge clock)
    begin
        main_clk <= (SW1 == 1) ? clk10 : clk20k;    
    end
    
    always @ (posedge main_clk)
    begin
        led[11:0] <= MIC_in[11:0];
    end
endmodule