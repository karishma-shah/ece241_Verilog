//this is a memory address decoder for 3 inputs and 2^3 outputs, outputs are 'one-hot' ~ only 1 output is on
//Truth Table:
//A2  A1  A0  | R7  R6  R5  R4  R3  R2  R1  R0
//0   0   0   | 0   0   0   0   0   0   0   1
//0   0   1   | 0   0   0   0   0   0   1   0
//0   1   0   | 0   0   0   0   0   1   0   0
//0   1   1   | 0   0   0   0   1   0   0   0
//1   0   0   | 0   0   0   1   0   0   0   0
//1   0   1   | 0   0   1   0   0   0   0   0
//1   1   0   | 0   1   0   0   0   0   0   0
//1   1   1   | 1   0   0   0   0   0   0   0

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
	top u1(SW, LEDR);

endmodule

module top(SW, LEDR);
    input [9:0] SW;
    output [9:0] LEDR;

    address_decoder v1 (SW[2:0], LEDR[7:0]);

endmodule

module address_decoder (address, row);
    input [2:0] address;
    output reg [7:0] row;

    always@(*)
        begin
            row = 8'b00000000;
            case (address)
                3'b000 : row[7] = 1;
                3'b001 : row[6] = 1;
                3'b010 : row[5] = 1;
                3'b011 : row[4] = 1;
                3'b100 : row[3] = 1;
                3'b101 : row[2] = 1;
                3'b110 : row[1] = 1;
                3'b111 : row[0] = 1;
                default row = 8'b0;
            endcase
        end
endmodule
