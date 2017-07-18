`timescale 1ns / 1ps

//Egy m�sodperc letelt�t jelz� modul

module Timer(
    input clk,															//bemen� �rajel
    input rst,															//bemen� reset
    output tmr_rdy0,													//kimen� m�sodperc jelz� vezet�k
    output tmr_rdy1													//kimen� m�sodperc jelz� vezet�k, az els� el�tt kb. 17 ms-al el�bb jelez
    );

wire [5:0] timer_out;												//az �ra sz�ml�l� regiszter �rt�ke

//m�sodperc sz�ml�l�, 60 frame hossz� ciklus, amit 6 biten lehet t�rolni (a sorsz�ml�l� sz�ml�l� ready vezet�k�t haszn�lja sz�ml�l�shoz, �gy el�g 6 bit)
Counter #(6, 58) timer (
    .clk(clk), 														//csak akkor sz�mol, ha befejez�d�tt a sorok sz�mol�sa (felhaszn�lva azt, hogy a szabv�ny szerinti friss�t�si sebess�g 60 Hz)
    .rst(rst),															//resetelhet�
    .rdy(tmr_rdy0),													//jelzi, ha letelt egy m�sodperc
	 .out(timer_out)													//a sz�ml�l� kimen� �rt�ke
    );

assign tmr_rdy1 = timer_out == 1;								//egy m�sik vezet�ken is jelezz�k az egy m�sodperc letelt�t 25 000 000 / 60 �rajellel el�tte (kb. 17 ms id�)

endmodule
