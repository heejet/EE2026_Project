`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2023 17:18:19
// Design Name: 
// Module Name: Cycle_Detection
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


module Cycle_Detection(
    input basys_clock,
    input [15:0] sw,
    output reg is_cyclic
    );  
    reg [31:0] dist [0:31];

    reg [31:0] step = 1;
    reg flag = 0;
    
    initial begin
        dist[0] = 0;
        dist[1] = 0;
        dist[2] = 0;
        dist[3] = 0;
    end
    
    always @ (posedge basys_clock) begin
        // Run Bellman Ford
        step <= (step == 10) ? 1 : step + 1;
        if (step == 1) begin
            dist[0] = 0;
            dist[1] = 0;
            dist[2] = 0;
            dist[3] = 0;
            flag = 0;
        end
        else if (step > 1 && step < 8) begin
            if (sw[0] == 1) begin
                if (dist[0] + 1 >= dist[1]) begin
                    dist[1] = dist[0] + 1;
                end
            end
            if (sw[1] == 1) begin
                if (dist[1] + 1 >= dist[0]) begin
                    dist[0] = dist[1] + 1;
                end
            end
            if (sw[2] == 1) begin
                if (dist[1] + 1 >= dist[3]) begin
                    dist[3] = dist[1] + 1;
                end
            end
            if (sw[3] == 1) begin
                if (dist[3] + 1 >= dist[1]) begin
                    dist[1] = dist[3] + 1;
                end
            end
            if (sw[4] == 1) begin
                if (dist[3] + 1 >= dist[2]) begin
                    dist[2] = dist[3] + 1;
                end
            end
            if (sw[5] == 1) begin
                if (dist[2] + 1 >= dist[3]) begin
                    dist[3] = dist[2] + 1;
                end
            end
            if (sw[6] == 1) begin
                if (dist[2] + 1 >= dist[0]) begin
                    dist[0] = dist[2] + 1;
                end
            end
            if (sw[7] == 1) begin
                if (dist[0] + 1 >= dist[2]) begin
                    dist[2] = dist[0] + 1;
                end
            end
            if (sw[8] == 1) begin
                if (dist[2] + 1 >= dist[1]) begin
                    dist[1] = dist[2] + 1;
                end
            end              
            if (sw[9] == 1) begin
                if (dist[1] + 1 >= dist[2]) begin
                    dist[2] = dist[1] + 1;
                end
            end
        end
        else begin
            if (dist[0] > 4 || dist[1] > 4 || dist[2] > 4 || dist[3] > 4) begin
                is_cyclic <= 1;
            end
            else begin
                is_cyclic <= 0;
            end
        end
    end
endmodule
