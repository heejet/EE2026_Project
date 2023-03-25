`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2023 17:33:41
// Design Name: 
// Module Name: Undirected
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


module Undirected(
    input basys_clock,
    input [15:0] sw,
    input btnU, btnD, btnL, btnR,
    output reg [6:0] seg,
    output reg [3:0] an
    );
    wire [31:0] dist_0, dist_1, dist_2, dist_3, dist_4;
    wire [6:0] set_weights_seg;
    wire [3:0] set_weights_an;

    BF_5_Nodes bellman_ford_5_nodes (
        .basys_clock(basys_clock), 
        .sw(sw[15:0]),
        .btnL(btnL),
        .btnR(btnR),
        .btnU(btnU),
        .btnD(btnD),
        .dist_0(dist_0), 
        .dist_1(dist_1), 
        .dist_2(dist_2), 
        .dist_3(dist_3), 
        .dist_4(dist_4),
        .seg(set_weights_seg),
        .an(set_weights_an)
    );
 
    reg [31:0] count = 0;
    reg [2:0] step = 0;
    
    reg [31:0] curr_node = 0;
    reg [31:0] curr_dist;
    wire [6:0] node_tens, node_ones, dist_tens, dist_ones;
    show_weight show_node (.weight(curr_node), .seg_tens(node_tens), .seg_ones(node_ones));
    show_weight show_dist (.weight(curr_dist), .seg_tens(dist_tens), .seg_ones(dist_ones));
    
    always @ (posedge basys_clock) begin
        count <= (count == 249999) ? 0 : count + 1;
        step <= (count == 0) ? (step == 3) ? 0 : step + 1 : step;
        if (sw[15] == 0) begin
            if (btnR) begin
                curr_node <= (curr_node == 4) ? 4 : curr_node + 1;
            end
            else if (btnL) begin
                curr_node <= (curr_node == 0) ? 0 : curr_node - 1;
            end
            case (curr_node)
                0: begin
                    curr_dist <= dist_0;
                end
                1: begin
                    curr_dist <= dist_1;
                end
                2: begin
                    curr_dist <= dist_2;
                end
                3: begin
                    curr_dist <= dist_3;
                end
                4: begin
                    curr_dist <= dist_4;
                end
            endcase
            case (step)
                0: begin
                    seg <= node_tens;
                    an <= 4'b0111;
                end
                1: begin
                    seg <= node_ones;
                    an <= 4'b1011;
                end
                2: begin
                    seg <= dist_tens;
                    an <= 4'b1101;
                end
                3: begin
                    seg <= dist_ones;
                    an <= 4'b1110;
                end
            endcase
        end
        else begin
            seg <= set_weights_seg;
            an <= set_weights_an;
        end
    end
endmodule