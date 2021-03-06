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
	top u1(SW, HEX0);

endmodule

module top (SW, HEX0);
	input [9:0] SW;
	output [6:0] HEX0;

	hexdecoder v1 (SW[3], SW[2], SW[1], SW[0], HEX0[0], HEX0[1], HEX0[2], HEX0[3], HEX0[4], HEX0[5], HEX0[6]);

endmodule

module hexdecoder(input c0, c1, c2, c3,
						output a, b, c, d, e, f, g);

			assign a = (~c3&~c2&~c1&c0) + (~c3&c2&~c1&~c0) + (c3&~c2&c1&c0) +
							  (c3&c2&~c1&c0);
							  
			assign b = (~c3&c2&~c1&c0) + (~c3&c2&c1&~c0) + (c3&~c2&c1&c0) + 
							  (c3&c2&~c1&~c0) + (c3&c2&c1&~c0) + (c3&c2&c1&c0);
							  
			assign c = (~c3&~c2&c1&~c0) + (c3&c2&~c1&~c0) + (c3&c2&c1&~c0) + 
							  (c3&c2&c1&c0);
			
			assign d = (~c3&~c2&~c1&c0) + (~c3&c2&~c1&~c0) + (~c3&c2&c1&c0) +
							  (c3&~c2&c1&~c0) + (c3&c2&c1&c0);
			
			assign e = (~c3&~c2&~c1&c0) + (~c3&~c2&c1&c0) + (~c3&c2&~c1&~c0) +
							  (~c3&c2&~c1&c0) + (~c3&c2&c1&c0) + (c3&~c2&~c1&c0);
							  
			assign f = (~c3&~c2&~c1&c0) + (~c3&~c2&c1&~c0) + (~c3&~c2&c1&c0) +
							   (~c3&c2&c1&c0) + (c3&c2&~c1&c0);
			
			assign g = (~c3&~c2&~c1&~c0) + (~c3&~c2&~c1&c0) + (~c3&c2&c1&c0) + (c3&c2&~c1&~c0);
							  
endmodule
