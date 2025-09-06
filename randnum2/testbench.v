// Testbench
module randnum_tb();

// Test signals
reg CLOCK_50;
reg [0:0] KEY;
wire [2:0] LEDR;

// Instantiate the random number generator
randnum dut(
    .CLOCK_50(CLOCK_50),
    .KEY(KEY),
    .LEDR(LEDR)
);

// Clock generation
initial begin
    CLOCK_50 = 0;
    forever #5 CLOCK_50 = ~CLOCK_50;  // 100MHz clock
end

// Test stimulus
initial begin
    // Initialize signals
    KEY = 1'b0;
    
    // Test case 1: Reset
    #10 KEY = 1'b0;
    #10 KEY = 1'b1;
    
    // Test case 2: Let it run for multiple cycles
    repeat(20) @(posedge CLOCK_50);
    
    // Test case 3: Reset again
    #10 KEY = 1'b0;
    #10 KEY = 1'b1;
    
    // Test case 4: More cycles
    repeat(20) @(posedge CLOCK_50);
    
    // End simulation
    #100 $stop;
end

// Monitor changes
initial begin
    $monitor("Time=%0t KEY=%b LEDR=%b", $time, KEY, LEDR);
end

endmodule