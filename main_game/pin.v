//module pin(SW, LEDR, KEY, CLOCK_50);
//input[9:0]SW;
//output[9:0]LEDR;
//input[3:0]KEY;
//input CLOCK_50;
//
//wire[3:0]aim;
//assign aim [3:0] = SW[3:0];
//wire[2:0]power;
//assign power[2:0] = SW[6:4];
//wire[2:0]rand;
//assign rand[2:0] = SW[9:7];
//wire hit, clock, miss;
//wire [1:0] counter;
//assign LEDR[0] = hit;
//assign LEDR[2] = miss;
//assign LEDR[3] = (counter == 2'b10);
//
//onesecclock U2(KEY[0], CLOCK_50, clock);
//
//pinFSM U1(aim, power, rand, clock, hit, miss, KEY[1], CLOCK_50, counter);
//defparam U1.pin_pos = 4'b0001;


//make default of power = 0 - if power is 0 in pin fsm, make

//


//endmodule

//module gamecounter(hit, miss, roundrst, gamerst);
//input hit, miss;
//output roundrst, gamerst;
//
//
//endmodule

module pinFSM(aim, power, rand, bbclock, hit, miss, reset, CLOCK_50, counter);
input CLOCK_50;
parameter [3:0] pin_pos = 4'b0001;
input[3:0]aim;
input[2:0]power;
input[2:0]rand; //randomly generated power target
input bbclock,reset;
output reg hit, miss;
reg[1:0] nstate, pstate;
output reg[1:0] counter;
reg test;
wire aimhit, powerhit;
//calculations for power and aim buffer
assign aimhit = (aim < pin_pos) ? ((0 < (pin_pos-aim)) & ((pin_pos-aim) <  4'b0010) | (pin_pos - aim) ==  4'b0010) : ((0 < (aim - pin_pos)) & ((aim-pin_pos) <  4'b0010) | (aim - pin_pos) ==  4'b0010 | (aim - pin_pos) == 0);
assign powerhit = (power < rand) ? ((0 < (rand-power)) & ((rand-power) < 3'b001)| (rand - power) == 3'b001 ) : ((0 < (power - rand)) & ((power - rand) < 3'b001) | (power - rand) == 3'b001 | (power - rand) == 0);

//fsm to determine state of pin
parameter phit = 2'b01; parameter pwait = 2'b00; parameter pmiss = 2'b10;


always @(posedge bbclock) begin
if (hit)
begin
      if (counter < 2'b10)
      //delay blackbox output by two seconds
      counter <= counter + 1;
end
else
counter <= 0;
end

always@(posedge CLOCK_50) begin
if(!reset)
pstate <= pwait;

else
pstate <= nstate;
end


//case statements
always @(*)
case(pstate)

pwait: begin
if(reset)begin
      nstate <= pwait;
      miss <= 0;
      hit <= 0;
      test <=0;
      end
else begin
      if(aimhit & powerhit)begin // if both conditions are satisfied go to phit state
      nstate <= phit;
      miss <= 1'b0;
      hit <= 1'b1;
      test <=0;
      end
      else
            begin
      nstate <= pmiss;
      miss <= 1'b1;
      hit <= 1'b0;
      test <=0;
      end
      end
end

phit: begin // send out hit (controls black box at posedge, increments counter at posedge needs to stay in phit state until reset
if(reset)begin
nstate <= pwait;
miss <= 0;
hit <= 0;
test <=0;
end
else
begin
nstate <= phit;
hit <=1'b1;
miss <= 0;
test <=0;
end
end

pmiss: begin
if(reset) begin
nstate <= pwait;
miss <= 0;
hit <= 0;
test <=0;
end
else begin
      if(aimhit & powerhit)begin // if both conditions are satisfied go to phit state
      nstate <= phit;
      hit <= 1'b1;
      miss <=0;
      test <=0;
      end
      else
      begin
      nstate <= pmiss;
      hit <= 1'b0;
      miss <= 1'b1;
      test <=0;
      end
end
end
default: begin
test <=1;
nstate <= pwait;
miss <=1'b0;
hit <= 1'b0;
end

endcase

endmodule


//module onesecclock(KEY, CLOCK_50, enable); //counter input taken out
//input KEY;
//
//input CLOCK_50;
////output reg[4:0] counter = 4'b0000;
//output reg enable;
//reg[25:0]fastcounter = 26'd50000000;
//
//
//always @(posedge CLOCK_50)
//
//begin
//      if (fastcounter == 0)
//      enable <= 1;
//      
//      if (KEY == 0 | enable == 1)
//      begin
//      fastcounter <= 26'd50000000;
//      enable <= 0;
//      end
//      
//      else
//      fastcounter<= fastcounter - 1;
//      
//      //if (enable ==1)
//      //counter <= counter + 4'b0001;
//      //if (counter == 4'b0101)
//      //counter <= 4'b0000;
//end
//endmodule
