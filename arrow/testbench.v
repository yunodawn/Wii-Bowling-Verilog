`timescale 1ns / 1ps

module testbench();

    // Parameters
    parameter CLOCK_PERIOD = 10;  // Clock period in ns

    // Signals
    reg [2:0] SW;  // Switch inputs
    reg [0:0] KEY; // Key input (reset)
    reg CLOCK_50;   // 50 MHz clock
    wire [9:0] LEDR;  // LED output

    // Clock generation
    initial begin
        CLOCK_50 = 0; // Initialize clock
    end
    
    always begin
        #((CLOCK_PERIOD) / 2) CLOCK_50 = ~CLOCK_50;  // Toggle clock
    end

    // Test sequence
    initial begin
        // Initialize inputs
        KEY = 1'b1;   // KEY[0] is initially high (no reset)
        SW = 3'b000;  // Initial position is at the first state (x_pos = 1)

        // Monitor changes to LEDs
        $monitor("At time %t, x_pos = %d, LEDR = %b", $time, SW, LEDR);

        // Apply test stimulus
        #10 SW = 3'b001; // Set left to high, move left
        #20 SW = 3'b100; // Set right to high, move right
        #30 SW = 3'b010; // Test middle position (no movement)
        #40 SW = 3'b011; // Move right again
        #50 SW = 3'b101; // Set left to high, move left
        #60 SW = 3'b000; // Reset to initial state
        #100 KEY = 1'b0;  // Trigger reset
        #110 KEY = 1'b1;  // Release reset
    end

    // Instantiate the arrow module
    arrow UUT (
        .KEY(KEY),
        .CLOCK_50(CLOCK_50),
        .SW(SW),
        .LEDR(LEDR)
    );

endmodule


//original pasted here

//`timescale 1ns / 1ps
//
//module testbench ( );
//
//	parameter CLOCK_PERIOD = 10;
//
//    reg [1:0] SW;
//    reg [0:0] KEY;
//    wire [9:0] LEDR;
//
//	initial begin
//        KEY[0] <= 1'b0;
//	end // initial
//	always @ (*)
//	begin : Clock_Generator
//		#((CLOCK_PERIOD) / 2) KEY[0] <= ~KEY[0];
//	end
//	
//	initial begin
//        SW[0] <= 1'b0; SW[1] = 0;
//        #10 SW[0] <= 1'b1;
//        #20 SW[1] <= 1'b1;
//        #50 SW[1] <= 1'b0;
//	end // initial
//	part2 U1 (SW, KEY, LEDR);
//
//endmodule

