//halfsec counter
module halfsec_counter(KEY, CLOCK_50, enable, counter);

input KEY;

input CLOCK_50;
output reg[4:0] counter = 4'b0000;
output reg enable;
reg[24:0]fastcounter = 25'd25000000;


always @(posedge CLOCK_50)

begin
      if (fastcounter == 0)
      enable <= 1;
      
      if (KEY == 1 | enable == 1)
      begin
      fastcounter <= 25'd25000000;
      enable <= 0;
      end
      
      else
      fastcounter<= fastcounter - 1;
      
      if (enable ==1)
      counter <= counter + 4'b0001;
      if (counter == 4'b0101)
      counter <= 4'b0000;
end

endmodule
