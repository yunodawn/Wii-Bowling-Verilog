`timescale 1ns / 1ps

module testbench();

    // parameters
    parameter CLOCK_PERIOD = 10;  // Clock

    // signals
    reg [2:0] SW;        
    reg [0:0] KEY;       
    reg CLOCK_50;        
    wire [3:0] LEDR;    

    // clock generation
    initial begin
        CLOCK_50 = 0; 
    end
    
    always begin
        #((CLOCK_PERIOD) / 2) CLOCK_50 = ~CLOCK_50;  
    end

    
    initial begin
        // initialize inputs
        KEY = 1'b1;   
        SW = 3'b000;  

        
        $monitor("At time %t, pow_lvl = %d, LEDR = %b", $time, SW, LEDR);

        // check FSM behavior
        #10 SW = 3'b100; // nothing happens->state 0
        #20 SW = 3'b000; //nothing happens ->0 
        #30 SW = 3'b100; // set up ->originally same code as first
        #40 SW = 3'b001; // Set down
        #50 SW = 3'b010; // Set up again 
        #60 SW = 3'b000; // Reset 
        #100 KEY = 1'b0;  // Trigger reset
        #110 KEY = 1'b1;  // Release reset
    end

    // Instantiate the power module
    power UUT (
        .KEY(KEY),
        .SW(SW),
        .LEDR(LEDR)
    );

endmodule
