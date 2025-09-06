`timescale 1ns / 1ps

module testbench ( );

	parameter CLOCK_PERIOD = 10;

    reg [1:0] SW;
    reg [0:0] KEY;
    wire [9:0] LEDR;

	initial begin
        KEY[0] <= 1'b0;
	end // initial
	always @ (*)
	begin : Clock_Generator
		#((CLOCK_PERIOD) / 2) KEY[0] <= ~KEY[0];
	end
	
	initial begin
        SW[0] <= 1'b0; SW[1] = 0;
        #10 SW[0] <= 1'b1;
        #20 SW[1] <= 1'b1;
        #50 SW[1] <= 1'b0;
	end // initial
	part2 U1 (SW, KEY, LEDR);

endmodule
