`timescale 1ns / 1ps

//Frekvenciát pwm jellé átalakító modul
module Frequency_To_PWM(
    input clk,											//bejövõ órajel
    input rst,											//bejövõ reset vezeték
    input [11:0] frequency,						//bejövõ frekvencia busz
    output reg pwm = 1								//kimenõ pwm
    );					
						
reg [23:0] accumulator = 0;						//akkumulátor regiszter
						
always@(posedge clk)					
begin					
	if(rst) accumulator <= 0;						//resetelhetõ
	else if(accumulator > 12500000)				//ha az akkumulátor regiszter meghaladja az egy másodpercre jutó órajelek számának felét...
		begin												
			accumulator <= 0;							//lenullázzuk...
			pwm = ~pwm;									//és a kimenõ pwm jelet invertáljuk
		end
	else 
		accumulator <= accumulator+frequency;	//egyébként mindig hozzáadjuk a kívánt frekvencia értékét
end													

endmodule