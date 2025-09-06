module arrow(CLOCK_50, KEY, PS2_CLK, PS2_DAT, LEDR, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_CLK);
                        
      output [7:0] VGA_R;
      output [7:0] VGA_G;
      output [7:0] VGA_B;
      output VGA_HS;
      output VGA_VS;
      output VGA_BLANK_N;
      output VGA_SYNC_N;
      output VGA_CLK;

    assign plot = ~KEY[3];
      
      
//////POWER VGA/////
///powerbar
wire[4:0] PXC;
wire[7:0] PX;
wire[6:0] PYC, PY;
assign PX = 8'b1111011;
assign PY = 7'b1111; //15

wire PEx, PEy;
    count powerbar_X (CLOCK_50, KEY[0], PEx, PXC);    // column counter
        defparam powerbar_X.n = 5;
              defparam powerbar_X.limit = 5'b10111; // 23
    // enable XC when VGA plotting starts
    regn Penablex (1'b1, KEY[0], ps2_key_pressed, CLOCK_50, PEx);
        defparam Penablex.n = 1;
    count powerbar_Y (CLOCK_50, KEY[0], PEy, PYC);    // row counter
        defparam powerbar_Y.n = 7;
              defparam powerbar_Y.limit = 7'b1001001; //73
    // enable YC at the end of each object row
    assign PEy = (PXC == 5'b10111);
 
       regn Pregnx (PX + PXC, KEY[0], 1'b1, CLOCK_50, ROM_PX);
        defparam Pregnx.n = 8;
    regn Pregny (PY + PYC, KEY[0], 1'b1, CLOCK_50, ROM_PY);
        defparam Pregny.n = 7;      
      
wire [6:0] ROM_PX; wire [4:0] ROM_PY;
wire [2:0] ROM_Pcolours;            
powerbar Powerbar (({1'b0, PYC, 5'd0} + {1'b0, PXC}), CLOCK_50, ROM_Pcolours);//24

///////////////////////////////////charge
wire[4:0] chargeXC;
reg[7:0] chargeX;
reg[6:0] chargeY;
wire[3:0] chargeYC;
wire CEx, CEy;

    count charge_X (CLOCK_50, KEY[0], CEx, chargeXC);    // column counter
        defparam charge_X.n = 5;
              defparam charge_X.limit = 5'b10011; //19
    // enable XC when VGA plotting starts
    regn Cenablex (1'b1, KEY[0], ps2_key_pressed, CLOCK_50, CEx);
        defparam Cenablex.n = 1;
    count charge_Y (CLOCK_50, KEY[0], CEy, chargeYC);    // row counter
        defparam charge_Y.n = 4;
              defparam charge_Y.limit = 4'b1101; //13
    // enable YC at the end of each object row
    assign CEy = (chargeXC == 5'b10011);
 
       regn Cregnx (chargeX + chargeXC, KEY[0], 1'b1, CLOCK_50, ROM_chargeX);
        defparam Cregnx.n = 8;
    regn Cregny (chargeY + chargeYC, KEY[0], 1'b1, CLOCK_50, ROM_chargeY);
        defparam Cregny.n = 7;
              
 
wire [6:0] ROM_chargeX; wire [4:0] ROM_chargeY;
wire [2:0] ROM_Chargecolours;       
charge charge_ROM (({1'b0, chargeYC, 4'd0} + {1'b0, chargeYC, 3'd0} + {1'b0, chargeXC}), CLOCK_50, ROM_Chargecolours);

//////////////////////////////control functions
power powlvl((ps2_key_pressed & (ps2_key_data == 8'h29)), KEY[3], hlfsec, pow_lvl);

wire hlfsec;
wire [3:0] counter;

//create new VGA regs for each always block, can only edit one reg per always block
reg [2:0] POWER_COLOR;
reg [7:0] POWER_X;
reg [6:0] POWER_Y;
always@(posedge hlfsec)
if (ps2_key_pressed & (ps2_key_data == 8'h29))begin
case(pow_lvl)
3'b010: begin
chargeX <= 7'b1111101;//125
chargeY <= 6'b110001;  //49
POWER_COLOR <= ROM_Chargecolours;
POWER_X <= ROM_chargeX;
POWER_Y <= ROM_chargeY;
end
3'b011: begin;
chargeX <= 7'b1111101;
chargeY <= 6'b100001;//33
POWER_COLOR <= ROM_Chargecolours;
POWER_X <= ROM_chargeX;
POWER_Y <= ROM_chargeY;
end
3'b100: begin;
chargeX <= 7'b1111101;
chargeY <= 6'b10001;//17
POWER_COLOR <= ROM_Chargecolours;
POWER_X <= ROM_chargeX;
POWER_Y <= ROM_chargeY;
end
default: begins
chargeX <= 7'b1111101;
chargeY <= 7'b1000001; //65
POWER_COLOR <= ROM_Pcolours;
POWER_X <= ROM_PX;
POWER_Y <= ROM_PY;
end
endcase
end

    vga_adapter VGA (
                  .resetn(KEY[0]),
                  .clock(CLOCK_50),
                  .colour(POWER_COLOR),
                  .x(POWER_X),
                  .y(POWER_Y),
                  .plot(1'b1),
                  .VGA_R(VGA_R),
                  .VGA_G(VGA_G),
                  .VGA_B(VGA_B),
                  .VGA_HS(VGA_HS),
                  .VGA_VS(VGA_VS),
                  .VGA_BLANK_N(VGA_BLANK_N),
                  .VGA_SYNC_N(VGA_SYNC_N),
                  .VGA_CLK(VGA_CLK));
            defparam VGA.RESOLUTION = "160x120";
            defparam VGA.MONOCHROME = "FALSE";
            defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
            defparam VGA.BACKGROUND_IMAGE = "Background.mif";




// Bidirectionals
inout                   PS2_CLK;
inout                   PS2_DAT;
// Internal Wires
wire        [7:0] ps2_key_data;
wire                    ps2_key_pressed;

// Internal Registers
reg               [7:0] last_data_received;

//sequential logic
always @(posedge CLOCK_50)
begin
      if (KEY[0] == 1'b0)
            last_data_received <= 8'h00;
      else if (ps2_key_pressed == 1'b1)
            last_data_received <= ps2_key_data;
end

PS2_Controller PS2 (
      // Inputs
      .CLOCK_50                     (CLOCK_50),
      .reset                        (~KEY[0]),

      // Bidirectionals
      .PS2_CLK                (PS2_CLK),
      .PS2_DAT                (PS2_DAT),

      // Outputs
      .received_data          (ps2_key_data),
      .received_data_en (ps2_key_pressed)
);

endmodule
////////////////////////////////////////////////
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

////////////////////////////////////////////////////////
module arrowfsm(enable, direction, CLOCK_50, x_pos);
input CLOCK_50;
input [7:0] direction;
input enable;
output reg[3:0] x_pos = 4'b0101;

always@(posedge CLOCK_50) begin
if (!enable) begin
      if (direction == 8'h23)begin
            if (x_pos == 0)
            x_pos <= x_pos;
            else
            x_pos <= x_pos -1;
      end
      if (direction == 8'h1C)begin
            if (x_pos == 4'b1001)
            x_pos <= x_pos;
            else
            x_pos <= x_pos + 1;
            end
      end
      else
      x_pos <= x_pos;
end
endmodule

module regn(R, Resetn, E, Clock, Q);
    parameter n = 8;
    input [n-1:0] R;
    input Resetn, E, Clock;
    output reg [n-1:0] Q;

    always @(posedge Clock)

              if (!Resetn)
            Q <= 0;
        else if (E)
            Q <= R;
endmodule

module count (Clock, Resetn, E, Q);
    parameter n = 8;
       parameter limit = 8'b10011111;
    input Clock, Resetn, E;
    output reg [n-1:0] Q;

    always @ (posedge Clock)begin
        if (Resetn == 0)
            Q <= 0;
        else if (E)
              begin
              if
              (Q == limit) //21 -1
                               Q <= 0;
                               else
                Q <= Q + 1;
                              
                  end
                  end         
endmodule

module hex7seg (hex, display);
    input [3:0] hex;
    output [6:0] display;

    reg [6:0] display;

    /*
     *       0  
     *      ---  
     *     |   |
     *    5|   |1
     *     | 6 |
     *      ---  
     *     |   |
     *    4|   |2
     *     |   |
     *      ---  
     *       3  
     */
    always @ (hex)
        case (hex)
            4'h0: display = 7'b1000000;
            4'h1: display = 7'b1111001;
            4'h2: display = 7'b0100100;
            4'h3: display = 7'b0110000;
            4'h4: display = 7'b0011001;
            4'h5: display = 7'b0010010;
            4'h6: display = 7'b0000010;
            4'h7: display = 7'b1111000;
            4'h8: display = 7'b0000000;
            4'h9: display = 7'b0011000;
            4'hA: display = 7'b0001000;
            4'hB: display = 7'b0000011;
            4'hC: display = 7'b1000110;
            4'hD: display = 7'b0100001;
            4'hE: display = 7'b0000110;
            4'hF: display = 7'b0001110;
        endcase

endmodule
