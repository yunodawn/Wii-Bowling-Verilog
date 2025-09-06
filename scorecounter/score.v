module score(KEY, SW, score_reg, HEX0, HEX1, CLOCK_50); //replaced hit with KEy and added switch
input CLOCK_50;   
input [0:0] KEY;
input[0:0]SW;                         
output [4:0] score_reg; //max score is 10 x 3 = 30 - 5 bits
output [6:0] HEX0, HEX1;

scunt U1(KEY[0], SW[0], score_reg, HEX1[6:0], HEX0[6:0], CLOCK_50);      

endmodule

module scunt(hit, reset, score_reg, HEX1, HEX0, CLOCK_50);

input CLOCK_50;
input hit, reset;               
//output reg [4:0] score; //max score is 10 x 3 = 30 - 5 bits
output reg[6:0] HEX0, HEX1;
//reg[6:0] hex0sig, hex1sig;
output reg [4:0] score_reg;

//assign HEX0[6:0] = hex0sig[6:0];
//assign HEX1[6:0] = hex0sig[6:0];

always @(posedge hit) begin
	if (reset) begin
		score_reg <= 5'b00000;  // start of game
   end 
		  
	else begin
		score_reg <= score_reg + 1'b1;
    end
end

reg [3:0] ones;
reg [1:0] tens;

//for seven segments
always @(*) begin
//    // all off
   ones <= score_reg % 10;
   tens <= score_reg / 10;
    
    // display ones 
    case(ones)
        4'd0: HEX0 <= 7'b1000000; 
        4'd1: HEX0 <= 7'b1111001; 
        4'd2: HEX0 <= 7'b0100100; 
        4'd3: HEX0 <= 7'b0110000;
        4'd4: HEX0 <= 7'b0011001;
        4'd5: HEX0 <= 7'b0010010;
        4'd6: HEX0 <= 7'b0000010;
        4'd7: HEX0 <= 7'b1111000;
        4'd8: HEX0 <= 7'b0000000;
        4'd9: HEX0 <= 7'b0010000;
        default: HEX0 <= 7'b1111111;
    endcase
    
    // display tens
    case(tens)
        2'd0: HEX1 <= 7'b1000000;
        2'd1: HEX1 <= 7'b1111001;
        2'd2: HEX1 <= 7'b0100100;
        2'd3: HEX1 <= 7'b0110000;
        default: HEX1 <= 7'b1111111;
    endcase
end
endmodule


