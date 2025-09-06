//module arrow(KEY, CLOCK_50, SW, LEDR);
//input [0:0]KEY;
//input [2:0]SW;
//output[9:0]LEDR;
//input CLOCK_50;
//
//wire [3:0]x_pos;
//
////halfsec_counter naur(SW[1], CLOCK_50, enable);
//arrowFSM ar(KEY[0], SW[2], SW[1], SW[0], x_pos);
//
//assign LEDR[0] = (x_pos == 4'b0001);
//assign LEDR[1] = (x_pos == 4'b0010);
//assign LEDR[2] = (x_pos == 4'b0011);
//assign LEDR[3] = (x_pos == 4'b0100); 
//assign LEDR[4] = (x_pos == 4'b0101);
//assign LEDR[5] = (x_pos == 4'b0110);
//assign LEDR[6] = (x_pos == 4'b0111);
//assign LEDR[7] = (x_pos == 4'b1000);
//assign LEDR[8] = (x_pos == 4'b1001);
//
//endmodule
//////////////////////////////////////////////////


////////////////////////////////////////////////////////
//module arrow(enable, left, right, CLOCK_50, LEDR);
//input [1:0]KEY;
////input [2:0]SW;
//output[9:0]LEDR;
//
//wire [3:0]x_pos;
//
////halfsec_counter naur(SW[1], CLOCK_50, enable);
//arrowmux ar( KEY[1], KEY[0], x_pos);
//
//assign LEDR[0] = (x_pos == 4'b0001);
//assign LEDR[1] = (x_pos == 4'b0010);
//assign LEDR[2] = (x_pos == 4'b0011);
//assign LEDR[3] = (x_pos == 4'b0100); 
//assign LEDR[4] = (x_pos == 4'b0101);
//assign LEDR[5] = (x_pos == 4'b0110);
//assign LEDR[6] = (x_pos == 4'b0111);
//assign LEDR[7] = (x_pos == 4'b1000);
//assign LEDR[8] = (x_pos == 4'b1001);
//
//endmodule
//////////////////////////////////////////////////

//module halfsec_counter(KEY, CLOCK_50, enable);
//input KEY;
//
//input CLOCK_50;
//output reg enable;
//reg[24:0]fastcounter = 25'd25000000;
//
//
//always @(posedge CLOCK_50) begin
//	if (fastcounter == 0)
//	enable <= 1;
//	else if (KEY == 0 | enable == 1)
//	begin
//	fastcounter <= 25'd25000000;
//	enable <= 0;
//	end
//	else
//	fastcounter<= fastcounter - 1;
//end
//endmodule


////////////////////////////////////////////////////////
module arrowmux(enable, direction, CLOCK_50, x_pos);
input [7;0] direction;
input enable;
output reg[3:0] x_pos = 4'd5;

always@(posedge CLOCK_50) begin
if (enable) begin
	if (direction == 8'h1C)begin
		if (x_pos == 0)
		x_pos <= x_pos;
		else
		x_pos <= x_pos -1;
	end
	if (direction == 8'h23)begin
		if (x_pos == 4'd9)
		x_pos <= x_pos;
		else
		x_pos <= x_pos + 1;
		end
	end
end

endmodule

//module arrowFSM(clk, reset, left, right, x_pos);
//input clk, reset, left, right;
//output reg[3:0] x_pos;
//
//parameter one = 4'b0001; parameter two = 4'b0010; parameter three = 4'b0011; parameter four = 4'b0100; parameter five = 4'b0101; parameter six = 4'b0110; parameter seven = 4'b0111; parameter eight = 4'b1000; parameter nine = 4'b1001;
//
//reg[3:0] nstate;
//always @(*) begin
//case(x_pos)
//
//	one:begin
//	if(left)
//	nstate<=one;
//	else if(right)
//	nstate<=two;
//	end
//	
//	two:begin
//	if(left)
//	nstate<=one;
//	else if(right)
//	nstate<=three;
//	end
//	
//	three:begin
//	if(left)
//	nstate<=two;
//	else if(right)
//	nstate<=four;
//	end
//	
//	four:begin
//	if(left)
//	nstate<=three;
//	else if(right)
//	nstate<=(five);
//	end
//	
//	five:begin
//	if(left)
//	nstate<=four;
//	else if(right)
//	nstate<=six;
//	end
//	
//	six:begin
//	if(left)
//	nstate<=five;
//	else if(right)
//	nstate<=seven;
//	end
//	
//	seven:begin
//	if(left)
//	nstate<=six;
//	else if(right)
//	nstate<=eight;
//	end
//	
//	eight:begin
//	if(left)
//	nstate<=seven;
//	else if(right)
//	nstate<=nine;
//	end
//	
//	nine:begin
//	if(left)
//	nstate<=eight;
//	else if(right)
//	nstate<=nine;
//	end
//	
//	default: begin
//	nstate<=five;
//	end
//	
//endcase
//end
//
//always@(posedge clk) begin
//	if(!reset)
//	x_pos<=five;
//	
//	else
//	x_pos <= nstate;
//end
//endmodule
