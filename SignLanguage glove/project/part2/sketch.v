// Etch-and-sketch

module sketch
	(
		CLOCK_50,						//	On Board 50 MHz
		KEY,							//	Push Button[3:0]
		//SW,	
		GPIO_0,
		LEDR	,	//	DPDT Switch[17:0]
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input	[3:0]	KEY;					//	Button[3:0]
	//input	[17:0]	SW;
	input [2:0] GPIO_0;		//	Switches[0:0]
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	output   [2:0] LEDR;
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the color, x, y and writeEn wires that are inputs to the controller.

	reg [2:0] color;
	reg  [7:0] x;
	reg  [6:0] y;
	wire writeEn;
	reg  enable;
	
	parameter A=3'b000, B=3'b001, C=3'b010, D=3'b011, E=3'100, F=3'b101;
	//[4:0parameter G=5'b00011, H=5'b00110, I=5'b01100, J=5'b11000, K=5'b10001;
	//reg next_state];
	//wire [4:0]V;
	//assign V[4:0]=GPIO_0[4:0];
	
	assign LEDR=GPIO_0;
	
	reg  [4:0]counter;
	reg [4:0]counter2;
	reg [4:0]counter3, counter4;
	reg signal, signal2;
	
	 
 always@(posedge CLOCK_50)
	begin
   if(GPIO_0[2:0]==A)begin
 	  counter<=0;
	  counter2<=0;
	  counter3<=0;
	   counter4<=0;
	  signal<=0;
	  signal2=0;
	  x<=30;
	  y<=40;
	 color[2:0]<=3'b111;
	  enable<=0;
      end
   else if(GPIO_0[2:0]==B)begin
	      if(counter<15)begin
			   y <= y+4'b1;
				color[2:0]<=3'b111;
				counter<=counter+4'b1;
				enable<=1;
				end
		   else if(counter==15&signal==0)begin
			y<=y-8;
			signal=1;
			end
			else if(counter==15&&counter2<8)begin
			     x<=x + 1;
				  counter2<=counter2+1;
				  enable<=1;
				 end
				 
			else if(counter==15&&counter2==8&&signal2==0)begin
			   y<=y -7;
				enable<=0;
				signal2=1;
			end
			else if(counter==15&&counter2==8&&counter3<15) begin
			  y <= y+4'b1;
			  counter3<=counter3 + 4'b1;
			  enable<=1;
			end
	  end
	 else if(GPIO_0[2:0]==C)
	 begin
			if(counter==0)begin
			 y<=40;
			 x<=42;
			 counter <=counter+1;
			 color[2:0]<=3'b111;
			 enable<=0;
			end
			else if(counter<15)begin
			   y <= y+1;
				counter<=counter+1;
				enable<=1;
			end
		     else if(counter==15&&counter2<8)begin
			   x <= x+1;
				counter2<=counter2+1;
				enable<=1;
				end
			else if(counter==15&&counter2==8&&counter3==0)begin
			     y<=y-7;
				  counter3<=counter3+1;
				  x=x-8;
				  enable<=0;
				 end
			else if(counter==15&&counter2==8&&counter3<9)
			 begin
			  x <= x+1;
			 counter3<=counter3+1;
			 enable<=1;
			 end
         else if(counter==15&&counter2==8&&counter3==9&&counter4==0)
		      begin
				y<=y-7;
				x=x-9;
				enable<=0;
				counter4=counter4+1;
				end
		    else if(counter==15&&counter2==8&&counter3==9&&counter4<9)
			begin
			x <= x+1;
			enable<=1;
			counter4<=counter4+1;
			end
   end 
  else if(GPIO_0[2:0]==D)begin
    if(counter==0)begin
			 y<=40;
			 x<=56;
			 counter <=counter+1;
			 color[2:0]<=3'b111;
			 enable<=0;
			end
			else if(counter<16)begin
			   y <= y+1;
				counter<=counter+1;
				enable<=1;
			end
		     else if(counter==16&&counter2<8)begin
			   x <= x+1;
				counter2<=counter2+1;
				enable<=1;
				end
	end
	  else if(GPIO_0[2:0]==E)begin
    if(counter==0)begin
			 y<=40;
			 x<=70;
			 counter <=counter+1;
			 color[2:0]<=3'b111;
			 enable<=0;
			end
			else if(counter<16)begin
			   y <= y+1;
				counter<=counter+1;
				enable<=1;
			end
		     else if(counter==16&&counter2<8)begin
			   x <= x+1;
				counter2<=counter2+1;
				enable<=1;
				end
	end
 else if(GPIO_0[2:0]==F)begin
   
			if(counter==0)begin
			 y<=40;
			 x<=84;
			 counter <=counter+1;
			 color[2:0]<=3'b111;
			 enable<=0;
			end
			else if(counter<15)begin
			   y <= y+1;
				counter<=counter+1;
				enable<=1;
			end
		     else if(counter==15&&counter2<8)begin
			   x <= x+1;
				counter2<=counter2+1;
				enable<=1;
				end
			else if(counter==15&&counter2==8&&signal2==0)begin
			   y<=y-15;
				enable<=0;
				signal2=1;
			end
			else if(counter==15&&counter2==8&&counter3<15) begin
			  y <= y+1;
			  counter3<=counter3 + 1;
			  enable<=1;
			end
         else if(counter==15&&counter2==8&&counter3==15&&counter4==0)
		      begin
				y<=y-14;
				x=x-9;
				enable<=0;
				counter4=counter4+1;
				end
		    else if(counter==15&&counter2==8&&counter3==15&&counter4<10)
			begin
			x <= x+1;
			enable<=1;
			counter4<=counter4+1;
			end
   end 
end

	
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	 vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(color),
			.x(x),
			.y(y),
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
			
	// Put your code here. Your code should produce signals x,y,color and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
	
endmodule

	/*always@*
	case(SW[5:1])
	begin
	A: if(SW[5:1]==A)
	   next_state=A;
		else if(SW[5:1]==B)
		next_state=B;
		else if(SW[5:1]==C)
	   next_state=C;
		else if(SW[5:1]==D)
		next_state=D;
		else if(SW[5:1]==E)
		next_state=E;
///////////////////////////////////////////
	B:if(SW[5:1]==A)
	   next_state=A;
		else if(SW[5:1]==B)
		next_state=B;
		else if(SW[5:1]==C)
	   next_state=C;
		else if(SW[5:1]==D)
		next_state=D;
		else if(SW[5:1]==E)
		next_state=E;
///////////////////////////////////
	C:if(SW[5:1]==A)
	   next_state=A;
		else if(SW[5:1]==B)
		next_state=B;
		else if(SW[5:1]==C)
	   next_state=C;
		else if(SW[5:1]==D)
		next_state=D;
		else if(SW[5:1]==E)
		next_state=E;
/////////////////////////////////
	D:if(SW[5:1]==A)
	   next_state=A;
		else if(SW[5:1]==B)
		next_state=B;
		else if(SW[5:1]==C)
	   next_state=C;
		else if(SW[5:1]==D)
		next_state=D;
		else if(SW[5:1]==E)
		next_state=E;
/////////////////////////////////////
	E:if(SW[5:1]==A)
	   next_state=A;
		else if(SW[5:1]==B)
		next_state=B;
		else if(SW[5:1]==C)
	   next_state=C;
		else if(SW[5:1]==D)
		next_state=D;
		else if(SW[5:1]==E)
		next_state=E;
///////////////////////////////////
	F:if(SW[5:1]==A)
	   next_state=A;
		else if(SW[5:1]==B)
		next_state=B;
		else if(SW[5:1]==C)
	   next_state=C;
		else if(SW[5:1]==D)
		next_state=D;
		else if(SW[5:1]==E)
		next_state=E;
		end
	endcase*/