module hand(GPIO_0,LEDR);
input [5:1]GPIO_0;
output[4:0]LEDR;
assign LEDR[0]=GPIO_0[1];
assign LEDR[1]=GPIO_0[2];
assign LEDR[2]=GPIO_0[3];
assign LEDR[3]=GPIO_0[4];
assign LEDR[4]=GPIO_0[5];
endmodule                                                                                                                                                                                                                       
 