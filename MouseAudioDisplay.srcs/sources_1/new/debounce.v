`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2023 11:50:15
// Design Name: 
// Module Name: debounce
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


module debounce(
    input clock_25MHz, 
    input btnC, 
    output reg p_btnC
    );
    
    reg [31:0] count_debouncer = 0;
    reg stable_flag = 0;
    reg temp_btnC = 1; 
    reg temp_booting_flag = 0;
    reg assign_to_p_btnC_flag = 0;

    

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
endmodule
