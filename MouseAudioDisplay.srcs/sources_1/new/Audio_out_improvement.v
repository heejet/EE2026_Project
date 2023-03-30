`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2023 02:53:44 AM
// Design Name: 
// Module Name: Audio_out_improvement
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


module Audio_out_improvement(
    input [15:0] sw,
    input basys_clock
    ,output [15:0] led
    ,input btnC
    ,input btnU
    ,input btnD
    ,output [3:0] an
    ,output [7:0] seg
    ,output [11:0] audio_out
);

    wire clock_50MHz, clock_20kHz, clock_190Hz, clock_380Hz, clock_25MHz;

    clk_divider clk_50MHz(.basys_clk(basys_clock), .m(0), .new_clk(clock_50MHz));
    clk_divider clk_20kHz(.basys_clk(basys_clock), .m(2499), .new_clk(clock_20kHz));
    clk_divider clk_190Hz(.basys_clk(basys_clock), .m(263156), .new_clk(clock_190Hz));
    clk_divider clk_380Hz(.basys_clk(basys_clock), .m(131577), .new_clk(clock_380Hz));
    clk_divider clk_25MHz(.basys_clk(basys_clock), .m(1), .new_clk(clock_25MHz));
  
  
    //btnC debouncer code
    reg [31:0] count_debouncer = 0;
    reg stable_flag = 0;
    reg temp_btnC = 1; 
    reg temp_booting_flag = 0;
    reg assign_to_p_btnC_flag = 0;
    reg p_btnC = 0;

    

    always @ (posedge clock_25MHz) begin
    
        if (stable_flag == 1) begin
        
            if (btnC == 1 && assign_to_p_btnC_flag == 0) begin
                stable_flag <= 0;
                count_debouncer <= 0;
                temp_btnC <= 0; //shows that it is not yet fully pressed
            end 
            
            else if (btnC == 0 && assign_to_p_btnC_flag == 0) begin
                stable_flag <= 0;
                count_debouncer <= 0;
                temp_btnC <= 1; //shows that it is not yet fully released
            end
            
            else if (assign_to_p_btnC_flag == 1) begin
                    p_btnC <= temp_btnC;
                    assign_to_p_btnC_flag <= 0;

            end
            
        end
        
        else begin
        
            if (count_debouncer != 250000) begin
                count_debouncer <= count_debouncer + 1;
            end
            
            else begin
                stable_flag <= 1; //system is stable when the delay time of 250000 is reached
                if (temp_booting_flag == 0) begin //its the first iteration, where the sytem has just booted
                    temp_booting_flag <= 1;
                    temp_btnC <= ~temp_btnC;
                end
                
                else begin
                    temp_btnC <= ~temp_btnC; //shows that it has fully become the other state that it intended to go towards
                    assign_to_p_btnC_flag <= 1;
                end
                
            end
            
        end
        
    end
    //btnC debouncer code
  
  
  
    //btnU debouncer code
    reg [31:0] count_debouncerU = 0;
    reg stable_flagU = 0;
    reg temp_btnU = 1; 
    reg temp_booting_flagU = 0;
    reg assign_to_p_btnU_flag = 0;
    reg p_btnU = 0;

    

    always @ (posedge clock_25MHz) begin
    
        if (stable_flagU == 1) begin
        
            if (btnU == 1 && assign_to_p_btnU_flag == 0) begin
                stable_flagU <= 0;
                count_debouncerU <= 0;
                temp_btnU <= 0; //shows that it is not yet fully pressed
            end 
            
            else if (btnU == 0 && assign_to_p_btnU_flag == 0) begin
                stable_flagU <= 0;
                count_debouncerU <= 0;
                temp_btnU <= 1; //shows that it is not yet fully released
            end
            
            else if (assign_to_p_btnU_flag == 1) begin
                    p_btnU <= temp_btnU;
                    assign_to_p_btnU_flag <= 0;

            end
            
        end
        
        else begin
        
            if (count_debouncerU != 250000) begin
                count_debouncerU <= count_debouncerU + 1;
            end
            
            else begin
                stable_flagU <= 1; //system is stable when the delay time of 250000 is reached
                if (temp_booting_flagU == 0) begin //its the first iteration, where the sytem has just booted
                    temp_booting_flagU <= 1;
                    temp_btnU <= ~temp_btnU;
                end
                
                else begin
                    temp_btnU <= ~temp_btnU; //shows that it has fully become the other state that it intended to go towards
                    assign_to_p_btnU_flag <= 1;
                end
                
            end
            
        end
        
    end
    //btnU debouncer code



    //btnD debouncer code
    reg [31:0] count_debouncerD = 0;
    reg stable_flagD = 0;
    reg temp_btnD = 1; 
    reg temp_booting_flagD = 0;
    reg assign_to_p_btnD_flag = 0;
    reg p_btnD = 0;

    

    always @ (posedge clock_25MHz) begin
    
        if (stable_flagD == 1) begin
        
            if (btnD == 1 && assign_to_p_btnD_flag == 0) begin
                stable_flagD <= 0;
                count_debouncerD <= 0;
                temp_btnD <= 0; //shows that it is not yet fully pressed
            end 
            
            else if (btnD == 0 && assign_to_p_btnD_flag == 0) begin
                stable_flagD <= 0;
                count_debouncerD <= 0;
                temp_btnD <= 1; //shows that it is not yet fully released
            end
            
            else if (assign_to_p_btnD_flag == 1) begin
                    p_btnD <= temp_btnD;
                    assign_to_p_btnD_flag <= 0;

            end
            
        end
        
        else begin
        
            if (count_debouncerD != 250000) begin
                count_debouncerD <= count_debouncerD + 1;
            end
            
            else begin
                stable_flagD <= 1; //system is stable when the delay time of 250000 is reached
                if (temp_booting_flagD == 0) begin //its the first iteration, where the sytem has just booted
                    temp_booting_flagD <= 1;
                    temp_btnD <= ~temp_btnD;
                end
                
                else begin
                    temp_btnD <= ~temp_btnD; //shows that it has fully become the other state that it intended to go towards
                    assign_to_p_btnD_flag <= 1;
                end
                
            end
            
        end
        
    end
    //btnD debouncer code

    
    
    reg [11:0] temp_C1 = 12'b100000000000;
    reg [11:0] temp_C2 = 12'b100000000000;
    reg [11:0] temp_C3 = 12'b100000000000;
    reg [11:0] temp_C4 = 12'b100000000000;
    reg [11:0] temp_C5 = 12'b100000000000;
    reg [11:0] temp_C6 = 12'b100000000000;
    
    reg [11:0] temp_D1 = 12'b100000000000;
    reg [11:0] temp_D2 = 12'b100000000000;
    reg [11:0] temp_D3 = 12'b100000000000;
    reg [11:0] temp_D4 = 12'b100000000000;
    reg [11:0] temp_D5 = 12'b100000000000;
    reg [11:0] temp_D6 = 12'b100000000000;
    
    reg [11:0] temp_E1 = 12'b100000000000;
    reg [11:0] temp_E2 = 12'b100000000000;
    reg [11:0] temp_E3 = 12'b100000000000;
    reg [11:0] temp_E4 = 12'b100000000000;
    reg [11:0] temp_E5 = 12'b100000000000;
    reg [11:0] temp_E6 = 12'b100000000000;
    
    reg [11:0] temp_F1 = 12'b100000000000;
    reg [11:0] temp_F2 = 12'b100000000000;
    reg [11:0] temp_F3 = 12'b100000000000;
    reg [11:0] temp_F4 = 12'b100000000000;
    reg [11:0] temp_F5 = 12'b100000000000;
    reg [11:0] temp_F6 = 12'b100000000000;
    
    reg [11:0] temp_G1 = 12'b100000000000;
    reg [11:0] temp_G2 = 12'b100000000000;
    reg [11:0] temp_G3 = 12'b100000000000;
    reg [11:0] temp_G4 = 12'b100000000000;
    reg [11:0] temp_G5 = 12'b100000000000;
    reg [11:0] temp_G6 = 12'b100000000000;
    
    reg [11:0] temp_A1 = 12'b100000000000;
    reg [11:0] temp_A2 = 12'b100000000000;
    reg [11:0] temp_A3 = 12'b100000000000;
    reg [11:0] temp_A4 = 12'b100000000000;
    reg [11:0] temp_A5 = 12'b100000000000;
    reg [11:0] temp_A6 = 12'b100000000000;
    
    reg [11:0] temp_B1 = 12'b100000000000;
    reg [11:0] temp_B2 = 12'b100000000000;
    reg [11:0] temp_B3 = 12'b100000000000;
    reg [11:0] temp_B4 = 12'b100000000000;
    reg [11:0] temp_B5 = 12'b100000000000;
    reg [11:0] temp_B6 = 12'b100000000000;
    
    
    wire C1;
    wire C2;
    wire C3;
    wire C4;
    wire C5;
    wire C6;
    
    wire D1;
    wire D2;
    wire D3;
    wire D4;
    wire D5;
    wire D6;
    
    wire E1;
    wire E2;
    wire E3;
    wire E4;
    wire E5;
    wire E6;
    
    wire F1;
    wire F2;
    wire F3;
    wire F4;
    wire F5;
    wire F6;
    
    wire G1;
    wire G2;
    wire G3;
    wire G4;
    wire G5;
    wire G6;
    
    wire A1;
    wire A2;
    wire A3;
    wire A4;
    wire A5;
    wire A6;
    
    wire B1;
    wire B2;
    wire B3;
    wire B4;
    wire B5;
    wire B6;
  
 
    clk_divider c1(basys_clock, 764525, C1);
    clk_divider c2(basys_clock, 382262, C2);
    clk_divider c3(basys_clock, 191130, C3);
    clk_divider c4(basys_clock, 95565, C4);
    clk_divider c5(basys_clock, 47777, C5);
    clk_divider c6(basys_clock, 23888, C6);
    
    clk_divider d1(basys_clock, 684931, D1);
    clk_divider d2(basys_clock, 340598, D2);
    clk_divider d3(basys_clock, 170299, D3);
    clk_divider d4(basys_clock, 85134, D4);
    clk_divider d5(basys_clock, 42567, D5);
    clk_divider d6(basys_clock, 21282, D6);
    
    clk_divider e1(basys_clock, 606795, E1);
    clk_divider e2(basys_clock, 303397, E2);
    clk_divider e3(basys_clock, 151698, E3);
    clk_divider e4(basys_clock, 75849, E4);
    clk_divider e5(basys_clock, 37921, E5);
    clk_divider e6(basys_clock, 18960, E6);
    
    clk_divider f1(basys_clock, 572737, F1);
    clk_divider f2(basys_clock, 286368, F2);
    clk_divider f3(basys_clock, 143183, F3);
    clk_divider f4(basys_clock, 71591, F4);
    clk_divider f5(basys_clock, 35793, F5);
    clk_divider f6(basys_clock, 17896, F6);
    
    clk_divider g1(basys_clock, 510203, G1);
    clk_divider g2(basys_clock, 255101, G2);
    clk_divider g3(basys_clock, 127550, G3);
    clk_divider g4(basys_clock, 63775, G4);
    clk_divider g5(basys_clock, 31887, G5);
    clk_divider g6(basys_clock, 15943, G6);
    
    clk_divider a1(basys_clock, 454544, A1);
    clk_divider a2(basys_clock, 227272, A2);
    clk_divider a3(basys_clock, 113635, A3);
    clk_divider a4(basys_clock, 56817, A4);
    clk_divider a5(basys_clock, 28408, A5);
    clk_divider a6(basys_clock, 14204, A6);
    
    clk_divider b1(basys_clock, 404955, B1);
    clk_divider b2(basys_clock, 202510, B2);
    clk_divider b3(basys_clock, 101255, B3);
    clk_divider b4(basys_clock, 50622, B4);
    clk_divider b5(basys_clock, 25309, B5);
    clk_divider b6(basys_clock, 12654, B6);
    
    
    
    always @ (posedge C1) begin
        temp_C1 <= (temp_C1 == 12'b100000000000) ? 0 : 12'b100000000000;    
    end
    
    always @ (posedge C2) begin
        temp_C2 <= (temp_C2 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge C3) begin
        temp_C3 <= (temp_C3 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge C4) begin
        temp_C4 <= (temp_C4 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge C5) begin
        temp_C5 <= (temp_C5 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge C6) begin
        temp_C6 <= (temp_C6 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge D1) begin
        temp_D1 <= (temp_D1 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge D2) begin
        temp_D2 <= (temp_D2 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge D3) begin
        temp_D3 <= (temp_D3 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge D4) begin
        temp_D4 <= (temp_D4 == 12'b100000000000) ? 0 : 12'b100000000000;   
    end
    
    always @ (posedge D5) begin
        temp_D5 <= (temp_D5 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge D6) begin
        temp_D6 <= (temp_D6 == 12'b100000000000) ? 0 : 12'b100000000000;   
    end
    
    always @ (posedge E1) begin
        temp_E1 <= (temp_E1 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge E2) begin
        temp_E2 <= (temp_E2 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge E3) begin
        temp_E3 <= (temp_E3 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge E4) begin
        temp_E4 <= (temp_E4 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge E5) begin
        temp_E5 <= (temp_E5 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge E6) begin
        temp_E6 <= (temp_E6 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge F1) begin
        temp_F1 <= (temp_F1 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge F2) begin
        temp_F2 <= (temp_F2 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge F3) begin
        temp_F3 <= (temp_F3 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge F4) begin
        temp_F4 <= (temp_F4 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge F5) begin
        temp_F5 <= (temp_F5 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge F6) begin
        temp_F6 <= (temp_F6 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge G1) begin
        temp_G1 <= (temp_G1 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge G2) begin
        temp_G2 <= (temp_G2 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge G3) begin
        temp_G3 <= (temp_G3 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge G4) begin
        temp_G4 <= (temp_G4 == 12'b100000000000) ? 0 : 12'b100000000000;   
    end
    
    always @ (posedge G5) begin
        temp_G5 <= (temp_G5 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge G6) begin
        temp_G6 <= (temp_G6 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge A1) begin
        temp_A1 <= (temp_A1 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge A2) begin
        temp_A2 <= (temp_A2 == 12'b100000000000) ? 0 : 12'b100000000000; 
    end
    
    always @ (posedge A3) begin
        temp_A3 <= (temp_A3 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge A4) begin
        temp_A4 <= (temp_A4 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge A5) begin
        temp_A5 <= (temp_A5 == 12'b100000000000) ? 0 : 12'b100000000000;   
    end
    
    always @ (posedge A6) begin
        temp_A6 <= (temp_A6 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge B1) begin
        temp_B1 <= (temp_B1 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge B2) begin
        temp_B2 <= (temp_B2 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge B3) begin
        temp_B3 <= (temp_B3 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge B4) begin
        temp_B4 <= (temp_B4 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge B5) begin
        temp_B5 <= (temp_B5 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    always @ (posedge B6) begin
        temp_B6 <= (temp_B6 == 12'b100000000000) ? 0 : 12'b100000000000;  
    end
    
    
    
    wire [11:0] temp_C;
    assign temp_C = (sw[10] == 1 && sw[15:11] == 0) ? temp_C1 : ((sw[11] == 1 && sw[15:12] == 0) ? temp_C2 : ((sw[12] == 1 && sw[15:13] == 0) ? temp_C3 : ((sw[13] == 1 && sw[15:14] == 0) ? temp_C4 : ((sw[14] == 1 && sw[15] == 0) ? temp_C5 : ((sw[15] == 1) ? temp_C6 : 0)))));
    
    wire [11:0]temp_D;
    assign temp_D = (sw[10] == 1 && sw[15:11] == 0) ? temp_D1 : ((sw[11] == 1 && sw[15:12] == 0) ? temp_D2 : ((sw[12] == 1 && sw[15:13] == 0) ? temp_D3 : ((sw[13] == 1 && sw[15:14] == 0) ? temp_D4 : ((sw[14] == 1 && sw[15] == 0) ? temp_D5 : ((sw[15] == 1) ? temp_D6 : 0)))));
    
    wire [11:0] temp_E;
    assign temp_E = (sw[10] == 1 && sw[15:11] == 0) ? temp_E1 : ((sw[11] == 1 && sw[15:12] == 0) ? temp_E2 : ((sw[12] == 1 && sw[15:13] == 0) ? temp_E3 : ((sw[13] == 1 && sw[15:14] == 0) ? temp_E4 : ((sw[14] == 1 && sw[15] == 0) ? temp_E5 : ((sw[15] == 1) ? temp_E6 : 0)))));
    
    wire [11:0]temp_F;
    assign temp_F = (sw[10] == 1 && sw[15:11] == 0) ? temp_F1 : ((sw[11] == 1 && sw[15:12] == 0) ? temp_F2 : ((sw[12] == 1 && sw[15:13] == 0) ? temp_F3 : ((sw[13] == 1 && sw[15:14] == 0) ? temp_F4 : ((sw[14] == 1 && sw[15] == 0) ? temp_F5 : ((sw[15] == 1) ? temp_F6 : 0)))));
    
    wire [11:0] temp_G;
    assign temp_G = (sw[10] == 1 && sw[15:11] == 0) ? temp_G1 : ((sw[11] == 1 && sw[15:12] == 0) ? temp_G2 : ((sw[12] == 1 && sw[15:13] == 0) ? temp_G3 : ((sw[13] == 1 && sw[15:14] == 0) ? temp_G4 : ((sw[14] == 1 && sw[15] == 0) ? temp_G5 : ((sw[15] == 1) ? temp_G6 : 0)))));
    
    wire [11:0] temp_A;
    assign temp_A = (sw[10] == 1 && sw[15:11] == 0) ? temp_A1 : ((sw[11] == 1 && sw[15:12] == 0) ? temp_A2 : ((sw[12] == 1 && sw[15:13] == 0) ? temp_A3 : ((sw[13] == 1 && sw[15:14] == 0) ? temp_A4 : ((sw[14] == 1 && sw[15] == 0) ? temp_A5 : ((sw[15] == 1) ? temp_A6 : 0)))));
    
    wire [11:0] temp_B;
    assign temp_B = (sw[10] == 1 && sw[15:11] == 0) ? temp_B1 : ((sw[11] == 1 && sw[15:12] == 0) ? temp_B2 : ((sw[12] == 1 && sw[15:13] == 0) ? temp_B3 : ((sw[13] == 1 && sw[15:14] == 0) ? temp_B4 : ((sw[14] == 1 && sw[15] == 0) ? temp_B5 : ((sw[15] == 1) ? temp_B6 : 0)))));

   
  
    reg [31:0] counter1 = 1;
    reg [31:0] counter2 = 1;
    reg [31:0] counter3 = 1;
    reg [31:0] counter4 = 1;
    reg [31:0] counter5 = 1;
    reg [31:0] counter6 = 1;
    reg [31:0] counter7 = 1;
    reg [31:0] counter8 = 1;
    reg [31:0] counter9 = 1;
    reg [31:0] counter10 = 1;
    reg [31:0] counter11 = 1;
    reg [31:0] counter12 = 1;
    reg [31:0] counter13 = 1;
    reg [31:0] counter14 = 1;
    reg [31:0] counter15 = 1;
    reg [31:0] counter16 = 1;
    reg [31:0] counter17 = 1;
    reg [31:0] counter18 = 1;
    reg [31:0] counter19 = 1;
    reg [31:0] counter20 = 1;
    reg [31:0] counter21 = 1;
    reg [31:0] counter22 = 1;
    reg [31:0] counter23 = 1;
    reg [31:0] counter24 = 1;
    reg [31:0] counter25 = 1;
    reg [31:0] counter26 = 1;
    reg [31:0] counter27 = 1;  
    reg [31:0] counter28 = 1;
    reg [31:0] counter29 = 1; 
    reg [31:0] counter30 = 1;
    reg [31:0] counter31 = 1; 
    reg [31:0] counter32 = 1;
    reg [31:0] counter34 = 1;
    reg [31:0] counter1617 = 1; //counter for the pause in between same notes
    reg [31:0] counter1920 = 1; //counter for the pause in between same notes
    reg [31:0] counter2627 = 1; //counter for the pause in between same notes
    reg [31:0] counter2728 = 1; //counter for the pause in between same notes
  
  
    reg [31:0] note_no = 1; // initialise the note to be the first note of the song

    wire [11:0] music_player_note;
    reg locked_in_flag = 0;
    assign music_player_note = (note_no == 1 && locked_in_flag == 1) ? temp_A4 : ((note_no == 2 && locked_in_flag == 1) ? temp_C5 : ((note_no == 3 && locked_in_flag == 1) ? temp_D5 : ((note_no == 4 && locked_in_flag == 1) ? temp_D5 : ((note_no == 5 && locked_in_flag == 1) ? temp_F5 : ((note_no == 6 && locked_in_flag == 1) ? temp_E5 : ((note_no == 7 && locked_in_flag == 1) ? temp_C5 : ((note_no == 8 && locked_in_flag == 1) ? temp_F5 : ((note_no == 9 && locked_in_flag == 1) ? temp_G5 : ((note_no == 10 && locked_in_flag == 1) ? temp_F5 : ((note_no == 11 && locked_in_flag == 1) ? temp_E5 : ((note_no == 12 && locked_in_flag == 1) ? temp_D5 : ((note_no == 13 && locked_in_flag == 1) ? temp_E5 : ((note_no == 14 && locked_in_flag == 1) ? temp_D5 : ((note_no == 15 && locked_in_flag == 1) ? temp_C5 : ((note_no == 16 && locked_in_flag == 1) ? temp_A4 : ((note_no == 17 && locked_in_flag == 1) ? temp_A4 : ((note_no == 18 && locked_in_flag == 1) ? temp_C5 : ((note_no == 19 && locked_in_flag == 1) ? temp_D5 : ((note_no == 20 && locked_in_flag == 1) ? temp_D5 : ((note_no == 21 && locked_in_flag == 1) ? temp_F5 : ((note_no == 22 && locked_in_flag == 1) ? temp_E5 : ((note_no == 23 && locked_in_flag == 1) ? temp_C5 : ((note_no == 24 && locked_in_flag == 1) ? temp_F5 : ((note_no == 25 && locked_in_flag == 1) ? temp_G5 : ((note_no == 26 && locked_in_flag == 1) ? temp_A5 : ((note_no == 27 && locked_in_flag == 1) ? temp_A5 : ((note_no == 28 && locked_in_flag == 1) ? temp_A5 : ((note_no == 29 && locked_in_flag == 1) ? temp_G5 : ((note_no == 30 && locked_in_flag == 1) ? temp_F5 : ((note_no == 31 && locked_in_flag == 1) ? temp_G5 : ((note_no == 32 && locked_in_flag == 1) ? temp_F5 : 0)))))))))))))))))))))))))))))));
  
   
    wire [11:0] temp_note;
    assign temp_note = (sw[0] == 1) ? music_player_note : ((sw[9] == 1 && sw[8:3] == 0) ? temp_C : ((sw[8] == 1 && sw[7:3] == 0) ? temp_D : ((sw[7] == 1 && sw[6:3] == 0) ? temp_E : ((sw[6] == 1 && sw[5:3] == 0) ? temp_F : ((sw[5] == 1 && sw[4:3] == 0) ? temp_G : ((sw[4] == 1 && sw[3] == 0) ? temp_A : ((sw[3] == 1) ? temp_B : 0))))))); 
        
    reg [31:0] counter_for_rhythm = 0;
    reg pause_flag = 0;

    wire [11:0] temp_note_with_pause;  
    assign temp_note_with_pause = (sw[0] == 0 && sw[1] == 1 && pause_flag == 0) ? temp_note : 0;

    wire [11:0] temp_note_with_btnC;
    assign temp_note_with_btnC = (sw[0] == 0 && sw[2] == 1 && p_btnC == 1) ? temp_note : 0;

//    wire [11:0] audio_out;
    assign audio_out = (sw[0] == 0 && sw[2] == 1) ? temp_note_with_btnC : ((sw[0] == 0 && sw[1] == 1 && sw[2] == 0) ? temp_note_with_pause : temp_note);

    always @ (posedge basys_clock) begin
        if (sw[0] == 0 && sw[1] == 1) begin
            if (pause_flag == 0) begin //pause_flag zero means note is played
                counter_for_rhythm <= (counter_for_rhythm == 25000000) ? 0 : counter_for_rhythm + 1;
                pause_flag <= (counter_for_rhythm == 0) ? 1 : 0;    
            end
            else begin //pause_flag one means note is paused
                counter_for_rhythm <= (counter_for_rhythm == 25000000) ? 0 : counter_for_rhythm + 1;
                pause_flag <= (counter_for_rhythm == 0) ? 0 : 1;
            end
        end    
        else begin //
            counter_for_rhythm <= 0;
            pause_flag <= 0;
        end
    end
 
  
    always @ (posedge basys_clock) begin
        if (sw[0] == 1 && p_btnC == 1) begin
            locked_in_flag <= 1;
        end
        else if (an == 4'b0000 && seg == 8'b11000000) begin //when seven seg shows 0000
            locked_in_flag <= 0;
            //note_no <= 1; //reset the note_no to one again so the next time the music plays, it stops from the top
        end
    end
  
  
  
    wire activate_music_flag;
    assign activate_music_flag = (sw[0] == 1 && locked_in_flag == 1) ? basys_clock : 0;
  
    always @ (posedge activate_music_flag) begin
        if (note_no == 1) begin
            counter1 <= (counter1 == 50000000) ? 0 : counter1 + 1; 
            note_no <= (counter1 == 0) ? 2 : 1;    
        end
    
        if (note_no == 2) begin
            counter2 <= (counter2 == 50000000) ? 0 : counter2 + 1; 
            note_no <= (counter2 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 3) begin
            counter3 <= (counter3 == 100000000) ? 0 : counter3 + 1; 
            note_no <= (counter3 == 0) ? 34 : 3;  
        end

        if (note_no == 34) begin
            counter34 <= (counter34 == 5000000) ? 0 : counter34 + 1;
            note_no <= (counter34 == 0) ? 4 : 34;
        end

        if (note_no == 4) begin
            counter4 <= (counter4 == 50000000) ? 0 : counter4 + 1; 
            note_no <= (counter4 == 0) ? note_no + 1 : note_no;    
        end
    
        if (note_no == 5) begin
            counter5 <= (counter5 == 50000000) ? 0 : counter5 + 1; 
            note_no <= (counter5 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 6) begin
            counter6 <= (counter6 == 50000000) ? 0 : counter6 + 1; 
            note_no <= (counter6 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 7) begin
            counter7 <= (counter7 == 50000000) ? 0 : counter7 + 1; 
            note_no <= (counter7 == 0) ? note_no + 1 : note_no;  

        end
    
        if (note_no == 8) begin
            counter8 <= (counter8 == 50000000) ? 0 : counter8 + 1; 
            note_no <= (counter8 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 9) begin
            counter9 <= (counter9 == 50000000) ? 0 : counter9 + 1;
            note_no <= (counter9 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 10) begin
            counter10 <= (counter10 == 100000000) ? 0 : counter10 + 1;
            note_no <= (counter10 == 0) ? note_no + 1 : note_no;   
        end
    
        if (note_no == 11) begin
            counter11 <= (counter11 == 100000000) ? 0 : counter11 + 1; 
            note_no <= (counter11 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 12) begin
            counter12 <= (counter12 == 50000000) ? 0 : counter12 + 1; 
            note_no <= (counter12 == 0) ? note_no + 1 : note_no;  
        end
    
        if (note_no == 13) begin
            counter13 <= (counter13 == 50000000) ? 0 : counter13 + 1; 
            note_no <= (counter13 == 0) ? note_no + 1 : note_no;   
        end
    
        if (note_no == 14) begin
            counter14 <= (counter14 == 100000000) ? 0 : counter14 + 1; 
            note_no <= (counter14 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 15) begin
            counter15 <= (counter15 == 100000000) ? 0 : counter15 + 1; 
            note_no <= (counter15 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 16) begin
            counter16 <= (counter16 == 200000000) ? 0 : counter16 + 1; 
            note_no <= (counter16 == 0) ? 1617 : 16;  
        end
    
        if (note_no == 1617) begin
            counter1617 <= (counter1617 == 5000000) ? 0 : counter1617 + 1; 
            note_no <= (counter1617 == 0) ? 17 : 1617;  
        end    
    
        if (note_no == 17) begin
            counter17 <= (counter17 == 50000000) ? 0 : counter17 + 1; 
            note_no <= (counter17 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 18) begin
            counter18 <= (counter18 == 50000000) ? 0 : counter18 + 1; 
            note_no <= (counter18 == 0) ? note_no + 1 : note_no;  
        end
    
        if (note_no == 19) begin
            counter19 <= (counter19 == 100000000) ? 0 : counter19 + 1; 
            note_no <= (counter19 == 0) ? 1920 : 19;  
        end
    
        if (note_no == 1920) begin
            counter1920 <= (counter1920 == 5000000) ? 0 : counter1920 + 1; 
            note_no <= (counter1920 == 0) ? 20 : 1920;  
        end   
    
        if (note_no == 20) begin
            counter20 <= (counter20 == 50000000) ? 0 : counter20 + 1; 
            note_no <= (counter20 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 21) begin
            counter21 <= (counter21 == 50000000) ? 0 : counter21 + 1; 
            note_no <= (counter21 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 22) begin
            counter22 <= (counter22 == 50000000) ? 0 : counter22 + 1;
            note_no <= (counter22 == 0) ? note_no + 1 : note_no;   
        end
    
        if (note_no == 23) begin
            counter23 <= (counter23 == 50000000) ? 0 : counter23 + 1; 
            note_no <= (counter23 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 24) begin
            counter24 <= (counter24 == 50000000) ? 0 : counter24 + 1; 
            note_no <= (counter24 == 0) ? note_no + 1 : note_no;  
        end
    
        if (note_no == 25) begin
            counter25 <= (counter25 == 50000000) ? 0 : counter25 + 1; 
            note_no <= (counter25 == 0) ? note_no + 1 : note_no;  
        end
    
        if (note_no == 26) begin
            counter26 <= (counter26 == 100000000) ? 0 : counter26 + 1; 
            note_no <= (counter26 == 0) ? 2627 : 26;  
        end
   
        if (note_no == 2627) begin
            counter2627 <= (counter2627 == 5000000) ? 0 : counter2627 + 1; 
            note_no <= (counter2627 == 0) ? 27 : 2627;  
        end    

        if (note_no == 27) begin
            counter27 <= (counter27 == 100000000) ? 0 : counter27 + 1; 
            note_no <= (counter27 == 0) ? 2728 : 27;  
        end
    
        if (note_no == 2728) begin
            counter2728 <= (counter2728 == 5000000) ? 0 : counter2728 + 1; 
            note_no <= (counter2728 == 0) ? 28 : 2728;  
        end   

        if (note_no == 28) begin
            counter28 <= (counter28 == 50000000) ? 0 : counter28 + 1; 
            note_no <= (counter28 == 0) ? note_no + 1 : note_no;  
        end
    
        if (note_no == 29) begin
            counter29 <= (counter29 == 50000000) ? 0 : counter29 + 1;
            note_no <= (counter29 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 30) begin
            counter30 <= (counter30 == 100000000) ? 0 : counter30 + 1;
            note_no <= (counter30 == 0) ? note_no + 1 : note_no;  
        end     
    
        if (note_no == 31) begin
            counter31 <= (counter31 == 100000000) ? 0 : counter31 + 1;
            note_no <= (counter31 == 0) ? note_no + 1 : note_no;  
        end

        if (note_no == 32) begin
            counter32 <= (counter32 == 200000000) ? 0 : counter32 + 1; 
            note_no <= (counter32 == 0) ? 1 : 32;  
        end            
    end   
  
  
    //making the LEDs light up based on the note that is sounded
    assign led[9] = ((sw[0] == 1 && (note_no == 2 || note_no == 7 || note_no == 15 || note_no == 18 || note_no == 23)) || (sw[0] == 0 && sw[15:10] != 0 && sw[1] == 1 && sw[2] == 0 && sw[9] == 1 && pause_flag == 0) || (sw[0] == 0 && sw[15:10] != 0 && sw[2] == 1 && sw[9] == 1 && p_btnC == 1) || (sw[15:10] != 0 && sw[2:0] == 0 && sw[9] == 1)) ? 1 : 0;  
    assign led[8] = ((sw[0] == 1 && (note_no == 3 || note_no == 4 || note_no == 12 || note_no == 14 || note_no == 19 || note_no == 20)) || (sw[0] == 0 && sw[15:10] != 0 && sw[1] == 1 && sw[2] == 0 && sw[8] == 1 && pause_flag == 0) || (sw[0] == 0 && sw[15:10] != 0 && sw[2] == 1 && sw[8] == 1 && p_btnC == 1) || (sw[15:10] != 0 && sw[2:0] == 0 && sw[8] == 1)) ? 1 : 0;  
    assign led[7] = ((sw[0] == 1 && (note_no == 6 || note_no == 11 || note_no == 13 || note_no == 22)) || (sw[0] == 0 && sw[15:10] != 0 && sw[1] == 1 && sw[2] == 0 && sw[7] == 1 && pause_flag == 0) || (sw[0] == 0 && sw[15:10] != 0 && sw[2] == 1 && sw[7] == 1 && p_btnC == 1) || (sw[15:10] != 0 && sw[2:0] == 0 && sw[7] == 1)) ? 1 : 0;  
    assign led[6] = ((sw[0] == 1 && (note_no == 5 || note_no == 8 || note_no == 10 || note_no == 24 || note_no == 30 || note_no == 32)) || (sw[0] == 0 && sw[15:10] != 0 && sw[1] == 1 && sw[2] == 0 && sw[6] == 1 && pause_flag == 0) || (sw[0] == 0 && sw[15:10] != 0 && sw[2] == 1 && sw[6] == 1 && p_btnC == 1) || (sw[15:10] != 0 && sw[2:0] == 0 && sw[6] == 1)) ? 1 : 0;  
    assign led[5] = ((sw[0] == 1 && (note_no == 9 || note_no == 25 || note_no == 29 || note_no == 31)) || (sw[0] == 0 && sw[15:10] != 0 && sw[1] == 1 && sw[2] == 0 && sw[5] == 1 && pause_flag == 0) || (sw[0] == 0 && sw[15:10] != 0 && sw[2] == 1 && sw[5] == 1 && p_btnC == 1) || (sw[15:10] != 0 && sw[2:0] == 0 && sw[5] == 1)) ? 1 : 0;  
    assign led[4] = ((sw[0] == 1 && (note_no == 1 || note_no == 16 || note_no == 17 || note_no == 21 || note_no == 26 || note_no == 27 || note_no == 28)) || (sw[0] == 0 && sw[15:10] != 0 && sw[1] == 1 && sw[2] == 0 && sw[4] == 1 && pause_flag == 0) || (sw[0] == 0 && sw[15:10] != 0 && sw[2] == 1 && sw[4] == 1 && p_btnC == 1) || (sw[15:10] != 0 && sw[2:0] == 0 && sw[4] == 1)) ? 1 : 0;  
    assign led[3] = ((sw[0] == 0 && sw[15:10] != 0 && sw[1] == 1 && sw[2] == 0 && sw[3] == 1 && pause_flag == 0) || (sw[0] == 0 && sw[15:10] != 0 && sw[2] == 1 && sw[3] == 1 && p_btnC == 1) || (sw[2:0] == 0 && sw[3] == 1)) ? 1 : 0;  

    

    reg [31:0] total_seconds = 0;	
    reg [31:0] count_down_timer = 0;
    reg registered_as_one_press_flag = 1;
    always @ (posedge basys_clock) begin
        if (locked_in_flag == 0) begin // btnC not yet pressed, hence we can still adjust the music box timing
            if (total_seconds <= 25 && total_seconds >= 0) begin  // setting the boundaries for the length of the song  
                if (p_btnU == 1 && registered_as_one_press_flag == 1) begin
                    if (total_seconds <= 24) begin
                        total_seconds <= total_seconds + 1;
                        registered_as_one_press_flag <= 0;
                    end
                end
                else if (p_btnD == 1 && registered_as_one_press_flag == 1) begin
                    if (total_seconds > 0 ) begin
                        total_seconds <= total_seconds - 1;
                        registered_as_one_press_flag <= 0;   
                    end      
                end
                else if (p_btnU == 0 && p_btnD == 0) begin
                    registered_as_one_press_flag <= 1;
                end
            end
        end    
        else begin //locked_flag is one, hence we cant adjust the time anymore and the music starts playing
            if (total_seconds > 0 ) begin //boundary for total_seconds so that it does not decrement below 0
                count_down_timer <= (count_down_timer == 100000000) ? 0 : count_down_timer + 1; //counts to every 1 sec
                total_seconds <= (count_down_timer == 0) ? total_seconds - 1 : total_seconds;  // every sec, the total seconds displayed on the sevens seg decrements
            end
        end
    end
   
     

    reg [7:0] zero_seg = 8'b11000000;
    reg [3:0] zero_an = 4'b0000;
       
    reg [7:0] one_seg_R = 8'b11111001;
    reg [3:0] one_an = 4'b1110;
   
    reg [7:0] two_seg_R = 8'b10100100;
    reg [3:0] two_an = 4'b1110;   
   
    reg [7:0] three_seg_R = 8'b10110000;
    reg [3:0] three_an = 4'b1110;
   
    reg [7:0] four_seg_R = 8'b10011001;
    reg [3:0] four_an = 4'b1110;
   
    reg [7:0] five_seg_R = 8'b10010010;
    reg [3:0] five_an = 4'b1110;
           
    reg [7:0] six_seg_R = 8'b10000010;
    reg [3:0] six_an = 4'b1110;
   
    reg [7:0] seven_seg_R = 8'b11111000;
    reg [3:0] seven_an = 4'b1110;
   
    reg [7:0] eight_seg_R = 8'b10000000;
    reg [3:0] eight_an = 4'b1110;
   
    reg [7:0] nine_seg_R = 8'b10011000;
    reg [3:0] nine_an = 4'b1110;
   
    reg [7:0] ten_seg_L = 8'b11111001;
    reg [7:0] ten_seg_R = 8'b11000000;
    reg [3:0] ten_an = 4'b1100;
       
    reg [7:0] eleven_seg_L = 8'b11111001;
    reg [7:0] eleven_seg_R = 8'b11111001;
    reg [3:0] eleven_an = 4'b1100;
   
    reg [7:0] twelve_seg_L = 8'b11111001;
    reg [7:0] twelve_seg_R = 8'b10100100;
    reg [3:0] twelve_an = 4'b1100;
   
    reg [7:0] thirteen_seg_L = 8'b11111001;
    reg [7:0] thirteen_seg_R = 8'b10110000;
    reg [3:0] thirteen_an = 4'b1100;
   
    reg [7:0] fourteen_seg_L = 8'b11111001;
    reg [7:0] fourteen_seg_R = 8'b10011001;
    reg [3:0] fourteen_an = 4'b1100;
   
    reg [7:0] fifteen_seg_L = 8'b11111001;
    reg [7:0] fifteen_seg_R = 8'b10010010;
    reg [3:0] fifteen_an = 4'b1100;
   
    reg [7:0] sixteen_seg_L = 8'b11111001;
    reg [7:0] sixteen_seg_R = 8'b10000010;
    reg [3:0] sixteen_an = 4'b1100;
   
    reg [7:0] seventeen_seg_L = 8'b11111001;
    reg [7:0] seventeen_seg_R = 8'b11111000;
    reg [3:0] seventeen_an = 4'b1100;
   
    reg [7:0] eighteen_seg_L = 8'b11111001;
    reg [7:0] eighteen_seg_R = 8'b10000000;
    reg [3:0] eighteen_an = 4'b1100;
   
    reg [7:0] nineteen_seg_L = 8'b11111001;
    reg [7:0] nineteen_seg_R = 8'b10011000;
    reg [3:0] nineteen_an = 4'b1100;
   
    reg [7:0] twenty_seg_L = 8'b10100100;
    reg [7:0] twenty_seg_R = 8'b11000000;
    reg [3:0] twenty_an = 4'b1100;
   
    reg [7:0] twentyone_seg_L = 8'b10100100;
    reg [7:0] twentyone_seg_R = 8'b11111001;
    reg [3:0] twentyone_an = 4'b1100;
   
    reg [7:0] twentytwo_seg_L = 8'b10100100;
    reg [7:0] twentytwo_seg_R = 8'b10100100;
    reg [3:0] twentytwo_an = 4'b1100;
   
    reg [7:0] twentythree_seg_L = 8'b10100100;
    reg [7:0] twentythree_seg_R = 8'b10110000;
    reg [3:0] twentythree_an = 4'b1100;
   
    reg [7:0] twentyfour_seg_L = 8'b10100100;
    reg [7:0] twentyfour_seg_R = 8'b10011001;
    reg [3:0] twentyfour_an = 4'b1100;
   
    reg [7:0] twentyfive_seg_L = 8'b10100100;
    reg [7:0] twentyfive_seg_R = 8'b10010010;
    reg [3:0] twentyfive_an = 4'b1100;
   
   
   
    reg [3:0] temp_an;
    assign an = (sw[0] == 1) ? temp_an : 4'b1111;    
       
    reg [7:0] temp_seg;
    assign seg = (sw[0] == 1) ? temp_seg : 8'b11111111;
   
    
    reg display_flag = 0;
    reg [31:0] display_counter = 0;
    always @ (posedge basys_clock) begin
        display_counter <= (display_counter == 800000) ? 0 : display_counter + 1;
        if (display_counter == 0) begin
            if (total_seconds == 0) begin
                temp_seg <= zero_seg;
                temp_an <= zero_an;
            end
   
            if (total_seconds == 1) begin
                temp_seg <= one_seg_R;
                temp_an <= one_an;
            end
   
            if (total_seconds == 2) begin
                temp_seg <= two_seg_R;
                temp_an <= two_an;
            end
   
            if (total_seconds == 3) begin
                temp_seg <= three_seg_R;
                temp_an <= three_an;
            end
   
            if (total_seconds == 4) begin
                temp_seg <= four_seg_R;
                temp_an <= four_an;
            end
   
            if (total_seconds == 5) begin
                temp_seg <= five_seg_R;
                temp_an <= five_an;
            end
   
            if (total_seconds == 6) begin
                temp_seg <= six_seg_R;
                temp_an <= six_an;
            end
   
            if (total_seconds == 7) begin
                temp_seg <= seven_seg_R;
                temp_an <= seven_an;
            end
   
            if (total_seconds == 8) begin
                temp_seg <= eight_seg_R;
                temp_an <= eight_an;
            end
   
            if (total_seconds == 9) begin
                temp_seg <= nine_seg_R;
                temp_an <= nine_an;
            end
   
            if (total_seconds == 10) begin
                if (display_flag == 0) begin
                    temp_seg <= ten_seg_L;
                    temp_an <= 4'b1101;
                end
                else begin
                    temp_seg <= ten_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;    
            end
   
            if (total_seconds == 11) begin
                if (display_flag == 0) begin
                    temp_seg <= eleven_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= eleven_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 12) begin
                if (display_flag == 0) begin
                    temp_seg <= twelve_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= twelve_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 13) begin
                if (display_flag == 0) begin
                    temp_seg <= thirteen_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= thirteen_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 14) begin
                if (display_flag == 0) begin
                    temp_seg <= fourteen_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= fourteen_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 15) begin
                if (display_flag == 0) begin
                    temp_seg <= fifteen_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= fifteen_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 16) begin
                if (display_flag == 0) begin
                    temp_seg <= sixteen_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= sixteen_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 17) begin
                if (display_flag == 0) begin
                    temp_seg <= seventeen_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= seventeen_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 18) begin
                if (display_flag == 0) begin
                    temp_seg <= eighteen_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= eighteen_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 19) begin
                if (display_flag == 0) begin
                    temp_seg <= nineteen_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= nineteen_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 20) begin
                if (display_flag == 0) begin
                    temp_seg <= twenty_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= twenty_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 21) begin
                if (display_flag == 0) begin
                    temp_seg <= twentyone_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= twentyone_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 22) begin
                if (display_flag == 0) begin
                    temp_seg <= twentytwo_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= twentytwo_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 23) begin
                if (display_flag == 0) begin
                    temp_seg <= twentythree_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= twentythree_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 24) begin
                if (display_flag == 0) begin
                    temp_seg <= twentyfour_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= twentyfour_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
   
            if (total_seconds == 25) begin
                if (display_flag == 0) begin
                    temp_seg <= twentyfive_seg_L;
                    temp_an <= 4'b1101;        
                end
                else begin
                    temp_seg <= twentyfive_seg_R;
                    temp_an <= 4'b1110;
                end
                display_flag <= ~display_flag;
            end
        end
    end
endmodule
