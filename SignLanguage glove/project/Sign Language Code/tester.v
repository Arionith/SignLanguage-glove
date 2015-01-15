

module tester
	(
		CLOCK_50,						//	On Board 50 MHz
		KEY,							//	Push Button[3:0]
		SW,
		GPIO_0,	//	DPDT Switch[17:0]
		LEDR,
		LEDG,
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
	input	[4:0] SW;
	input [4:0]	GPIO_0;//	Button[0:0]
	output[4:0] LEDR;
	output [2:0]LEDG;
	output	VGA_CLK;   				//	VGA Clock
	output	VGA_HS;					//	VGA H_SYNC
	output	VGA_VS;					//	VGA V_SYNC
	output	VGA_BLANK;				//	VGA BLANK
	output	VGA_SYNC;				//	VGA SYNC
	output	[9:0] VGA_R;   			//	VGA Red[9:0]
	output	[9:0] VGA_G;	 		//	VGA Green[9:0]
	output	[9:0] VGA_B;   			//	VGA Blue[9:0]
	
	wire resetn, clear,draw2,draw3,draw4;
	reg [2:0] color,finalcolour,finalcolour1,finalcolour2;
	reg [7:0] xcount;
	reg [6:0] ycount;
	wire [2:0] characterColor,characterColor1,characterColor2,characterColor3,characterColor4,characterColor5,characterColor6,characterColor7,characterColor8,characterColor9,characterColor10,characterColor11,characterColor12,characterColor13,characterColor14,characterColor15,characterColor16,characterColor17,characterColor18,characterColor19,characterColor20,characterColor21,characterColor22,characterColor23,characterColor24,characterColor25,characterColor26;
	wire [2:0] characterColorA,characterColorB,characterColorC,characterColorD,characterColorE,characterColorF,characterColorG,characterColorH,characterColorI,characterColorJ,characterColorK,characterColorL,characterColorM,characterColorN,characterColorO,characterColorP,characterColorQ,characterColorR,characterColorS,characterColorT,characterColorU,characterColorV,characterColorW,characterColorX,characterColorY,characterColorZ;
	reg  [9:0]characterpos;
	reg [8:0]characterpos2;
	reg [7:0]x_o;
	reg [7:0]x_out;
	reg [7:0]xfinal;
	reg [6:0]y_o;
	reg  [2:0] color_o,color_out;
	reg enable;
	wire isclear,drawn;
	assign LEDR=GPIO_0;
	assign resetn = KEY[2];
	wire [4:0]draw;
	assign draw= GPIO_0;
	assign draw2=KEY[0];
	reg[25:0]count1;
	reg [2:0]count;
	reg countdone;
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
		defparam VGA.BACKGROUND_IMAGE = "display.mif";
		
		//Hand Gestures
		fullhand(characterpos,CLOCK_50,characterColor);
		Ah(characterpos,CLOCK_50,characterColor1);
		Bh(characterpos,CLOCK_50,characterColor2);
		Ch(characterpos,CLOCK_50,characterColor3);
		Dh(characterpos,CLOCK_50,characterColor4);
		Eh(characterpos ,CLOCK_50,characterColor5);
		Fh(characterpos ,CLOCK_50,characterColor6);
		Gh(characterpos ,CLOCK_50,characterColor7);
	finger2(characterpos ,CLOCK_50,characterColor8);
		Ih(characterpos ,CLOCK_50,characterColor9);
		Jh(characterpos ,CLOCK_50,characterColor10);
		Kh(characterpos ,CLOCK_50,characterColor11);
		Lh(characterpos ,CLOCK_50,characterColor12);
		Mh(characterpos ,CLOCK_50,characterColor13);
		Nh(characterpos ,CLOCK_50,characterColor14);
		Oh(characterpos ,CLOCK_50,characterColor15);
		Ph(characterpos ,CLOCK_50,characterColor16);
		Qh(characterpos ,CLOCK_50,characterColor17);
		Rh(characterpos ,CLOCK_50,characterColor18);
		Sh(characterpos ,CLOCK_50,characterColor19);
		Th(characterpos ,CLOCK_50,characterColor20);
		Uh(characterpos ,CLOCK_50,characterColor21);
		Vh(characterpos ,CLOCK_50,characterColor22);
		Wh(characterpos ,CLOCK_50,characterColor23);
		Xh(characterpos ,CLOCK_50,characterColor24);
		Yh(characterpos ,CLOCK_50,characterColor25);
		closed(characterpos,CLOCK_50,characterColor26);
		
		
		//LETTERS
		A(characterpos2,CLOCK_50,characterColorA);
		B(characterpos2,CLOCK_50,characterColorB);
		C(characterpos2,CLOCK_50,characterColorC);
		D(characterpos2,CLOCK_50,characterColorD);
		E(characterpos2,CLOCK_50,characterColorE);
		F(characterpos2,CLOCK_50,characterColorF);
		G(characterpos2,CLOCK_50,characterColorG);
		H(characterpos2,CLOCK_50,characterColorH);
		I(characterpos2,CLOCK_50,characterColorI);
		J(characterpos2,CLOCK_50,characterColorJ);
		K(characterpos2,CLOCK_50,characterColorK);
		L(characterpos2,CLOCK_50,characterColorL);
		M(characterpos2,CLOCK_50,characterColorM);
		N(characterpos2,CLOCK_50,characterColorN);
		O(characterpos2,CLOCK_50,characterColorO);
		P(characterpos2,CLOCK_50,characterColorP);
		Q(characterpos2,CLOCK_50,characterColorQ);
		R(characterpos2,CLOCK_50,characterColorR);
		S(characterpos2,CLOCK_50,characterColorS);
		T(characterpos2,CLOCK_50,characterColorT);
		U(characterpos2,CLOCK_50,characterColorU);
		V(characterpos2,CLOCK_50,characterColorV);
		W(characterpos2,CLOCK_50,characterColorW);
		X(characterpos2,CLOCK_50,characterColorX);
		Y(characterpos2,CLOCK_50,characterColorY);
		Z(characterpos2,CLOCK_50,characterColorZ);
		//assign LEDG=count;
		reg[3:0]curr_state,next_state;
		
		parameter [3:0] IDLE=4'b0000,COUNT=4'b0001,B=4'b0010,C=4'b0011,D=4'b0100,E=4'b0101,F=4'b0110,G=4'b0111,H=4'b1000,I=4'b1001,J=4'b1010,K=4'b1011; 
		always@*
		case(curr_state)
			IDLE: 
					if (draw2==1)next_state=COUNT;
					else next_state=IDLE;
	
		COUNT:
				if (countdone)next_state=H;
				else next_state=B;
			
			B: next_state=C;
			C: if (xcount < 23) next_state=C;
				else next_state=D;
			D:if (ycount<27) next_state=C;
				else next_state=E;
			///////////////////////////////////////////added part ///////////////////////////////////////////
			E:next_state=F;
			F:		if (xcount<19)next_state=F;
					else next_state=G;
			G:		if (ycount<19)next_state=F;
					else next_state=COUNT;
			//K:if(count1<49999999)next_state=K;
			  //else next_state=COUNT;
			H:if (count>5)next_state=IDLE;
				else next_state=I;
			I:if(xcount<19)next_state=I;
				else next_state=J;
			J:if(ycount<19)next_state=I;
				else next_state=IDLE;
				
			default :
					next_state=IDLE;
			
			endcase
		 always@(posedge CLOCK_50)
			begin 
				curr_state<=next_state;
			if (curr_state==IDLE)
				begin
					enable<=0;
					xcount<=8'b00000000;
					ycount<=7'b0000000;
				//characterpos2<=11'b000000000000;
					characterpos<=10'b00000000000;
					characterpos2<=9'b000000000;
				//characterpos1<=11'b000000000000;
				//count<=0;
					count1<=0;
					color_o<=finalcolour;
				//display_x<=8'b00000000;
			end
			/////////////////////////Added part//////////////////////////////////////
			//if (curr_state==COUNT&& next_state==COUNT)
			else if (curr_state==COUNT )
			begin
					enable<=0;
					xcount<=8'b00000000;
					ycount<=7'b0000000;
					//characterpos2<=11'b000000000000;
					characterpos<=10'b00000000000;
					characterpos2<=9'b000000000;
				//characterpos1<=11'b000000000000;
						//color_o<=finalcolour;
					count1=count1+1;
					countdone=(count1==(233208)); //46641
						color_out<=finalcolour1;
							
							
				end
			//else if (curr_state==COUNT && next_state==B)
				
				//count<=count+1;
	///////////////////////////////////////////////////////////////////////////////////////			
		else	if (curr_state==B)
				begin
					
				enable <=1;
				x_o<=8'b00000010;
				y_o <=7'b1011010;
				end
			else if (curr_state==C&& next_state==C)
				begin
					enable<=1;
					color_o<=finalcolour;
					x_o<=x_o+1;
					xcount<=xcount+1;
					characterpos<=characterpos+1;
				end
			else if (curr_state==C && next_state==D)
					x_o<=8'b00000010;
			else if (curr_state==D && next_state ==C)
					begin
						color_o<=finalcolour;
						characterpos<=characterpos+1;
						xcount<=8'b00000000;
						ycount<=ycount+1;
						y_o<=y_o+1;
					end
					
//////////////////////////////////////////////added part/////////////////////////////////////////////////////////
				else if (curr_state==D&& next_state==E)
				begin
						x_o<=8'b00000000;
						y_o<=7'b0000000;
				end
				else if ( curr_state==E)
				begin
				enable=1;
				x_o<=8'b00011111;
				y_o<=7'b1011110;
				xcount<=8'b00000000;
				ycount<=7'b0000000;
				characterpos<=10'b00000000000;
				characterpos2<=9'b0000000000;
				end
				else if (curr_state==E && next_state==F)
				enable<=1;
				else if (curr_state==F&& next_state==F)
				begin
				enable<=1;
					color_o<=finalcolour1;
					x_o<=x_o+1;
					xcount<=xcount+1;
					characterpos2<=characterpos2+1;
				end
			else if (curr_state==F && next_state==G)
					x_o<=8'b00011111;
				//else if (curr_state==G)
				//count<=249999999;
			else if (curr_state==G && next_state ==F)
					begin
						color_o<=finalcolour1;
						characterpos2<=characterpos2+1;
						xcount<=8'b00000000;
						ycount<=ycount+1;
						y_o<=y_o+1;
						
					end
	///		else if (curr_state==K)
		//		begin
				
			//	count1<=count1+1;
				//endbegin
				
	/////////////////////////////////////////////////////////////Added part///////////////////////////////////////////////
   // else if (curr_state==COUNT&& next_state==H)
		
		
		
	 else if (curr_state==H)
			begin
				enable<=1;
				//display_x<=display_x+8'bx00011000;
				
				x_o<=x_out;
				count<=count+1;
				//if (count>5)
				//count<=0;
				
				xcount<=8'b00000000 ;
				y_o<=7'b0101011;
				ycount<=7'b0000000;
				characterpos2<=9'b0000000000;
				
			end
	else if (curr_state==H && next_state==I)
				enable<=1;
				else if (curr_state==I&& next_state==I)
				begin
				enable<=1;
					color_o<=finalcolour1;
					x_o<=x_o+1;
					xcount<=xcount+1;
					characterpos2<=characterpos2+1;
				end
			else if (curr_state==I && next_state==J)
					x_o<=x_out;
			else if (curr_state==J && next_state ==I)
					begin
						color_o<=finalcolour;
						characterpos2<=characterpos2+1;
						xcount<=8'b00000000;
						ycount<=ycount+1;
						y_o<=y_o+1;
					end	
			
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////				
				end	
	
	
	always@(*)
	begin
	if (SW[0]==1)xfinal=8'b00000000;
	if (SW[1]==1)xfinal=8'b00011110;
	else if (SW[2]==1)xfinal=8'b00111100;
	else if  (SW[3]==1)xfinal=8'b01011010;
	else if (SW[4]==1)xfinal=8'b01111000;
	end
	
	always@*
	begin
	//Z
	if (draw[0]==1&&draw[1]===1&&draw[2]==1&&draw[3]==1&&draw[4]==1) 
	begin
		finalcolour=characterColor26;
		finalcolour1=characterColorZ;
	end
	//Y
	else if(draw[1]==1&&draw[2]==1&&draw[3]==1&&draw[4]==1)
	begin
		finalcolour=characterColor25;
		finalcolour1=characterColorY;
		end
	//X
	else if (draw[0]==1&&draw[2]==1&&draw[3]==1&&draw[4]==1) 
	begin
		finalcolour=characterColor24;
		finalcolour1=characterColorX;
	end
	//W
	else if (draw[2]==1&&draw[3]==1&&draw[4]==1) 
	begin
		finalcolour=characterColor23;
		finalcolour1=characterColorW;
	end
	//V
	else if (draw[0]==1&&draw[3]==1&&draw[4]==1) 
	begin
		finalcolour=characterColor22;
		finalcolour1=characterColorV;
	end
	//U
	else if (draw[3]==1&&draw[4]==1) 
	begin
		finalcolour=characterColor21;
		finalcolour1=characterColorU;
	end
	//T
	else if (draw[0]==1&&draw[1]===1&&draw[2]==1&&draw[4]==1) 
	begin
		finalcolour=characterColor20;
		finalcolour1=characterColorT;
	end
	//S
	else if (draw[0]==1&&draw[2]==1&&draw[4]==1) 
	begin
		finalcolour=characterColor19;
		finalcolour1=characterColorS;
	end
	//R
	else if (draw[2]==1&&draw[4]==1) 
	begin
		finalcolour=characterColor18;
		finalcolour1=characterColorR;
	end
	//Q
	
	else if (draw[0]==1&&draw[1]===1&&draw[4]==1) 
	begin
		finalcolour=characterColor17;
		finalcolour1=characterColorQ;
	end
	//P
	else if (draw[1]===1&&draw[4]==1) 
	begin
		finalcolour=characterColor16;
		finalcolour1=characterColorP;
	end
	//O
	else 	if (draw[0]==1&& draw[4]==1) 
	begin
		finalcolour=characterColor15;
		finalcolour1=characterColorO;
	end
	//N
	else	if (draw[4]==1) 
	begin
		finalcolour=characterColor14;
		finalcolour1=characterColorN;
	end
	//M
	else	if (draw[0]==1&&draw[1]===1&&draw[2]==1&&draw[3]==1) 
	begin
		finalcolour=characterColor13;
		finalcolour1=characterColorM;
	end
	//L
	else if (draw[1]===1&&draw[2]==1&&draw[3]==1) 
	begin
		finalcolour=characterColor12;
		finalcolour1=characterColorL;
	end
	//K
	else 	if (draw[0]==1&&draw[2]==1&&draw[3]==1) 
	begin
		finalcolour=characterColor11;
		finalcolour1=characterColorK;
	end
	//J
	else 	if (draw[2]==1&&draw[3]==1)  
	begin
		finalcolour=characterColor10;
		finalcolour1=characterColorJ;
	end
	//I
	else 	if (draw[0]==1&&draw[1]===1&&draw[3]==1) 
	begin
		finalcolour=characterColor9;
		finalcolour1=characterColorI;
	end
	//G
	else if (draw[3]==1) 
	begin
		finalcolour=characterColor7;
		finalcolour1=characterColorG;
	end
	//F
	else if (draw[0]==1&&draw[1]===1&&draw[2]==1) 
	begin
		finalcolour=characterColor6;
		finalcolour1=characterColorF;
	end
	//E
	else if (draw[1]===1&&draw[2]==1) 
	begin
		finalcolour=characterColor5;
		finalcolour1=characterColorE;
	end
	//D
	else if (draw[0]==1&&draw[2]==1) 
	begin
		finalcolour=characterColor4;
		finalcolour1=characterColorD;
	end
	//H
	else if (draw[2]===1) 
	begin
		finalcolour=characterColor8;
		finalcolour1=characterColorH;
	end
	//C
	else if (draw[0]==1&&draw[1]===1) 
	begin
		finalcolour=characterColor3;
		finalcolour1=characterColorC;
	end
	//B
	else if (draw[1]===1) 
	begin
		finalcolour=characterColor2;
		finalcolour1=characterColorB;
	end
	//A
	else if (draw[0]==1) 
	begin
		finalcolour=characterColor1;
		finalcolour1=characterColorA;
	end
	
	else
		begin
			finalcolour<=characterColor;
			finalcolour1<= 3'b000;//characterColor9;
		end
end
	
/*
always@*
case(draw)
00001:
	begin
	finalcolour=characterColor1;
	finalcolour1=characterColorA;
	end
00010:
	begin
	finalcolour=characterColor2;
	finalcolour1=characterColorB;
	end
11111:
	begin
		finalcolour=characterColor6;
		finalcolour1=characterColor15;
	end
	default:
	begin
	   finalcolour<=characterColor;
		finalcolour1<= 3'b000;//characterColor9;
		end
	
endcase
*/

always@*
	begin
		if (count==1)x_out=8'b00000010;
		else if (count==2)x_out=8'b00011100;
		else if (count==3)x_out=8'b00110111;
		else if (count==4)x_out=8'b01010010;
		else if (count==5)x_out=8'b01101100;
		else  x_out=8'b00000010;
		
		end
endmodule
