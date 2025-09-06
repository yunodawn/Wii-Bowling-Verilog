module randnum(KEY, LEDR);
    input [0:0] KEY;
    output reg [2:0] LEDR;
    
    reg [2:0] rand_target;
	 initial begin
        rand_target = 3'b001;
    end
    
    always @(negedge KEY[0]) begin
		if(rand_target >= 3'b100) begin
         rand_target <= 3'b001; 
		  end
        
		  else begin
//            rand_target[0] <= rand_target[2];
//            rand_target[1] <= rand_target[0];
//            rand_target[2] <= rand_target[1] ^ rand_target[2];
				  rand_target <= $urandom%4;
        end
		  LEDR = (rand_target % 4) + 1'b1;
    end
 
    
endmodule

module end_detector(hit, miss, total, ult_total, round_reset, game_reset);
input hit, miss;
reg total, ult_total;
output reg round_reset, game_reset;

always @(posedge hit || posedge miss) begin
	if(ult_total % 5 == 0 && ult_total != 0) begin
	total <= 0;
	ult_total <= ult_total + 1'b1;
	round_reset <= 1;
	end
	
	if(ult_total >= 5'd30) begin
	game_reset <= 1;
	end
	
	else begin
	ult_total <= ult_total + 1'b1;
	total <= total + 1'b1;
	round_reset <= 0;
	game_reset <= 0;
	end

	end
endmodule

module strike_spare(x_pos, pow_lvl, all_blackbox, strike, spare, round_reset);
input [3:0] x_pos;
input[2:0] pow_lvl;
output round_reset, all_blackbox;

assign strike = (x_pos == 4'd5 && pow_lvl == 3'd4);

assign round_reset = strike;
assign all_blackbox = strike; //come back to change
endmodule
