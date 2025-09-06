//module power(KEY, LEDR, CLOCK_50);
//input [2:0]KEY;
//input CLOCK_50;
//output[3:0]LEDR;
//wire [2:0] pow_lvl;
//wire hlfsec;
//wire [3:0] counter;
//halfsec_counter U1(KEY[0], CLOCK_50, hlfsec, counter);
//
//assign LEDR[0] = (pow_lvl == 3'b001 | pow_lvl == 3'b010 | pow_lvl == 3'b011 | pow_lvl == 3'b100);
//assign LEDR[1] = (pow_lvl == 3'b010 | pow_lvl == 3'b011 | pow_lvl == 3'b100);
//assign LEDR[2] = (pow_lvl == 3'b011 | pow_lvl == 3'b100);
//assign LEDR[3] = (pow_lvl == 3'b100);
//
//powerFSM(~KEY[0], KEY[2], hlfsec, pow_lvl);
//
//endmodule

module powerFSM(enable, reset, hlfsec, pow_lvl);
input enable, reset, hlfsec;
reg[2:0] pstate;
output reg [2:0] pow_lvl;

parameter one = 3'b001; parameter two = 3'b010; parameter three = 3'b011; parameter four = 3'b100;


reg[2:0]  nstate;
always @(posedge hlfsec) begin
case(pstate)

one:begin
if(enable)
nstate<=two;
else
nstate<=one;
end

two:begin
if(enable)
nstate<=three;
else
nstate<=two;
end

three:begin
if(enable)
nstate<=four;
else
nstate<=three;
end

four:begin
if(enable)
nstate<=one;
//
else
nstate<=(four);
end

default: begin
nstate<=one;
end
endcase
end

always@(posedge hlfsec) begin
if(!reset)
pstate <= one;

else
pstate <= nstate;
end

always @(posedge hlfsec) begin
pow_lvl <= pstate;
end
endmodule


//module halfsec_counter(KEY, CLOCK_50, enable, counter);
//
//input KEY;
//
//input CLOCK_50;
//output reg[4:0] counter = 4'b0000;
//output reg enable;
//reg[24:0]fastcounter = 25'd25000000;
//
//
//always @(posedge CLOCK_50)
//
//begin
//      if (fastcounter == 0)
//      enable <= 1;
//      
//      if (KEY == 1 | enable == 1)
//      begin
//      fastcounter <= 25'd25000000;
//      enable <= 0;
//      end
//      
//      else
//      fastcounter<= fastcounter - 1;
//      
//      if (enable ==1)
//      counter <= counter + 4'b0001;
//      if (counter == 4'b0101)
//      counter <= 4'b0000;
//end
//
//endmodule
