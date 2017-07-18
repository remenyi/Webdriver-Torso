`timescale 1ns / 1ps

//Egyszer� felfel� sz�ml�l� sz�ml�l�

module Random_Counter #(parameter WIDTH = 8, parameter LIMIT = 255)( 	//a sz�ml�l� regiszter nagys�ga �s �rt�ke
    input clk,																				//�rajel
    input rst,																				//reset jel
    output [WIDTH:0] out																//a sz�ml�l� regiszter �rt�ke 
    );											
												
reg [WIDTH:0] counter = 0;																//sz�ml�l� regiszter
assign out = counter;																	//kimen� sz�ml�l� regiszter �rt�ke

always @ (posedge clk)
begin
	if(rst)counter <= 0;																	//resetelhet�
	else if(counter < LIMIT)counter <= counter + 1;								//ha nem �ri el a limitet, hozz�adunk a sz�ml�l�hoz egyet
	else counter <= 0;																	//ha el�rte, akkor lenull�zuk a sz�ml�l�t
end							
endmodule
