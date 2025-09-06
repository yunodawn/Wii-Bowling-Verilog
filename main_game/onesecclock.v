module onesecclock(KEY, CLOCK_50, enable); //counter input taken out
input KEY;

input CLOCK_50;
//output reg[4:0] counter = 4'b0000;
output reg enable;
reg[25:0]fastcounter = 26'd50000000;


always @(posedge CLOCK_50)

begin
      if (fastcounter == 0)
      enable <= 1;
      
      if (KEY == 0 | enable == 1)
      begin
      fastcounter <= 26'd50000000;
      enable <= 0;
      end
      
      else
      fastcounter<= fastcounter - 1;
      
      //if (enable ==1)
      //counter <= counter + 4'b0001;
      //if (counter == 4'b0101)
      //counter <= 4'b0000;
end
endmodule
