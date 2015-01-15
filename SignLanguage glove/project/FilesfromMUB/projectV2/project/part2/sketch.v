

module sketch
	(
		CLOCK_50,						//	On Board 50 MHz
		KEY,							//	Push Button[3:0]
		SW,
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input	CLOCK_50;				//	50 MHz
	input	[3:0] KEY;				//	Button[0:0]
	input	[17:0] SW;
	//input [4:0]	GPIO_0;//	Button[0:0]
	//output[4:0] LEDR;
	output	VGA_CLK;   				//	VGA Clock
	output	VGA_HS;					//	VGA H_SYNC
	output	VGA_VS;					//	VGA V_SYNC
	output	VGA_BLANK;				//	VGA BLANK
	output	VGA_SYNC;				//	VGA SYNC
	output	[9:0] VGA_R;   			//	VGA Red[9:0]
	output	[9:0] VGA_G;	 		//	VGA Green[9:0]
	output	[9:0] VGA_B;   			//	VGA Blue[9:0]
	
	wire resetn, draw,clear;
	reg [2:0] color;
	reg [7:0] xcount;
	reg [6:0] ycount;
	wire [2:0] characterColorA;
	reg  [10:0]characterpos;
	wire [2:0] characterColorAm;
	wire [2:0] characterColorB;
	wire [2:0] characterColorC;
	wire [2:0] characterColorD;
	wire [2:0] characterColorE;
	wire [2:0] characterColorF;
	wire [2:0] characterColorG;
	wire [2:0] characterColorH;
	wire [2:0] characterColorI;
	wire [2:0] characterColorJ;
	wire [2:0] characterColorK;
	wire [2:0] characterColorL;
	wire [2:0] characterColorM;
	wire [2:0] characterColorN;
	wire [2:0] characterColorO;
	wire [2:0] characterColorP;
	wire [2:0] characterColorQ;
	wire [2:0] characterColorR;
	wire [2:0] characterColorS;
	wire [2:0] characterColorT;
	wire [2:0] characterColorU;
	wire [2:0] characterColorV;
	wire [2:0] characterColorW;
	wire [2:0] characterColorX;
	wire [2:0] characterColorY;
	wire [2:0] characterColorZ;
   reg [7:0]x;
	reg [6:0]y_o;
	reg [7:0]x_o;
	reg [7:0]x_final;
	reg [6:0]y_final;
	reg  [2:0] color_o;
	reg enable;
	wire isclear,drawn;
	//assign LEDR=GPIO_0;
	assign resetn = KEY[2];
	assign draw =SW[17];
	wire [4:0]in;
	assign in[4:0] = SW[4:0];

		reg[2:0]curr_state,next_state;
		parameter [2:0] IDLE=3'b000,bs=3'b001,cs=3'b010, ds=3'b011,es=3'b100, fs=3'b101, gs=3'b110, hs=3'b111;
		
		parameter A=5'b00001, B=5'b00010, C=5'b00011, D=5'b00101, E=5'b00110, F=5'b00111; 
		
		parameter G=5'b01000, H=5'b01001, I=5'b01011, J=5'b01100, K=5'b01101, L=5'b01110, M=5'b01111; 
		parameter N=5'b10000, O=5'b10001, P=5'b10010, Q=5'b10011, R=5'b10100, S=5'b10101, T=5'b10111; 
		parameter U=5'b11000, V=5'b11001, W=5'b11100, X=5'b11101, Y=5'b1110, Z=5'b11111; 
		
		always@*
		case(curr_state)
			IDLE: if (draw==1)next_state=bs;
					else next_state=IDLE;
					
			bs: next_state=cs;
			cs: if (xcount < 15) next_state=cs;
				else next_state=ds;
			ds:if (ycount<23) next_state=cs;
				else next_state=fs;
			es: next_state=fs;
			fs:if(xcount<=250000000)next_state=fs; 
			gs:next_state=hs;
			hs: if(xcount<=6) next_state=hs;
			     else next_state=IDLE;
			endcase
	
	//The following always block determine the letter to be displayed at a time		
		always@(posedge CLOCK_50) begin
			 if(SW[4:0]==A)begin
			 color_o<=characterColorA;
			 end
			 else if(SW[4:0]==B)begin
			 color_o<=characterColorB;
			 end
			 else if(SW[4:0]==C)begin
			 color_o<=characterColorC;
			 end
			 else if(SW[4:0]==D)begin
			 color_o<=characterColorD;
			 end
			 else if(SW[4:0]==E)begin
			 color_o<=characterColorE;
			 end
			 else if(SW[4:0]==F)begin
			 color_o<=characterColorF;
			 end
			 else if(SW[4:0]==G)begin
			 color_o<=characterColorG;
			 end
			 else if(SW[4:0]==H)begin
			 color_o<=characterColorH;
			 end
			 else if(SW[4:0]==I)begin
			 color_o<=characterColorI;
			 end
			 else if(SW[4:0]==J)begin
			 color_o<=characterColorJ;
			 end
			 else if(SW[4:0]==K)begin
			 color_o<=characterColorK;
			 end
			 else if(SW[4:0]==L)begin
			 color_o<=characterColorL;
			 end
			 else if(SW[4:0]==M)begin
			 color_o<=characterColorM;
			 end
			 else if(SW[4:0]==N)begin
			 color_o<=characterColorN;
			 end
			 else if(SW[4:0]==O)begin
			 color_o<=characterColorO;
			 end
			 else if(SW[4:0]==P)begin
			 color_o<=characterColorP;
			 end
			 else if(SW[4:0]==Q)begin
			 color_o<=characterColorQ;
			 end
			 else if(SW[4:0]==R)begin
			 color_o<=characterColorR;
			 end
			 else if(SW[4:0]==S)begin
			 color_o<=characterColorS;
			 end
			 else if(SW[4:0]==T)begin
			 color_o<=characterColorT;
			 end
			 else if(SW[4:0]==U)begin
			 color_o<=characterColorU;
			 end
			 else if(SW[4:0]==V)begin
			 color_o<=characterColorV;
			 end
			 else if(SW[4:0]==W)begin
			 color_o<=characterColorW;
			 end
			 else if(SW[4:0]==X)begin
			 color_o<=characterColorX;
			 end
			 else if(SW[4:0]==Y)begin
			 color_o<=characterColorY;
			 end
			 else if(SW[4:0]==Z)begin
			 color_o<=characterColorZ;
			 end
			end
			
 /*always@*
	begin
	if(SW[7:5]==3'b0)begin
	y_final <=30;
	x_final<=20;
	end
	else if(SW[7:5]==3'b001)begin
    y_final<=30;
    x_final<=40;
    end
	 else if(SW[7:5]==3'b010)begin
	 y_final <=30;
	 x_final<=60;
	 end
	 else if(SW[7:5]==3'b011)begin
	 y_final<=30;
	 x_final<=80;
	 end
	 else if(SW[7:5]==3'b100)begin
	 y_final <=30;
	 x_final<=100;
	 end
	 end	*/			
	
//The FSM
	always@(posedge CLOCK_50)
			begin 
			curr_state<=next_state;
			if (curr_state==IDLE)
			begin
				enable=0;
				xcount<=0;
				ycount<=0;
				characterpos<=11'b0;	
				x_o<=0;
				y_o<=0;
			end
			if (curr_state==bs)
				enable <=1;
			else if (curr_state==cs&& next_state==cs)
				begin
					x_o<=x_o+1;
					xcount<=xcount+1;
					characterpos<=characterpos+1;
				end
			else if (curr_state==ds && next_state ==cs)
					begin
						xcount<=0;
						ycount<=ycount+1;
						y_o <= y_o+1;
						characterpos<=characterpos+1;
					end
		end	
		
				
//Instance of the modules corresponding to each letter
A(characterpos,CLOCK_50,characterColorA);
B(characterpos,CLOCK_50,characterColorB);
C(characterpos,CLOCK_50,characterColorC);
D(characterpos,CLOCK_50,characterColorD);
E(characterpos,CLOCK_50,characterColorE);
F(characterpos,CLOCK_50,characterColorF);
G(characterpos,CLOCK_50,characterColorG);
H(characterpos,CLOCK_50,characterColorH);
I(characterpos,CLOCK_50,characterColorI);
J(characterpos,CLOCK_50,characterColorJ);
K(characterpos,CLOCK_50,characterColorK);
L(characterpos,CLOCK_50,characterColorL);
M(characterpos,CLOCK_50,characterColorM);
N(characterpos,CLOCK_50,characterColorN);
O(characterpos,CLOCK_50,characterColorO);
P(characterpos,CLOCK_50,characterColorP);
Q(characterpos,CLOCK_50,characterColorQ);
R(characterpos,CLOCK_50,characterColorR);
S(characterpos,CLOCK_50,characterColorS);
T(characterpos,CLOCK_50,characterColorT);
U(characterpos,CLOCK_50,characterColorU);
V(characterpos,CLOCK_50,characterColorV);
W(characterpos,CLOCK_50,characterColorW);
X(characterpos,CLOCK_50,characterColorX);
Y(characterpos,CLOCK_50,characterColorY);
Z(characterpos,CLOCK_50,characterColorZ);

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(color_o),
			.x(x_o),
			.y(y_o),
			.plot(enable),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK),
			.VGA_SYNC(VGA_SYNC),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "";	
endmodule