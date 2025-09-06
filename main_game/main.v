//do round reset- under what conditions will you reset everything back to the original state except for the score
// game reset will be done automatically- as soon as you exit the loop, score goes down to 0
// how will you sequence everything in the game
//e.g choose aim before power, choose power, release power, have a short delay, have pins disappear

module main(CLOCK_50, KEY, SW, LEDR);
//organizational keys

//KEY[0] reset for ALL the clocks used in this game
//KEY[1] press down for aim selection
//SW[1] push up to go left in aim
//SW[2] push up to go right in aim
//SW[3] for aim reset  
//KEY[2] hold down for power selection
//skip SW[0] for now
//SW[4] reset for power

input CLOCK_50;
input [3:0] KEY;      
input [9:0] SW;
output [9:0]LEDR;

wire hlfsec_enable, onesec_enable, hit, miss;
wire[4:0] hlf_counter;
wire[3:0] x_pos;
wire[2:0] pow_lvl;
wire[1:0]pin_counter;
wire[4:0] score;
//random target number
reg [2:0] rand_target;

//psuedorandom code?

always @(posedge CLOCK_50 or negedge KEY[0]) begin
	if(!KEY[0])
		rand_target <= 3'b010;
	else if(round_reset)
		rand_target[0] <= rand_target[2];
		rand_target[1] <= rand_target[0];
		rand_target[2] <= rand_target[1];
end

//always @(*) begin //maybe should be posedge round reset?
//rand_target <= $urandom%4;
//end

reg game_reset;
reg round_reset;
reg[1:0] game_state;

parameter aimpower = 2'b00;
parameter calculate = 2'b01;
parameter update_game = 2'b10

//the two clocks we are using
halfsec_counter U1(KEY[2], CLOCK_50, hlfsec_enable, hlf_counter); //hlfsec feeds into the power fsm
//hlfsec is not enable 
onesecclock U2(KEY[0], CLOCK_50, onesec_enable); //clock feeds into the pin fsm

//the parts of the game 
arrowFSM aimer(KEY[1], SW[3], SW[1], SW[2], x_pos);
//x_pos can be 1-9, sent as a 4-bit signal of that number in binary
powerFSM powerer(hlfsec_enable, SW[4], hlfsec, pow_lvl);
pinFSM pinner(x_pos, pow_lvl, rand_target, onesec_enable, hit, miss, reset, CLOCK_50, pin_counter); //rset to switch?
scorecounter counterer(CLOCK_50, hit, reset, score, HEX1, HEX0); //change reset to a switch?

//how do i do this

endmodule
