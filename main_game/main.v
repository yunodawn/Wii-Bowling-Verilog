module vga_demo (CLOCK_50, LEDR, KEY, PS2_CLK, PS2_DAT, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_CLK);
input CLOCK_50;
output [3:0] LEDR;
assign LEDR[0] = (pow_lvl == 3'b001 | pow_lvl == 3'b010 | pow_lvl == 3'b011 | pow_lvl == 3'b100);
assign LEDR[1] = (pow_lvl == 3'b010 | pow_lvl == 3'b011 | pow_lvl == 3'b100);
assign LEDR[2] = (pow_lvl == 3'b011 | pow_lvl == 3'b100);
assign LEDR[3] = (pow_lvl == 3'b100);
input [3:0] KEY;
output [7:0] VGA_R;
output [7:0] VGA_G;
output [7:0] VGA_B;
output VGA_HS;
output VGA_VS;
output VGA_BLANK_N;
output VGA_SYNC_N;
output VGA_CLK;
wire [7:0] XC, XC2, XC3, XC4, XC5, XC6, XC7, XC8, XC9;
wire [6:0] YC, YC2, YC3, YC4, YC5, YC6, YC7, YC8, YC9;      // used to access object memory
wire Ex, Ey, Ex2, Ey2, Ex3, Ex4, Ex5, Ex6, Ex7, Ex8, Ex9, Ey3, Ey4, Ey5, Ey6, Ey7, Ey8, Ey9;
wire [7:0] X = 8'b0;           // starting x location of object
wire [6:0] Y = 7'b0110100;           // starting y location of object
reg [7:0] VGA_X;       // x location of each object pixel
reg [6:0] VGA_Y;       // y location of each object pixel
reg [2:0] VGA_COLOR;   // color of each object pixel
	


    count U3 (CLOCK_50, KEY[0], Ex, XC);    // column counter
        defparam U3.n = 8;
		  defparam U3.limit = 8'b10011111;
    // enable XC when VGA plotting starts
    regn U5 (1'b1, KEY[0], ~ps2_key_pressed, CLOCK_50, Ex);
        defparam U5.n = 1;
    count U4 (CLOCK_50, KEY[0], Ey, YC);    // row counter
        defparam U4.n = 7;
		  defparam U4.limit = 7'b1000011;
    // enable YC at the end of each object row
    assign Ey = (XC == 8'b10011111);

    count U13 (CLOCK_50, KEY[0], Ex2, XC2);    // column counter
        defparam U13.n = 8;
		  defparam U13.limit = 8'b10011111;
    // enable XC when VGA plotting starts
    regn U15 (1'b1, KEY[0], ~ps2_key_pressed, CLOCK_50, Ex2);
        defparam U15.n = 1;
    count U14 (CLOCK_50, KEY[0], Ey2, YC2);    // row counter
        defparam U14.n = 7;
		  defparam U14.limit = 7'b1000011;
	assign Ey2 = (XC2 == 8'b10011111);

	    count countarr31 (CLOCK_50, KEY[0], Ex3, XC3);    // column counter
        defparam countarr31.n = 8;
		  defparam countarr31.limit = 8'b10011111;
    // enable XC when VGA plotting starts
    regn arr3XC (1'b1, KEY[0], ~ps2_key_pressed, CLOCK_50, Ex3);
        defparam arr3XC.n = 1;
    count countarr32 (CLOCK_50, KEY[0], Ey3, YC3);    // row counter
        defparam countarr32.n = 7;
		  defparam countarr32.limit = 7'b1000011;
    // enable YC at the end of each object row
    assign Ey3 = (XC3 == 8'b10011111);

	 

    count countarr41 (CLOCK_50, KEY[0], Ex4, XC4);    // column counter
        defparam countarr41.n = 9;
		  defparam countarr41.limit = 8'b10011111;
    // enable XC when VGA plotting starts
    regn arr4XC (1'b1, KEY[0], ~ps2_key_pressed, CLOCK_50, Ex4);
        defparam arr4XC.n = 1;
    count countarr42 (CLOCK_50, KEY[0], Ey4, YC4);    // row counter
        defparam countarr42.n = 8;
		  defparam countarr42.limit = 7'b1000011;
    // enable YC at the end of each object row
    assign Ey4 = (XC4 == 8'b10011111);

	 
	 
    count countarr51 (CLOCK_50, KEY[0], Ex5, XC5);    // column counter
        defparam countarr51.n = 9;
		  defparam countarr51.limit = 8'b10011111;
    // enable XC when VGA plotting starts
    regn arr5XC (1'b1, KEY[0], ~ps2_key_pressed, CLOCK_50, Ex5);
        defparam arr5XC.n = 1;
    count countarr52 (CLOCK_50, KEY[0], Ey5, YC5);    // row counter
        defparam countarr52.n = 8;
		  defparam countarr52.limit = 7'b1000011;
    // enable YC at the end of each object row
    assign Ey5 = (XC5 == 8'b10011111);

	 
    count countarr61 (CLOCK_50, KEY[0], Ex6, XC6);    // column counter
        defparam countarr61.n = 9;
		  defparam countarr61.limit = 8'b10011111;
    // enable XC when VGA plotting starts
    regn arr6XC (1'b1, KEY[0], ~ps2_key_pressed, CLOCK_50, Ex6);
        defparam arr6XC.n = 1;
    count countarr62 (CLOCK_50, KEY[0], Ey6, YC6);    // row counter
        defparam countarr62.n = 8;
		  defparam countarr62.limit = 7'b1000011;
    // enable YC at the end of each object row
    assign Ey6 = (XC6 == 8'b10011111);

    count countarr71 (CLOCK_50, KEY[0], Ex7, XC7);    // column counter
        defparam countarr71.n = 9;
		  defparam countarr71.limit = 8'b10011111;
    // enable XC when VGA plotting starts
    regn arr7XC (1'b1, KEY[0], ~ps2_key_pressed, CLOCK_50, Ex7);
        defparam arr7XC.n = 1;
    count countarr72 (CLOCK_50, KEY[0], Ey7, YC7);    // row counter
        defparam countarr72.n = 8;
		  defparam countarr72.limit = 7'b1000011;
    // enable YC at the end of each object row
    assign Ey7 = (XC7 == 8'b10011111);
	 
	 

    count countarr81 (CLOCK_50, KEY[0], Ex8, XC8);    // column counter
        defparam countarr81.n = 9;
		  defparam countarr81.limit = 8'b10011111;
    // enable XC when VGA plotting starts
    regn arr8XC (1'b1, KEY[0], ~ps2_key_pressed, CLOCK_50, Ex8);
        defparam arr8XC.n = 1;
    count countarr82 (CLOCK_50, KEY[0], Ey8, YC8);    // row counter
        defparam countarr82.n = 8;
		  defparam countarr82.limit = 7'b1000011;
    // enable YC at the end of each object row
    assign Ey8 = (XC8 == 8'b10011111);



    count countarr91 (CLOCK_50, KEY[0], Ex9, XC9);    // column counter
        defparam countarr91.n = 8;
		  defparam countarr91.limit = 8'b10011111;
    // enable XC when VGA plotting starts
    regn arr9XC (1'b1, KEY[0], ~ps2_key_pressed, CLOCK_50, Ex9);
        defparam arr9XC .n = 1;
    count countarr92 (CLOCK_50, KEY[0], Ey9, YC9);    // row counter
        defparam countarr92.n = 7;
		  defparam countarr92.limit = 7'b1000011;
    // enable YC at the end of each object row
    assign Ey9 = (XC9 == 8'b10011111);	 
		  	
		  
   object_mem U6 (YC,XC, CLOCK_50, ROM_colour1);
	 arrows2 arrow2 (YC2,XC2, CLOCK_50, ROM_colour2);
	 arrows3 arrow3 (YC3,XC3, CLOCK_50, ROM_colour3);
	 arrows4 arrow4 (YC4,XC4, CLOCK_50, ROM_colour4);
	 arrows5 arrow5 (YC5,XC5, CLOCK_50, ROM_colour5);
	 arrows6 arrow6 (YC6,XC6, CLOCK_50, ROM_colour6);
	 arrows7 arrow7 (YC7,XC7, CLOCK_50, ROM_colour7);
	 arrows8 arrow8 (YC8,XC8, CLOCK_50, ROM_colour8);
	 arrows9 arrow9 (YC9,XC9, CLOCK_50, ROM_colour9);
	 
	 wire [2:0] ROM_colour1; wire [2:0] ROM_colour3; wire [2:0] ROM_colour5; wire [2:0] ROM_colour7; wire [2:0] ROM_colour9;
	 wire [2:0] ROM_colour2; wire [2:0] ROM_colour4; wire [2:0] ROM_colour6; wire [2:0] ROM_colour8; 
		  wire [8:0] ROM_X1, ROM_X2; wire [8:0] ROM_X3, ROM_X4; wire [8:0] ROM_X5, ROM_X6; wire [8:0] ROM_X7, ROM_X8; wire [8:0] ROM_X9;
		  wire [7:0] ROM_Y1, ROM_Y2; wire [7:0] ROM_Y3, ROM_Y4; wire [7:0] ROM_Y5, ROM_Y6; wire [7:0] ROM_Y7, ROM_Y8; wire [7:0] ROM_Y9;

    reg8 U7 (X + XC, KEY[0], 1'b1, CLOCK_50, ROM_X1);
       // defparam U7.n = 8;
    regn U8 (Y + YC, KEY[0], 1'b1, CLOCK_50, ROM_Y1);
        defparam U8.n = 7;
		  
	 reg8 U9 (X + XC2, KEY[0], 1'b1, CLOCK_50, ROM_X2);
       // defparam U9.n = 8;
    regn U10(Y + YC2, KEY[0], 1'b1, CLOCK_50, ROM_Y2);
        defparam U10.n = 7;
		  
	  reg8 arrreg31 (X + XC3, KEY[0], 1'b1, CLOCK_50, ROM_X3);
        //defparam arrreg31.n = 8;
    regn arrreg32 (Y + YC3, KEY[0], 1'b1, CLOCK_50, ROM_Y3);
        defparam arrreg32.n = 7;
		  
		  
	 reg8 arrreg41 (X + XC4, KEY[0], 1'b1, CLOCK_50, ROM_X4);
        //defparam arrreg41.n = 8;
    regn arrreg42(Y + YC4, KEY[0], 1'b1, CLOCK_50, ROM_Y4);
        defparam arrreg42.n = 7;
		  
	 reg8 arrreg51 (X + XC5, KEY[0], 1'b1, CLOCK_50, ROM_X5);
       // defparam arrreg51.n = 8;
    regn arrreg52 (Y + YC5, KEY[0], 1'b1, CLOCK_50, ROM_Y5);
        defparam arrreg52.n = 7;

	 reg8 arrreg61 (X + XC6, KEY[0], 1'b1, CLOCK_50, ROM_X6);
       // defparam arrreg61.n = 8;
    regn arrreg62(Y + YC6, KEY[0], 1'b1, CLOCK_50, ROM_Y6);
        defparam arrreg62.n = 7;
	 reg8 arrreg71 (X + XC7, KEY[0], 1'b1, CLOCK_50, ROM_X7);
       // defparam arrreg71.n = 8;
    regn arrreg72 (Y + YC7, KEY[0], 1'b1, CLOCK_50, ROM_Y7);
        defparam arrreg72.n = 7;
		  		   
	 reg8 arrreg81 (X + XC8, KEY[0], 1'b1, CLOCK_50, ROM_X8);
        //defparam arrreg81.n = 8;
    regn arrreg82(Y + YC8, KEY[0], 1'b1, CLOCK_50, ROM_Y8);
        defparam arrreg82.n = 7;
	 reg8 arrreg91 (X + XC9, KEY[0], 1'b1, CLOCK_50, ROM_X9);
        //defparam arrreg91.n = 8;
    regn arrreg92(Y + YC9, KEY[0], 1'b1, CLOCK_50, ROM_Y9);
        defparam arrreg92.n = 7;

    reg [2:0]ARROW_COLOR;
	 reg [7:0]ARROW_X;
	 reg [6:0]ARROW_Y;
	 parameter one = 4'b0001, two = 4'b0010, three = 4'b0011, four = 4'b0100, five = 4'b0101, six = 4'b0110, seven = 4'b0111, eight = 4'b1000, nine = 4'b1001;
	
	wire [3:0] x_pos;
	arrowFSM arrow(ps2_key_pressed, KEY[1], (ps2_key_data == 8'h1C), (ps2_key_data == 8'h23), x_pos);


	
	always@(*)
	 begin
	 case (x_pos)
	 (one):begin
	ARROW_COLOR <= ROM_colour1;
	ARROW_X <= ROM_X1;
	ARROW_Y <= ROM_Y1;
	 end
	 (two):begin
	ARROW_COLOR <= ROM_colour2;
	ARROW_X <= ROM_X2;
	ARROW_Y <= ROM_Y2;end
	 (three): begin
	ARROW_COLOR <= ROM_colour3;
	ARROW_X <= ROM_X3;
	ARROW_Y <= ROM_Y3;
	 end
	 (four): begin
	ARROW_COLOR <= ROM_colour4;
	ARROW_X <= ROM_X4;
	ARROW_Y <= ROM_Y4;
	 end
	 (five): begin
	ARROW_COLOR <= ROM_colour5;
	ARROW_X <= ROM_X5;
	ARROW_Y <= ROM_Y5;
	 end
	 (six): begin
	ARROW_COLOR <= ROM_colour6;
	ARROW_X <= ROM_X6;
	ARROW_Y <= ROM_Y6;
	 end
	 (seven): begin
	ARROW_COLOR <= ROM_colour7;
	ARROW_X <= ROM_X7;
	ARROW_Y <= ROM_Y7;
	 end
	 (eight): begin
	ARROW_COLOR <= ROM_colour8;
	ARROW_X <= ROM_X8;
	ARROW_Y <= ROM_Y8;
	 end
	 (nine): begin
	ARROW_COLOR <= ROM_colour9;
	ARROW_X <= ROM_X9;
	ARROW_Y <= ROM_Y9;
	 end
	 default: begin
	ARROW_COLOR <= ROM_colour5;
	ARROW_X <= ROM_X5;
	ARROW_Y <= ROM_Y5;
	 end
	 endcase
	 end


//	 assign VGA_COLOR = ARROW_COLOR;
//	 assign VGA_X = ARROW_X;
//	 assign VGA_Y = ARROW_Y;
/////////////////////////////////////////////POWER////////////////////////
wire [3:0] pow_lvl;
wire hlfsec;

//////functions
powerFSM power(~(ps2_key_pressed & (ps2_key_data == 8'h29)), KEY[2], hlfsec, pow_lvl);
halfsec_counter halfsies((ps2_key_pressed & (ps2_key_data == 8'h29)), CLOCK_50, hlfsec, counter);
wire[4:0] PXC;
wire[7:0] PX= 8'b1111011;
wire[6:0] PYC;
wire [6:0] PY = 7'b0001111; //15
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
powerbar Powerbar (PYC, PXC, CLOCK_50, ROM_Pcolours);//24

///////////////////////////////CHARGE
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
charge charge_ROM (chargeYC, chargeXC, CLOCK_50, ROM_Chargecolours);
///////////////////////////////HOOKING VGA UP PLS/////////////////////
//create new VGA regs for each always block, can only edit one reg per always block
reg [2:0] POWER_COLOR;
reg [7:0] POWER_X;
reg [6:0] POWER_Y;

always@(*)begin
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
default: begin
chargeX <= 7'b1111101;
chargeY <= 7'b1000001; //65
POWER_COLOR <= ROM_Pcolours;
POWER_X <= ROM_PX;
POWER_Y <= ROM_PY;
end
endcase
end


//////////////////////////////////CHOOSE WHICH ROM TO SEND TO VGA/////////////////
always@(*)begin
if ((ps2_key_data == 8'h23 | ps2_key_data == 8'h1C))begin
VGA_COLOR <= ARROW_COLOR;
VGA_X <= ARROW_X;
VGA_Y <= ARROW_Y;
end
else if ((ps2_key_data == 8'h29))begin
VGA_COLOR <= POWER_COLOR;
VGA_X <= POWER_X;
VGA_Y <= POWER_Y;
end
else begin
VGA_COLOR <= ARROW_COLOR;
VGA_X <= ARROW_X;
VGA_Y <= ARROW_Y;
end
end
    // connect to VGA controller
    vga_adapter VGA (
			.resetn(KEY[0]),
			.clock(CLOCK_50),
			.colour(VGA_COLOR),
			.x(VGA_X),
			.y(VGA_Y),
			.plot(~ps2_key_pressed),
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
inout				PS2_CLK;
inout				PS2_DAT;
// Internal Wires
wire		[7:0]	ps2_key_data;
wire				ps2_key_pressed;

// Internal Registers
reg			[7:0]	last_data_received;

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
	.CLOCK_50				(CLOCK_50),
	.reset				(~KEY[0]),

	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(ps2_key_data),
	.received_data_en	(ps2_key_pressed)
);
		
		
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
module reg8(R, Resetn, E, Clock, Q);
    input [7:0] R;
    input Resetn, E, Clock;
    output reg [7:0] Q;

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