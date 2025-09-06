`timescale 1ns/1ps

module newscore_tb();
    // Declare test bench signals
    reg CLOCK_50;
    reg [0:0] KEY;
    reg [0:0] SW;
    wire [4:0] score;
    wire [6:0] HEX0, HEX1;
    
    // Instantiate the device under test (DUT)
    score dut(
        .CLOCK_50(CLOCK_50),
        .KEY(KEY),
        .SW(SW),
        .score(score),
        .HEX0(HEX0),
        .HEX1(HEX1)
    );
    
    // Clock generation
    initial begin
        CLOCK_50 = 0;
        forever #10 CLOCK_50 = ~CLOCK_50; // 50MHz clock
    end
    
    // Test stimulus
    initial begin
        // Initialize signals
        KEY[0] = 1'b1; // hit signal (active low)
        SW[0] = 1'b0;  // reset signal
        
        // Add some delay
        #100;
        
        // Test reset
        SW[0] = 1'b1;
        #20;
        SW[0] = 1'b0;
        #20;
        
        // Test hitting multiple times
        repeat(5) begin
            KEY[0] = 1'b0; // Press hit button
            #20;
            KEY[0] = 1'b1; // Release hit button
            #20;
        end
        
        // Test reset again
        SW[0] = 1'b1;
        #20;
        SW[0] = 1'b0;
        #20;
        
        // Test counting up to a higher number
        repeat(15) begin
            KEY[0] = 1'b0;
            #20;
            KEY[0] = 1'b1;
            #20;
        end
        
        // Add some delay before ending simulation
        #100;
        
        // End simulation
        $finish;
    end
    
    // Monitor changes
    initial begin
        $monitor("Time=%0t reset=%b hit=%b score=%d HEX0=%b HEX1=%b",
                 $time, SW[0], KEY[0], score, HEX0, HEX1);
    end
    
    // Optional: Check for specific conditions
    always @(posedge CLOCK_50) begin
        // Verify score doesn't exceed 30
        if (score > 30) begin
            $display("Error: Score exceeded maximum value of 30");
            $finish;
        end
        
        // Verify reset functionality
        if (SW[0] && score !== 0) begin
            $display("Error: Score not reset when reset signal is active");
            $finish;
        end
    end
    
endmodule