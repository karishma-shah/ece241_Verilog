`timescale 1ns / 1ps
`default_nettype none

// DE1_SoC board needs the below main module

module main	(
	input wire CLOCK_50,            //On Board 50 MHz
	input wire [9:0] SW,            // On board Switches
	input wire [3:0] KEY,           // On board push buttons
	output wire [6:0] HEX0,         // HEX displays
	output wire [6:0] HEX1,
	output wire [6:0] HEX2,
	output wire [6:0] HEX3,
	output wire [6:0] HEX4,
	output wire [6:0] HEX5,
	output wire [9:0] LEDR,         // LEDs
	output wire [7:0] x,            // VGA pixel coordinates
	output wire [6:0] y,
	output wire [2:0] colour,       // VGA pixel colour (0-7)
	output wire plot,               // Pixel drawn when this is pulsed
	output wire vga_resetn      	// VGA resets to black when this is pulsed (NOT CURRENTLY AVAILABLE)
);
	top v1(SW, LEDR);

endmodule

// Top Module

module top(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;

	counter_4_bit u1 (.clock(SW[9]), .enable(SW[0]), .resetn(SW[8]), .freshdata(SW[7:5]), .load(SW[2]), .q(LEDR[3:0]));

endmodule

module counter_4_bit (clock, enable, resetn, freshdata, load, q);
    input clock, enable, resetn, load;
    input [3:0] freshdata;
    output reg [3:0] q;

    always@(posedge clock)
        begin
	    if (resetn == 0) //active low, synchronous reset
                q <= 0;
	    else if (load == 1)
		q <= freshdata; //parallel load
            else if (enable == 1)
                q <= q + 1; //counts up by 1 at clock edge
        end
endmodule
