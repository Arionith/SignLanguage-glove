// Etch-and-sketch

module sketch
	(
		CLOCK_50,						//	On Board 50 MHz
		KEY,							//	Push Button[3:0]
		SW,								//	DPDT Switch[17:0]
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
	input	[17:0] SW;				//	Button[0:0]
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

	
	reg [7:0]x_o;
	reg [6:0]y_o;
	reg  [2:0] color_o;
	reg enable;
	wire isclear,drawn;

	assign resetn = KEY[2];
	assign draw =~KEY[1];
	assign clear =~KEY[0];

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
		reg [2:0] curr_state,next_state;
		parameter [2:0] IDLE=3'b000,B=3'b001,C=3'b010,D=3'b011,E=3'b100,F=3'b101;
		always@*
		case(curr_state)
			IDLE: 
			if (draw==0 && clear ==1 ) next_state<= B;
				else if (draw==1&& clear==0)next_state<=E;
				else next_state=IDLE;
			
			B: 
				next_state=C;
			C:
					if (x_o<159)next_state=C;		
					else next_state=D;
			D:
					if (y_o<119) next_state=C;
					else next_state =IDLE;
			E:
					if (xcount<6) next_state=E;
					else next_state=F;
			F:
					if (ycount<6) next_state=E;
					else next_state=IDLE;
			endcase
					
			always@(posedge CLOCK_50)
							begin
							curr_state <=next_state;
					
					if (curr_state==IDLE)
							begin
								enable=0;
								x_o<=SW[7:0];
								y_o<=SW[14:8];
								color<=SW[17:15];
								xcount<=8'b00000000;
								ycount <=7'b0000000;
							end
					else if (curr_state==B)
							begin
								x_o<=8'b00000000;
								y_o<=7'b0000000;
								enable<=1;
								color_o<=3'b000;
							end
					else if (curr_state==C && next_state==C)
							begin
								x_o<=x_o+1;
							end
					else if (curr_state==C && next_state==D)
								x_o<=8'b00000000;
					else if (curr_state==D && next_state==C)
								begin
									y_o=y_o+1;
								end
					else if (draw==1&& clear==0)
									enable<=1; 
					else if (curr_state==E && next_state==E )
								begin
									color_o=color;
								if (ycount>2)
										begin
										color_o=~color;
										end
								xcount<=xcount+1;
								x_o<=x_o+1;
								end
						else if (curr_state==E && next_state==F)
									
									x_o<=SW[7:0];
									
						else if (curr_state==F && next_state==E)
									begin
									
									ycount <=ycount+1;
									y_o<=y_o+1;
								
										xcount<=8'b00000000;
									
							end		//		else if (curr_state==Y_c && next_state==IDLE)
							
			end				

endmodule

