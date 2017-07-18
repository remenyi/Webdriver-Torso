`timescale 1ns / 1ps

//Frekvenci�t pwm jell� �talak�t� modul
module Frequency_To_PWM(
    input clk,											//bej�v� �rajel
    input rst,											//bej�v� reset vezet�k
    input [11:0] frequency,						//bej�v� frekvencia busz
    output reg pwm = 1								//kimen� pwm
    );					
						
reg [23:0] accumulator = 0;						//akkumul�tor regiszter
						
always@(posedge clk)					
begin					
	if(rst) accumulator <= 0;						//resetelhet�
	else if(accumulator > 12500000)				//ha az akkumul�tor regiszter meghaladja az egy m�sodpercre jut� �rajelek sz�m�nak fel�t...
		begin												
			accumulator <= 0;							//lenull�zzuk...
			pwm = ~pwm;									//�s a kimen� pwm jelet invert�ljuk
		end
	else 
		accumulator <= accumulator+frequency;	//egy�bk�nt mindig hozz�adjuk a k�v�nt frekvencia �rt�k�t
end													

endmodule