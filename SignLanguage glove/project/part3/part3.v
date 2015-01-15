module part3(SW, CLOCK_50, HEX0, HEX1, HEX2, HEX3, LEDR);
input [1:0]SW;
input CLOCK_50;
output [0:6]HEX0, HEX1, HEX2, HEX3;
output [3:0]LEDR;
wire [6:0]H1, H2, H3, H4;
wire[3:0]q, q1, q2, q3;
wire pulse, pulse1, pulse2, pulse3;


smallsecpulse u8(CLOCK_50, pulse);
onesecpulse u9(CLOCK_50, pulse1);
twosecpulse u10(CLOCK_50, pulse2);
foursecpulse u11(CLOCK_50, pulse3);

instant u12(pulse, CLOCK_50, q);
instant u13(pulse1, CLOCK_50, q1);
instant u14(pulse2, CLOCK_50, q2);
instant u15(pulse3, CLOCK_50, q3);

  seg7 u16(q[3:0], H1[6:0]);
  seg7 u17(q1[3:0], H2[6:0]);
  seg7 u18(q2[3:0], H3[6:0]);
  seg7 u19(q3[3:0], H4[6:0]);
   
	reg [0:6]HEX0;
  always @ *
  if (SW[0]==0&&SW[1]==0) 
   HEX0[0:6]=~H1;
	else if(SW[0]==1&&SW[1]==0)
	HEX0[0:6]=~H2;
	else if(SW[0]==0&&SW[1]==1)
    HEX0[0:6]=~H3;
	 else
	 HEX0[0:6]=~H4;
	 
 assign LEDR=q;
 
 endmodule


module instant(pulse, CLOCK_50, q);
input pulse, CLOCK_50;
output [3:0]q;
wire[2:0]W;

tff_sync_rest A(pulse , CLOCK_50 ,q[0]);
assign W[0]=pulse&q[0];

tff_sync_rest B(W[0] , CLOCK_50 , q[1]);
assign W[1]=W[0]&q[1];

tff_sync_rest C(W[1] , CLOCK_50  , q[2]);
assign W[2]=W[1]&q[2];
tff_sync_rest D(W[2] , CLOCK_50 , q[3]);

endmodule

module tff_sync_rest (enable , clk , q);
  input enable, clk; 
  output q;
  reg q;
  always @ ( posedge clk)
   if (enable) begin
    q <=  ! q;
  end
  endmodule 
  
module seg7 (input [3:0]C, output reg[6:0]Display);

always @*
case (C)
 4'b0000:Display=7'b1111110;
 4'b0001:Display=7'b0110000;
 4'b0010:Display=7'b1101101;
 4'b0011:Display=7'b1111001;
 4'b0100:Display=7'b0110011;
 4'b0101:Display=7'b1011011;
 4'b0110:Display=7'b1011111;
 4'b0111:Display=7'b1110000;
 4'b1000:Display=7'b1111111;
 4'b1001:Display=7'b1111011;
 4'b1010:Display=7'b1110111;
 4'b1011:Display=7'b0011111;
 4'b1100:Display=7'b1001110;
 4'b1101:Display=7'b0111101;
 4'b1110:Display=7'b1001111;
 4'b1111:Display=7'b1000111;
 default:Display=7'b1111110;
 endcase
 
 endmodule
 
module smallsecpulse(clk, pulse);
input clk;
output pulse;
reg[27:0]counter;
always@(posedge clk)
if(pulse)
counter<=28'b0;
else 
counter<=counter+1'b1;
assign pulse = (counter==1);
endmodule

module onesecpulse(clk, pulse);
input clk;
output pulse;
reg[27:0]counter;
always@(posedge clk)
if(pulse)
counter<=28'b0;
else 
counter<=counter+1'b1;
assign pulse = (counter==49999999);
endmodule

module twosecpulse(clk, pulse);
input clk;
output pulse;
reg[27:0]counter;
always@(posedge clk)
if(pulse)
counter<=28'b0;
else 
counter<=counter+1'b1;
assign pulse = (counter==99999999);
endmodule

module foursecpulse(clk, pulse);
input clk;
output pulse;
reg[27:0]counter;
always@(posedge clk)
if(pulse)
counter<=28'b0;
else 
counter<=counter+1'b1;
assign pulse = (counter==199999999);
endmodule
