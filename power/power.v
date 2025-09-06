module power(KEY, SW, LEDR);
input [0:0]KEY;
input [2:0]SW;
output[3:0]LEDR;
wire [2:0] pow_lvl;

assign LEDR[0] = (pow_lvl == 3'b001);
assign LEDR[1] = (pow_lvl == 3'b010);
assign LEDR[2] = (pow_lvl == 3'b011);
assign LEDR[3] = (pow_lvl == 3'b100);

powerFSM(KEY[0], SW[2], SW[1], SW[0], pow_lvl);

endmodule

module powerFSM(clk, reset, up, down, pow_lvl);
input clk, reset, up, down;
output reg[2:0] pow_lvl;

parameter zero = 3'b000; parameter one = 3'b001; parameter two = 3'b010; parameter three = 3'b011; parameter four = 3'b100; 

reg[2:0] nstate;
always @(*) begin
case(pow_lvl)

	zero:begin
	if(up)
	nstate<=one;
	else if(down)
	nstate<=zero;
	end
	
	one:begin
	if(up)
	nstate<=two;
	else if(down)
	nstate<=zero;
	end
	
	two:begin
	if(up)
	nstate<=three;
	else if(down)
	nstate<=one;
	end
	
	three:begin
	if(up)
	nstate<=four;
	else if(down)
	nstate<=two;
	end
	
	four:begin
	if(up)
	nstate<=four;
	else if(down)
	nstate<=(three);
	end
	
	default: begin
	nstate<=zero;
	end
	
endcase
end

always@(posedge clk) begin
	if(!reset)
	pow_lvl<=zero;
	
	else
	pow_lvl <= nstate;
end
endmodule

