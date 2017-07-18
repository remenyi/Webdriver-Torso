`timescale 1ns / 1ps

//Lefel� sz�ml�l� sz�ml�l�. A sz�ml�l� regiszternek plusz egy bitje van, mivel a sz�ml�l� nulla ut�n alulcsordul, magasba �ll�tva a msb bitet.
//�gy csak egyetlenegy bitet kell megvizsg�lni, nem az �sszeset.

module Counter #(parameter WIDTH = 8, parameter LIMIT = 127)( 	//a sz�ml�l� regiszter nagys�ga �s �rt�ke (mindig kett�vel kisebb �rt�ket kell megadni, mivel 0 ut�n a sz�ml�l� regiszter �tv�lt csupa egyesbe)
    input clk,																	//�rajel
    input rst,																	//reset jel
    output rdy,																//magas, ha egy ciklus v�get �rt
    output [WIDTH-1:0] out													//a sz�ml�l� regiszter �rt�ke (lesz�m�tva a msb-t)
    );				
					
reg[WIDTH:0] counter = {0,LIMIT};										//sz�ml�l� regiszter
assign rdy = counter[WIDTH];												//ha a msb bit magas, akkor v�get �rt a sz�ml�l�s
assign out = counter[WIDTH-1:0];											//a kimenet a sz�ml�l� regiszter a msb kiv�tel�vel
				
always @ (posedge clk)				
begin				
	if(rst)counter <= {0,LIMIT};											//resetelhet�
	else if(!counter[WIDTH])counter <= counter-1;					//ha nem magas a msb, akkor kivonunk
	else counter <= {0,LIMIT};												//ha magas, az azt jelenti, hogy a sz�ml�l�s v�get �rt
end

endmodule
