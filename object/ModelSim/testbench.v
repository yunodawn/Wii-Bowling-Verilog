`timescale 1ns / 1ps

module testbench ( );

	parameter CLOCK_PERIOD = 20;

    reg CLOCK_50;	
	reg [7:0] SW;
	reg [3:0] KEY;
    wire [6:0] HEX3, HEX2, HEX1, HEX0;
	wire [7:0] VGA_R;
	wire [7:0] VGA_G;
	wire [7:0] VGA_B;
	wire VGA_HS;
	wire VGA_VS;
	wire VGA_BLANK_N;
	wire VGA_SYNC_N;
	wire VGA_CLK;	

	initial begin
        CLOCK_50 <= 1'b0;
	end // initial
	always @ (*)
	begin : Clock_Generator
		#((CLOCK_PERIOD) / 2) CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin
        KEY <= 4'b0;
        #20 KEY[0] <= 1'b1; // reset
	end // initial

	initial begin
        KEY[1] <= 1'b1; KEY[2] <= 1'b1; KEY[3] <= 1'b1;
        SW <= 8'b01001000;  // randomly chosen (x,y) address
        #20 KEY[1] <= 1'b0; // press to store y
        #20 KEY[1] <= 1'b1;
        #20 KEY[2] <= 1'b0; // press to store x
        #20 KEY[2] <= 1'b1;
        #20 KEY[3] <= 1'b0; // press to display (in reality would stay
                            // pressed long enough to draw the whole box
	end // initial

	vga_demo U1 (CLOCK_50, SW, KEY[3:0], HEX3, HEX2, HEX1, HEX0, VGA_R, VGA_G, VGA_B,
				VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_CLK);

endmodule
