`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2023 17:27:54
// Design Name: 
// Module Name: Directed
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


module Directed(
    input basys_clock,
    input [15:0] sw,
    input btnU, btnD, btnL, btnR,
    input [12:0] pixel_index,
    output reg [6:0] seg,
    output reg [3:0] an,
    output reg [15:0] oled_data_1,
    output is_cyclic
    );
    wire [31:0] dist_0, dist_1, dist_2, dist_3;
    wire [6:0] set_weights_seg;
    wire [3:0] set_weights_an;
    wire [31:0] pointer;
    
    BF_4_Nodes bellman_ford_4_nodes  (
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
        .seg(set_weights_seg),
        .an(set_weights_an),
        .pointer(pointer)
    );
    
    Cycle_Detection cycle_detection (
        .basys_clock(basys_clock),
        .sw(sw),
        .is_cyclic(is_cyclic)
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
                curr_node <= (curr_node == 3) ? 3 : curr_node + 1;
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
    
    wire clk1hz;
    clk_divider my_clk1hz(.basys_clk(basys_clock), .m(49999999), .new_clk(clk1hz));
        
    reg isTurnOn0, isTurnOn1, isTurnOn2, isTurnOn3, isTurnOn4, isTurnOn5, isTurnOn6, isTurnOn7, isTurnOn8, isTurnOn9;

    always @ (posedge basys_clock) begin
        isTurnOn0 <= (pointer == 0 && sw[15] == 1) ? clk1hz : 1;
        isTurnOn1 <= (pointer == 1 && sw[15] == 1) ? clk1hz : 1;
        isTurnOn2 <= (pointer == 2 && sw[15] == 1) ? clk1hz : 1;
        isTurnOn3 <= (pointer == 3 && sw[15] == 1) ? clk1hz : 1;
        isTurnOn4 <= (pointer == 4 && sw[15] == 1) ? clk1hz : 1;
        isTurnOn5 <= (pointer == 5 && sw[15] == 1) ? clk1hz : 1;
        isTurnOn6 <= (pointer == 6 && sw[15] == 1) ? clk1hz : 1;
        isTurnOn7 <= (pointer == 7 && sw[15] == 1) ? clk1hz : 1;
        isTurnOn8 <= (pointer == 8 && sw[15] == 1) ? clk1hz : 1;
        isTurnOn9 <= (pointer == 9 && sw[15] == 1) ? clk1hz : 1;
    
        // Display nodes
        case(pixel_index)
        237: oled_data_1 <= 16'b1111111111111111;
        238: oled_data_1 <= 16'b1111111111111111;
        239: oled_data_1 <= 16'b1111111111111111;
        240: oled_data_1 <= 16'b1111111111111111;
        241: oled_data_1 <= 16'b1111111111111111;
        332: oled_data_1 <= 16'b1111111111111111;
        338: oled_data_1 <= 16'b1111111111111111;
        427: oled_data_1 <= 16'b1111111111111111;
        435: oled_data_1 <= 16'b1111111111111111;
        522: oled_data_1 <= 16'b1111111111111111;
        527: oled_data_1 <= 16'b1111111111111111;
        532: oled_data_1 <= 16'b1111111111111111;
        618: oled_data_1 <= 16'b1111111111111111;
        622: oled_data_1 <= 16'b1111111111111111;
        623: oled_data_1 <= 16'b1111111111111111;
        628: oled_data_1 <= 16'b1111111111111111;
        714: oled_data_1 <= 16'b1111111111111111;
        719: oled_data_1 <= 16'b1111111111111111;
        724: oled_data_1 <= 16'b1111111111111111;
        810: oled_data_1 <= 16'b1111111111111111;
        815: oled_data_1 <= 16'b1111111111111111;
        820: oled_data_1 <= 16'b1111111111111111;
        906: oled_data_1 <= 16'b1111111111111111;
        910: oled_data_1 <= 16'b1111111111111111;
        911: oled_data_1 <= 16'b1111111111111111;
        912: oled_data_1 <= 16'b1111111111111111;
        916: oled_data_1 <= 16'b1111111111111111;
        1003: oled_data_1 <= 16'b1111111111111111;
        1011: oled_data_1 <= 16'b1111111111111111;
        1100: oled_data_1 <= 16'b1111111111111111;
        1106: oled_data_1 <= 16'b1111111111111111;
        1197: oled_data_1 <= 16'b1111111111111111;
        1198: oled_data_1 <= 16'b1111111111111111;
        1199: oled_data_1 <= 16'b1111111111111111;
        1200: oled_data_1 <= 16'b1111111111111111;
        1201: oled_data_1 <= 16'b1111111111111111;
        2510: oled_data_1 <= 16'b1111111111111111;
        2511: oled_data_1 <= 16'b1111111111111111;
        2512: oled_data_1 <= 16'b1111111111111111;
        2513: oled_data_1 <= 16'b1111111111111111;
        2514: oled_data_1 <= 16'b1111111111111111;
        2573: oled_data_1 <= 16'b1111111111111111;
        2574: oled_data_1 <= 16'b1111111111111111;
        2575: oled_data_1 <= 16'b1111111111111111;
        2576: oled_data_1 <= 16'b1111111111111111;
        2577: oled_data_1 <= 16'b1111111111111111;
        2605: oled_data_1 <= 16'b1111111111111111;
        2611: oled_data_1 <= 16'b1111111111111111;
        2668: oled_data_1 <= 16'b1111111111111111;
        2674: oled_data_1 <= 16'b1111111111111111;
        2700: oled_data_1 <= 16'b1111111111111111;
        2708: oled_data_1 <= 16'b1111111111111111;
        2763: oled_data_1 <= 16'b1111111111111111;
        2771: oled_data_1 <= 16'b1111111111111111;
        2795: oled_data_1 <= 16'b1111111111111111;
        2799: oled_data_1 <= 16'b1111111111111111;
        2800: oled_data_1 <= 16'b1111111111111111;
        2805: oled_data_1 <= 16'b1111111111111111;
        2858: oled_data_1 <= 16'b1111111111111111;
        2863: oled_data_1 <= 16'b1111111111111111;
        2864: oled_data_1 <= 16'b1111111111111111;
        2868: oled_data_1 <= 16'b1111111111111111;
        2891: oled_data_1 <= 16'b1111111111111111;
        2894: oled_data_1 <= 16'b1111111111111111;
        2897: oled_data_1 <= 16'b1111111111111111;
        2901: oled_data_1 <= 16'b1111111111111111;
        2954: oled_data_1 <= 16'b1111111111111111;
        2958: oled_data_1 <= 16'b1111111111111111;
        2961: oled_data_1 <= 16'b1111111111111111;
        2964: oled_data_1 <= 16'b1111111111111111;
        2987: oled_data_1 <= 16'b1111111111111111;
        2990: oled_data_1 <= 16'b1111111111111111;
        2993: oled_data_1 <= 16'b1111111111111111;
        2997: oled_data_1 <= 16'b1111111111111111;
        3050: oled_data_1 <= 16'b1111111111111111;
        3056: oled_data_1 <= 16'b1111111111111111;
        3060: oled_data_1 <= 16'b1111111111111111;
        3083: oled_data_1 <= 16'b1111111111111111;
        3086: oled_data_1 <= 16'b1111111111111111;
        3089: oled_data_1 <= 16'b1111111111111111;
        3093: oled_data_1 <= 16'b1111111111111111;
        3146: oled_data_1 <= 16'b1111111111111111;
        3150: oled_data_1 <= 16'b1111111111111111;
        3153: oled_data_1 <= 16'b1111111111111111;
        3156: oled_data_1 <= 16'b1111111111111111;
        3179: oled_data_1 <= 16'b1111111111111111;
        3183: oled_data_1 <= 16'b1111111111111111;
        3184: oled_data_1 <= 16'b1111111111111111;
        3189: oled_data_1 <= 16'b1111111111111111;
        3242: oled_data_1 <= 16'b1111111111111111;
        3247: oled_data_1 <= 16'b1111111111111111;
        3248: oled_data_1 <= 16'b1111111111111111;
        3252: oled_data_1 <= 16'b1111111111111111;
        3276: oled_data_1 <= 16'b1111111111111111;
        3284: oled_data_1 <= 16'b1111111111111111;
        3339: oled_data_1 <= 16'b1111111111111111;
        3347: oled_data_1 <= 16'b1111111111111111;
        3373: oled_data_1 <= 16'b1111111111111111;
        3379: oled_data_1 <= 16'b1111111111111111;
        3436: oled_data_1 <= 16'b1111111111111111;
        3442: oled_data_1 <= 16'b1111111111111111;
        3470: oled_data_1 <= 16'b1111111111111111;
        3471: oled_data_1 <= 16'b1111111111111111;
        3472: oled_data_1 <= 16'b1111111111111111;
        3473: oled_data_1 <= 16'b1111111111111111;
        3474: oled_data_1 <= 16'b1111111111111111;
        3533: oled_data_1 <= 16'b1111111111111111;
        3534: oled_data_1 <= 16'b1111111111111111;
        3535: oled_data_1 <= 16'b1111111111111111;
        3536: oled_data_1 <= 16'b1111111111111111;
        3537: oled_data_1 <= 16'b1111111111111111;
        4940: oled_data_1 <= 16'b1111111111111111;
        4941: oled_data_1 <= 16'b1111111111111111;
        4942: oled_data_1 <= 16'b1111111111111111;
        4943: oled_data_1 <= 16'b1111111111111111;
        4944: oled_data_1 <= 16'b1111111111111111;
        5035: oled_data_1 <= 16'b1111111111111111;
        5041: oled_data_1 <= 16'b1111111111111111;
        5130: oled_data_1 <= 16'b1111111111111111;
        5138: oled_data_1 <= 16'b1111111111111111;
        5225: oled_data_1 <= 16'b1111111111111111;
        5230: oled_data_1 <= 16'b1111111111111111;
        5231: oled_data_1 <= 16'b1111111111111111;
        5235: oled_data_1 <= 16'b1111111111111111;
        5321: oled_data_1 <= 16'b1111111111111111;
        5325: oled_data_1 <= 16'b1111111111111111;
        5328: oled_data_1 <= 16'b1111111111111111;
        5331: oled_data_1 <= 16'b1111111111111111;
        5417: oled_data_1 <= 16'b1111111111111111;
        5423: oled_data_1 <= 16'b1111111111111111;
        5427: oled_data_1 <= 16'b1111111111111111;
        5513: oled_data_1 <= 16'b1111111111111111;
        5518: oled_data_1 <= 16'b1111111111111111;
        5523: oled_data_1 <= 16'b1111111111111111;
        5609: oled_data_1 <= 16'b1111111111111111;
        5613: oled_data_1 <= 16'b1111111111111111;
        5614: oled_data_1 <= 16'b1111111111111111;
        5615: oled_data_1 <= 16'b1111111111111111;
        5616: oled_data_1 <= 16'b1111111111111111;
        5619: oled_data_1 <= 16'b1111111111111111;
        5706: oled_data_1 <= 16'b1111111111111111;
        5714: oled_data_1 <= 16'b1111111111111111;
        5803: oled_data_1 <= 16'b1111111111111111;
        5809: oled_data_1 <= 16'b1111111111111111;
        5900: oled_data_1 <= 16'b1111111111111111;
        5901: oled_data_1 <= 16'b1111111111111111;
        5902: oled_data_1 <= 16'b1111111111111111;
        5903: oled_data_1 <= 16'b1111111111111111;
        5904: oled_data_1 <= 16'b1111111111111111;
        default: oled_data_1 <= 16'b0;
        endcase
    
        if (sw[0]) begin
            if (isTurnOn0) begin
            case(pixel_index)
            421: oled_data_1 <= 16'b1111111111111111;
            422: oled_data_1 <= 16'b1111111111111111;
            423: oled_data_1 <= 16'b1111111111111111;
            518: oled_data_1 <= 16'b1111111111111111;
            519: oled_data_1 <= 16'b1111111111111111;
            613: oled_data_1 <= 16'b1111111111111111;
            615: oled_data_1 <= 16'b1111111111111111;
            708: oled_data_1 <= 16'b1111111111111111;
            803: oled_data_1 <= 16'b1111111111111111;
            898: oled_data_1 <= 16'b1111111111111111;
            993: oled_data_1 <= 16'b1111111111111111;
            1088: oled_data_1 <= 16'b1111111111111111;
            1183: oled_data_1 <= 16'b1111111111111111;
            1278: oled_data_1 <= 16'b1111111111111111;
            1373: oled_data_1 <= 16'b1111111111111111;
            1468: oled_data_1 <= 16'b1111111111111111;
            1563: oled_data_1 <= 16'b1111111111111111;
            1658: oled_data_1 <= 16'b1111111111111111;
            1753: oled_data_1 <= 16'b1111111111111111;
            1848: oled_data_1 <= 16'b1111111111111111;
            1943: oled_data_1 <= 16'b1111111111111111;
            2038: oled_data_1 <= 16'b1111111111111111;
            2133: oled_data_1 <= 16'b1111111111111111;
            2228: oled_data_1 <= 16'b1111111111111111;
            2323: oled_data_1 <= 16'b1111111111111111;
            endcase
            end
            end
            
            if (sw[1]) begin
            if (isTurnOn1) begin
            case(pixel_index)
            808: oled_data_1 <= 16'b1111111111111111;
            903: oled_data_1 <= 16'b1111111111111111;
            998: oled_data_1 <= 16'b1111111111111111;
            1093: oled_data_1 <= 16'b1111111111111111;
            1188: oled_data_1 <= 16'b1111111111111111;
            1283: oled_data_1 <= 16'b1111111111111111;
            1378: oled_data_1 <= 16'b1111111111111111;
            1473: oled_data_1 <= 16'b1111111111111111;
            1568: oled_data_1 <= 16'b1111111111111111;
            1663: oled_data_1 <= 16'b1111111111111111;
            1758: oled_data_1 <= 16'b1111111111111111;
            1853: oled_data_1 <= 16'b1111111111111111;
            1948: oled_data_1 <= 16'b1111111111111111;
            2043: oled_data_1 <= 16'b1111111111111111;
            2138: oled_data_1 <= 16'b1111111111111111;
            2233: oled_data_1 <= 16'b1111111111111111;
            2328: oled_data_1 <= 16'b1111111111111111;
            2421: oled_data_1 <= 16'b1111111111111111;
            2423: oled_data_1 <= 16'b1111111111111111;
            2517: oled_data_1 <= 16'b1111111111111111;
            2518: oled_data_1 <= 16'b1111111111111111;
            2613: oled_data_1 <= 16'b1111111111111111;
            2614: oled_data_1 <= 16'b1111111111111111;
            2615: oled_data_1 <= 16'b1111111111111111;
            endcase
            end
            end
            
            if (sw[2]) begin
            if (isTurnOn2) begin
            case(pixel_index)
            823: oled_data_1 <= 16'b1111111111111111;
            920: oled_data_1 <= 16'b1111111111111111;
            1017: oled_data_1 <= 16'b1111111111111111;
            1114: oled_data_1 <= 16'b1111111111111111;
            1211: oled_data_1 <= 16'b1111111111111111;
            1308: oled_data_1 <= 16'b1111111111111111;
            1405: oled_data_1 <= 16'b1111111111111111;
            1502: oled_data_1 <= 16'b1111111111111111;
            1599: oled_data_1 <= 16'b1111111111111111;
            1696: oled_data_1 <= 16'b1111111111111111;
            1793: oled_data_1 <= 16'b1111111111111111;
            1890: oled_data_1 <= 16'b1111111111111111;
            1987: oled_data_1 <= 16'b1111111111111111;
            2084: oled_data_1 <= 16'b1111111111111111;
            2181: oled_data_1 <= 16'b1111111111111111;
            2278: oled_data_1 <= 16'b1111111111111111;
            2375: oled_data_1 <= 16'b1111111111111111;
            2377: oled_data_1 <= 16'b1111111111111111;
            2472: oled_data_1 <= 16'b1111111111111111;
            2473: oled_data_1 <= 16'b1111111111111111;
            2567: oled_data_1 <= 16'b1111111111111111;
            2568: oled_data_1 <= 16'b1111111111111111;
            2569: oled_data_1 <= 16'b1111111111111111;
            endcase
            end
            end
            
            if (sw[3]) begin
            if (isTurnOn3) begin
            case(pixel_index)
            439: oled_data_1 <= 16'b1111111111111111;
            440: oled_data_1 <= 16'b1111111111111111;
            441: oled_data_1 <= 16'b1111111111111111;
            535: oled_data_1 <= 16'b1111111111111111;
            536: oled_data_1 <= 16'b1111111111111111;
            631: oled_data_1 <= 16'b1111111111111111;
            633: oled_data_1 <= 16'b1111111111111111;
            730: oled_data_1 <= 16'b1111111111111111;
            827: oled_data_1 <= 16'b1111111111111111;
            924: oled_data_1 <= 16'b1111111111111111;
            1021: oled_data_1 <= 16'b1111111111111111;
            1118: oled_data_1 <= 16'b1111111111111111;
            1215: oled_data_1 <= 16'b1111111111111111;
            1312: oled_data_1 <= 16'b1111111111111111;
            1409: oled_data_1 <= 16'b1111111111111111;
            1506: oled_data_1 <= 16'b1111111111111111;
            1603: oled_data_1 <= 16'b1111111111111111;
            1700: oled_data_1 <= 16'b1111111111111111;
            1797: oled_data_1 <= 16'b1111111111111111;
            1894: oled_data_1 <= 16'b1111111111111111;
            1991: oled_data_1 <= 16'b1111111111111111;
            2088: oled_data_1 <= 16'b1111111111111111;
            2185: oled_data_1 <= 16'b1111111111111111;
            2282: oled_data_1 <= 16'b1111111111111111;
            2379: oled_data_1 <= 16'b1111111111111111;
            endcase
            end
            end
            
            if (sw[4]) begin
            if (isTurnOn4) begin
            case(pixel_index)
            3626: oled_data_1 <= 16'b1111111111111111;
            3721: oled_data_1 <= 16'b1111111111111111;
            3816: oled_data_1 <= 16'b1111111111111111;
            3911: oled_data_1 <= 16'b1111111111111111;
            4006: oled_data_1 <= 16'b1111111111111111;
            4101: oled_data_1 <= 16'b1111111111111111;
            4196: oled_data_1 <= 16'b1111111111111111;
            4291: oled_data_1 <= 16'b1111111111111111;
            4386: oled_data_1 <= 16'b1111111111111111;
            4481: oled_data_1 <= 16'b1111111111111111;
            4576: oled_data_1 <= 16'b1111111111111111;
            4671: oled_data_1 <= 16'b1111111111111111;
            4766: oled_data_1 <= 16'b1111111111111111;
            4861: oled_data_1 <= 16'b1111111111111111;
            4956: oled_data_1 <= 16'b1111111111111111;
            5051: oled_data_1 <= 16'b1111111111111111;
            5146: oled_data_1 <= 16'b1111111111111111;
            5241: oled_data_1 <= 16'b1111111111111111;
            5336: oled_data_1 <= 16'b1111111111111111;
            5429: oled_data_1 <= 16'b1111111111111111;
            5431: oled_data_1 <= 16'b1111111111111111;
            5525: oled_data_1 <= 16'b1111111111111111;
            5526: oled_data_1 <= 16'b1111111111111111;
            5621: oled_data_1 <= 16'b1111111111111111;
            5622: oled_data_1 <= 16'b1111111111111111;
            5623: oled_data_1 <= 16'b1111111111111111;
            endcase
            end
            end
            
            if (sw[5]) begin
            if (isTurnOn5) begin
            case(pixel_index)
            3430: oled_data_1 <= 16'b1111111111111111;
            3431: oled_data_1 <= 16'b1111111111111111;
            3432: oled_data_1 <= 16'b1111111111111111;
            3527: oled_data_1 <= 16'b1111111111111111;
            3528: oled_data_1 <= 16'b1111111111111111;
            3622: oled_data_1 <= 16'b1111111111111111;
            3624: oled_data_1 <= 16'b1111111111111111;
            3717: oled_data_1 <= 16'b1111111111111111;
            3812: oled_data_1 <= 16'b1111111111111111;
            3907: oled_data_1 <= 16'b1111111111111111;
            4002: oled_data_1 <= 16'b1111111111111111;
            4097: oled_data_1 <= 16'b1111111111111111;
            4192: oled_data_1 <= 16'b1111111111111111;
            4287: oled_data_1 <= 16'b1111111111111111;
            4382: oled_data_1 <= 16'b1111111111111111;
            4477: oled_data_1 <= 16'b1111111111111111;
            4572: oled_data_1 <= 16'b1111111111111111;
            4667: oled_data_1 <= 16'b1111111111111111;
            4762: oled_data_1 <= 16'b1111111111111111;
            4857: oled_data_1 <= 16'b1111111111111111;
            4952: oled_data_1 <= 16'b1111111111111111;
            5047: oled_data_1 <= 16'b1111111111111111;
            5142: oled_data_1 <= 16'b1111111111111111;
            5237: oled_data_1 <= 16'b1111111111111111;
            endcase
            end
            end
            
            if (sw[6]) begin
            if (isTurnOn6) begin
            case(pixel_index)
            3477: oled_data_1 <= 16'b1111111111111111;
            3478: oled_data_1 <= 16'b1111111111111111;
            3479: oled_data_1 <= 16'b1111111111111111;
            3573: oled_data_1 <= 16'b1111111111111111;
            3574: oled_data_1 <= 16'b1111111111111111;
            3669: oled_data_1 <= 16'b1111111111111111;
            3671: oled_data_1 <= 16'b1111111111111111;
            3768: oled_data_1 <= 16'b1111111111111111;
            3865: oled_data_1 <= 16'b1111111111111111;
            3962: oled_data_1 <= 16'b1111111111111111;
            4059: oled_data_1 <= 16'b1111111111111111;
            4156: oled_data_1 <= 16'b1111111111111111;
            4253: oled_data_1 <= 16'b1111111111111111;
            4350: oled_data_1 <= 16'b1111111111111111;
            4447: oled_data_1 <= 16'b1111111111111111;
            4544: oled_data_1 <= 16'b1111111111111111;
            4641: oled_data_1 <= 16'b1111111111111111;
            4738: oled_data_1 <= 16'b1111111111111111;
            4835: oled_data_1 <= 16'b1111111111111111;
            4932: oled_data_1 <= 16'b1111111111111111;
            5029: oled_data_1 <= 16'b1111111111111111;
            5126: oled_data_1 <= 16'b1111111111111111;
            5223: oled_data_1 <= 16'b1111111111111111;
            endcase
            end
            end
            
            if (sw[7]) begin
            if (isTurnOn7) begin
            case(pixel_index)
            3764: oled_data_1 <= 16'b1111111111111111;
            3861: oled_data_1 <= 16'b1111111111111111;
            3958: oled_data_1 <= 16'b1111111111111111;
            4055: oled_data_1 <= 16'b1111111111111111;
            4152: oled_data_1 <= 16'b1111111111111111;
            4249: oled_data_1 <= 16'b1111111111111111;
            4346: oled_data_1 <= 16'b1111111111111111;
            4443: oled_data_1 <= 16'b1111111111111111;
            4540: oled_data_1 <= 16'b1111111111111111;
            4637: oled_data_1 <= 16'b1111111111111111;
            4734: oled_data_1 <= 16'b1111111111111111;
            4831: oled_data_1 <= 16'b1111111111111111;
            4928: oled_data_1 <= 16'b1111111111111111;
            5025: oled_data_1 <= 16'b1111111111111111;
            5122: oled_data_1 <= 16'b1111111111111111;
            5219: oled_data_1 <= 16'b1111111111111111;
            5316: oled_data_1 <= 16'b1111111111111111;
            5413: oled_data_1 <= 16'b1111111111111111;
            5415: oled_data_1 <= 16'b1111111111111111;
            5510: oled_data_1 <= 16'b1111111111111111;
            5511: oled_data_1 <= 16'b1111111111111111;
            5605: oled_data_1 <= 16'b1111111111111111;
            5606: oled_data_1 <= 16'b1111111111111111;
            5607: oled_data_1 <= 16'b1111111111111111;
            endcase
            end
            end
            
            if (sw[8]) begin
            if (isTurnOn8) begin
            case(pixel_index)
            1388: oled_data_1 <= 16'b1111111111111111;
            1483: oled_data_1 <= 16'b1111111111111111;
            1484: oled_data_1 <= 16'b1111111111111111;
            1485: oled_data_1 <= 16'b1111111111111111;
            1578: oled_data_1 <= 16'b1111111111111111;
            1579: oled_data_1 <= 16'b1111111111111111;
            1580: oled_data_1 <= 16'b1111111111111111;
            1581: oled_data_1 <= 16'b1111111111111111;
            1582: oled_data_1 <= 16'b1111111111111111;
            1676: oled_data_1 <= 16'b1111111111111111;
            1772: oled_data_1 <= 16'b1111111111111111;
            1868: oled_data_1 <= 16'b1111111111111111;
            1964: oled_data_1 <= 16'b1111111111111111;
            2060: oled_data_1 <= 16'b1111111111111111;
            2156: oled_data_1 <= 16'b1111111111111111;
            2252: oled_data_1 <= 16'b1111111111111111;
            2348: oled_data_1 <= 16'b1111111111111111;
            2444: oled_data_1 <= 16'b1111111111111111;
            2540: oled_data_1 <= 16'b1111111111111111;
            2636: oled_data_1 <= 16'b1111111111111111;
            2732: oled_data_1 <= 16'b1111111111111111;
            2828: oled_data_1 <= 16'b1111111111111111;
            2924: oled_data_1 <= 16'b1111111111111111;
            3020: oled_data_1 <= 16'b1111111111111111;
            3116: oled_data_1 <= 16'b1111111111111111;
            3212: oled_data_1 <= 16'b1111111111111111;
            3308: oled_data_1 <= 16'b1111111111111111;
            3404: oled_data_1 <= 16'b1111111111111111;
            3500: oled_data_1 <= 16'b1111111111111111;
            3596: oled_data_1 <= 16'b1111111111111111;
            3692: oled_data_1 <= 16'b1111111111111111;
            3788: oled_data_1 <= 16'b1111111111111111;
            3884: oled_data_1 <= 16'b1111111111111111;
            3980: oled_data_1 <= 16'b1111111111111111;
            4076: oled_data_1 <= 16'b1111111111111111;
            4172: oled_data_1 <= 16'b1111111111111111;
            4268: oled_data_1 <= 16'b1111111111111111;
            4364: oled_data_1 <= 16'b1111111111111111;
            4460: oled_data_1 <= 16'b1111111111111111;
            4556: oled_data_1 <= 16'b1111111111111111;
            4652: oled_data_1 <= 16'b1111111111111111;
            4748: oled_data_1 <= 16'b1111111111111111;
            endcase
            end
            end
            
            if (sw[9]) begin
            if (isTurnOn9) begin
            case(pixel_index)
            1393: oled_data_1 <= 16'b1111111111111111;
            1489: oled_data_1 <= 16'b1111111111111111;
            1585: oled_data_1 <= 16'b1111111111111111;
            1681: oled_data_1 <= 16'b1111111111111111;
            1777: oled_data_1 <= 16'b1111111111111111;
            1873: oled_data_1 <= 16'b1111111111111111;
            1969: oled_data_1 <= 16'b1111111111111111;
            2065: oled_data_1 <= 16'b1111111111111111;
            2161: oled_data_1 <= 16'b1111111111111111;
            2257: oled_data_1 <= 16'b1111111111111111;
            2353: oled_data_1 <= 16'b1111111111111111;
            2449: oled_data_1 <= 16'b1111111111111111;
            2545: oled_data_1 <= 16'b1111111111111111;
            2641: oled_data_1 <= 16'b1111111111111111;
            2737: oled_data_1 <= 16'b1111111111111111;
            2833: oled_data_1 <= 16'b1111111111111111;
            2929: oled_data_1 <= 16'b1111111111111111;
            3025: oled_data_1 <= 16'b1111111111111111;
            3121: oled_data_1 <= 16'b1111111111111111;
            3217: oled_data_1 <= 16'b1111111111111111;
            3313: oled_data_1 <= 16'b1111111111111111;
            3409: oled_data_1 <= 16'b1111111111111111;
            3505: oled_data_1 <= 16'b1111111111111111;
            3601: oled_data_1 <= 16'b1111111111111111;
            3697: oled_data_1 <= 16'b1111111111111111;
            3793: oled_data_1 <= 16'b1111111111111111;
            3889: oled_data_1 <= 16'b1111111111111111;
            3985: oled_data_1 <= 16'b1111111111111111;
            4081: oled_data_1 <= 16'b1111111111111111;
            4177: oled_data_1 <= 16'b1111111111111111;
            4273: oled_data_1 <= 16'b1111111111111111;
            4369: oled_data_1 <= 16'b1111111111111111;
            4465: oled_data_1 <= 16'b1111111111111111;
            4559: oled_data_1 <= 16'b1111111111111111;
            4560: oled_data_1 <= 16'b1111111111111111;
            4561: oled_data_1 <= 16'b1111111111111111;
            4562: oled_data_1 <= 16'b1111111111111111;
            4563: oled_data_1 <= 16'b1111111111111111;
            4656: oled_data_1 <= 16'b1111111111111111;
            4657: oled_data_1 <= 16'b1111111111111111;
            4658: oled_data_1 <= 16'b1111111111111111;
            4753: oled_data_1 <= 16'b1111111111111111;
            endcase
            end
            end
    end
endmodule
