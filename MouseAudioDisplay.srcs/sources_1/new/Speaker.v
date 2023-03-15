`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2023 03:41:04 AM
// Design Name: 
// Module Name: Speaker
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


module Speaker(
    input basys_clock,
    output J1,
    output J2,
    output J3,
    output J0,
    input is_valid,
    input [3:0] digit_type
);

wire clock_50MHz, clock_20kHz, clock_190Hz, clock_380Hz, clock_25MHz;

clk_divider clk_50MHz(.basys_clk(basys_clock), .m(0), .new_clk(clock_50MHz));
clk_divider clk_20kHz(.basys_clk(basys_clock), .m(2499), .new_clk(clock_20kHz));
clk_divider clk_190Hz(.basys_clk(basys_clock), .m(263156), .new_clk(clock_190Hz));
clk_divider clk_380Hz(.basys_clk(basys_clock), .m(131577), .new_clk(clock_380Hz));
clk_divider clk_25MHz(.basys_clk(basys_clock), .m(1), .new_clk(clock_25MHz));

wire [11:0] audio_out;

Audio_Output unit_my_audio_output (
.CLK(clock_50MHz),  
.START(clock_20kHz),
.DATA1(audio_out),
.DATA2(),
.RST(0),

.D1(J1),
.D2(J2),
.CLK_OUT(J3),
.nSYNC(J0),
.DONE()
);

reg [11:0] temp_audio_out = 12'hFFF;
reg on_flag = 0;
assign audio_out = (on_flag == 1) ? temp_audio_out : 0;


always @ (posedge clock_190Hz) begin
    temp_audio_out <= (temp_audio_out == 12'hFFF) ? 0 : 12'hFFF;
end 


reg [31:0] count;
reg ready_flag = 1;
reg [3:0] previous_digit_type = 10; //arbitrar value, doesnt matter


always @ (posedge basys_clock) begin

    if (previous_digit_type != digit_type) begin
        ready_flag <= 1;
        previous_digit_type <= digit_type;
    end
    
    else begin
    
        if (digit_type == 0 && is_valid == 1) begin
            if (ready_flag == 1) begin
                on_flag <= 1;
                count <= 1;
                ready_flag <= 0;
            end
            else begin
                count <= (count == 10000000) ? 0 : count + 1; //0.1s
                on_flag <= (count == 0) ? 0 : on_flag;
            end
        end
    
        else if (digit_type == 1 && is_valid == 1) begin
            if (ready_flag == 1) begin
                on_flag <= 1;
                count <= 1;
                ready_flag <= 0;
            end
            else begin
                count <= (count == 20000000) ? 0 : count + 1; //0.2s
                on_flag <= (count == 0) ? 0 : on_flag;
            end        
        end
    
        else if (digit_type == 2 && is_valid == 1) begin
            if (ready_flag == 1) begin
                on_flag <= 1;
                count <= 1;
                ready_flag <= 0;
            end
            else begin
                count <= (count == 30000000) ? 0 : count + 1; //0.3s
                on_flag <= (count == 0) ? 0 : on_flag;
            end        
        end
    
        else if (digit_type == 3 && is_valid == 1) begin
            if (ready_flag == 1) begin
                on_flag <= 1;
                count <= 1;
                ready_flag <= 0;
            end
            else begin
                count <= (count == 40000000) ? 0 : count + 1; //0.4s
                on_flag <= (count == 0) ? 0 : on_flag;
            end        
        end
    
        else if (digit_type == 4 && is_valid == 1) begin
            if (ready_flag == 1) begin
                on_flag <= 1;
                count <= 1;
                ready_flag <= 0;
            end
            else begin
                count <= (count == 50000000) ? 0 : count + 1; //0.5s
                on_flag <= (count == 0) ? 0 : on_flag;
            end        
        end
    
        else if (digit_type == 5 && is_valid == 1) begin
            if (ready_flag == 1) begin
                on_flag <= 1;
                count <= 1;
                ready_flag <= 0;
            end
            else begin
                count <= (count == 60000000) ? 0 : count + 1; //0.6s
                on_flag <= (count == 0) ? 0 : on_flag;
            end        
    
        end
    
        else if (digit_type == 6 && is_valid == 1) begin
            if (ready_flag == 1) begin
                on_flag <= 1;
                count <= 1;
                ready_flag <= 0;
            end
            else begin
                count <= (count == 70000000) ? 0 : count + 1; //0.7s
                on_flag <= (count == 0) ? 0 : on_flag;
            end        
        end
    
        else if (digit_type == 7 && is_valid == 1) begin
            if (ready_flag == 1) begin
                on_flag <= 1;
                count <= 1;
                ready_flag <= 0;
            end
            else begin
                count <= (count == 80000000) ? 0 : count + 1; //0.8s
                on_flag <= (count == 0) ? 0 : on_flag;
            end        
        end
    
        else if (digit_type == 8 && is_valid == 1) begin
            if (ready_flag == 1) begin
                on_flag <= 1;
                count <= 1;
                ready_flag <= 0;
            end
            else begin
                count <= (count == 90000000) ? 0 : count + 1; //0.9s
                on_flag <= (count == 0) ? 0 : on_flag;
            end        
        end
    
        else if (digit_type == 9 && is_valid == 1) begin
            if (ready_flag == 1) begin
                on_flag <= 1;
                count <= 1;
                ready_flag <= 0;
            end
            else begin
                count <= (count == 100000000) ? 0 : count + 1; //1.0s
                on_flag <= (count == 0) ? 0 : on_flag; 
            end        
        end
        
    end
    
end
    

endmodule
