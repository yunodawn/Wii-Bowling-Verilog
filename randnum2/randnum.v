module randnum(KEY, LEDR);
    input [0:0] KEY;
    output reg [2:0] LEDR;
    
    reg [2:0] rand_target;
    
    always @(negedge KEY[0]) begin
        if(!KEY[0]) begin
            rand_target <= 3'b001; 
        end
        else begin
            rand_target[0] <= rand_target[2];
            rand_target[1] <= rand_target[0];
            rand_target[2] <= rand_target[1] ^ rand_target[2];
        end
		  LEDR = (rand_target % 4) + 1'b1;
    end
 
    
endmodule
