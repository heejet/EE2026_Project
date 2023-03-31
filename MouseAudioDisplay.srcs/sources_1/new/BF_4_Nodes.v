`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2023 17:14:29
// Design Name: 
// Module Name: BF_4_Nodes
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


module BF_4_Nodes(
    input basys_clock,
    input [15:0] sw,
    input btnL,
    input btnR,
    input btnU,
    input btnD,
    output reg [10:0] dist_0,
    output reg [10:0] dist_1,
    output reg [10:0] dist_2,
    output reg [10:0] dist_3,
    output reg [6:0] seg,
    output reg [3:0] an,
    output reg is_connected,
    output reg [3:0] pointer = 0,
    output [2:0] weights_0, weights_1, weights_2, weights_3, weights_4, weights_5, weights_6, weights_7, weights_8, weights_9
);
    reg [9:0] weights [0:9];

    assign weights_0 = weights[0];
    assign weights_1 = weights[1];
    assign weights_2 = weights[2];
    assign weights_3 = weights[3];
    assign weights_4 = weights[4];
    assign weights_5 = weights[5];
    assign weights_6 = weights[6];
    assign weights_7 = weights[7];
    assign weights_8 = weights[8];
    assign weights_9 = weights[9];
    wire [6:0] label_tens, label_ones, weight_tens, weight_ones;
    
    show_weight i (.weight(weights[pointer]), .seg_tens(weight_tens), .seg_ones(weight_ones));
    show_weight j (.weight(pointer), .seg_tens(label_tens), .seg_ones(label_ones));
    
    reg [31:0] count_display = 0;
    reg [3:0] step_display = 0;
    
    reg [10:0] dist [0:10];
    
    reg [3:0] step = 1;
    
    initial begin
        dist[0] = 0;
        dist[1] = 99;
        dist[2] = 99;
        dist[3] = 99;
        weights[0] = 1;
        weights[1] = 1; 
        weights[2] = 1;
        weights[3] = 1;
        weights[4] = 1;
        weights[5] = 1;
        weights[6] = 1;
        weights[7] = 1;
        weights[8] = 1;
        weights[9] = 1;
    end
    
    always @ (posedge basys_clock) begin
        // Run Bellman Ford
        if (sw[15] == 0) begin
            step <= (step == 10) ? 1 : step + 1;
            if (step == 1) begin
                dist[0] = 0;
                dist[1] = 99;
                dist[2] = 99;
                dist[3] = 99;
            end
            else if (step > 1 && step < 7)begin
                if (sw[0] == 1) begin
                    if (dist[0] + weights[0] <= dist[1]) begin
                        dist[1] = dist[0] + weights[0];
                    end
                end
                if (sw[1] == 1) begin
                    if (dist[1] + weights[1] <= dist[0]) begin
                        dist[0] = dist[1] + weights[1];
                    end
                end
                if (sw[2] == 1) begin
                    if (dist[1] + weights[2] <= dist[3]) begin
                        dist[3] = dist[1] + weights[2];
                    end
                end
                if (sw[3] == 1) begin
                    if (dist[3] + weights[3] <= dist[1]) begin
                        dist[1] = dist[3] + weights[3];
                    end
                end
                if (sw[4] == 1) begin
                    if (dist[3] + weights[4] <= dist[2]) begin
                        dist[2] = dist[3] + weights[4];
                    end
                end
                if (sw[5] == 1) begin
                    if (dist[2] + weights[5] <= dist[3]) begin
                        dist[3] = dist[2] + weights[5];
                    end
                end
                if (sw[6] == 1) begin
                    if (dist[2] + weights[6] <= dist[0]) begin
                        dist[0] = dist[2] + weights[6];
                    end
                end
                if (sw[7] == 1) begin
                    if (dist[0] + weights[7] <= dist[2]) begin
                        dist[2] = dist[0] + weights[7];
                    end
                end
                if (sw[8] == 1) begin
                    if (dist[2] + weights[8] <= dist[1]) begin
                        dist[1] = dist[2] + weights[8];
                    end
                end              
                if (sw[9] == 1) begin
                    if (dist[1] + weights[9] <= dist[2]) begin
                        dist[2] = dist[1] + weights[9];
                    end
                end
            end
            else begin
                dist_1 <= dist[1];
                dist_2 <= dist[2];
                dist_3 <= dist[3];
                if (dist[1] >= 99 || dist[2] >= 99 || dist[3] >= 99) begin
                    is_connected <= 0;
                end
                else begin
                    is_connected <= 1;
                end
            end
        end
        // Set weights
        else begin
            if (btnU) begin
                weights[pointer] <= (weights[pointer] == 5) ? 5 : weights[pointer] + 1;
            end
            else if (btnD) begin
                weights[pointer] <= (weights[pointer] == 1) ? 1 : weights[pointer] - 1;
            end
            else if (btnR) begin
                pointer <= (pointer == 9) ? 9 : pointer + 1;
            end
            else if (btnL) begin
                pointer <= (pointer == 0) ? 0 : pointer - 1;
            end
            count_display <= (count_display == 249999) ? 0 : count_display + 1;
            step_display <= (count_display == 0) ? (step_display == 3) ? 0 : step_display + 1 : step_display;
            case (step_display)
               0: begin
                   seg <= label_tens;
                   an <= 4'b0111;
               end
               1: begin
                   seg <= label_ones;
                   an <= 4'b1011;
               end
               2: begin
                   seg <= weight_tens;
                   an <= 4'b1101;
               end
               3: begin
                   seg <= weight_ones;
                   an <= 4'b1110;
               end
           endcase
        end
    end
endmodule
