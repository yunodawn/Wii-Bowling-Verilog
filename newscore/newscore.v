module newscore(CLOCK_50, KEY, SW, score, HEX0, HEX1); //replaced hit with KEy and added switch
input CLOCK_50;   
input [0:0] KEY;
input[0:0]SW;                         
output [4:0] score; //max score is 10 x 3 = 30 - 5 bits
output [6:0] HEX0, HEX1;

scunt U1(CLOCK_50, KEY[0], SW[0], score, HEX1[6:0], HEX0[6:0]);      

endmodule

module scunt(CLOCK_50, hit, reset, score, HEX1, HEX0);

input CLOCK_50;         
input hit, reset;               
output reg [4:0] score; //max score is 10 x 3 = 30 - 5 bits
output [6:0] HEX0, HEX1;
reg[6:0] hex0sig, hex1sig;
reg [4:0] score_reg;

assign HEX0[6:0] = hex0sig[6:0];
assign HEX1[6:0] = hex0sig[6:0];

always @(posedge CLOCK_50 or posedge reset) begin
	if (reset) begin
		score_reg <= 5'b00000;  // start of game
   end 
		  
	else begin
		if(hit) begin
			score_reg <= score_reg + 1'b1;
		end
    end
end
    
always @(*) begin
  score <= score_reg;
end

//for seven segments
always @(*) begin
//    // all off
	reg [3:0] ones;
   reg [3:0] tens;
   ones = score_reg % 10;
   tens = score_reg / 10;
    
    // display ones 
    case(ones)
        4'd0: hex0sig = 7'b1000000; 
        4'd1: hex0sig = 7'b1111001; 
        4'd2: hex0sig = 7'b0100100; 
        4'd3: hex0sig = 7'b0110000;
        4'd4: hex0sig = 7'b0011001;
        4'd5: hex0sig = 7'b0010010;
        4'd6: hex0sig = 7'b0000010;
        4'd7: hex0sig = 7'b1111000;
        4'd8: hex0sig = 7'b0000000;
        4'd9: hex0sig = 7'b0010000;
        default: hex0sig = 7'b1111111;
    endcase
    
    // display tens
    case(tens)
        4'd0: hex1sig = 7'b1000000;
        4'd1: hex1sig = 7'b1111001;
        4'd2: hex1sig = 7'b0100100;
        4'd3: hex1sig = 7'b0110000;
        default: hex1sig <= 7'b1111111;
    endcase
end
endmodule


