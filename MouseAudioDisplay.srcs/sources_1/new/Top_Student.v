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
    input btn_C,
    inout ps2_clk,  
    inout ps2_data,
    output reg [15:13] led
    );
    wire left, middle, right;
    MouseCtl mouse_test(.clk(basys_clock), .rst(btn_C), .value(0), .setx(0), 
                        .sety(0), .setmax_x(0), .setmax_y(0),
                        .left(left), .middle(middle), .right(right),
                        .ps2_clk(ps2_clk), .ps2_data(ps2_data));
    
    always @ (posedge basys_clock) begin
        led[15] <= left;
        led[14] <= middle;
        led[13] <= right;
    end

endmodule