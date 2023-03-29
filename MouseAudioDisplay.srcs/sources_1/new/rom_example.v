`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2023 04:34:01 PM
// Design Name: 
// Module Name: rom_example
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


module rom_example (
  input wire clk,
  input wire [7:0] address,
  output reg [7:0] data_out
);

  // Declare the BRAM
  (* ram_style = "block" *)
  reg [7:0] rom [15:0];

  // Write the ROM contents to the BRAM during initialization
  initial begin
    rom[0] = 8'h00;
    rom[1] = 8'h11;
    rom[2] = 8'h22;
    rom[3] = 8'h33;
    rom[4] = 8'h44;
    rom[5] = 8'h55;
    rom[6] = 8'h66;
    rom[7] = 8'h77;
    rom[8] = 8'h88;
    rom[9] = 8'h99;
    rom[10] = 8'hAA;
    rom[11] = 8'hBB;
    rom[12] = 8'hCC;
    rom[13] = 8'hDD;
    rom[14] = 8'hEE;
    rom[15] = 8'hFF;
  end

  // Read from the BRAM using the input address
  always @(posedge clk) begin
    data_out <= rom[address];
  end

endmodule
