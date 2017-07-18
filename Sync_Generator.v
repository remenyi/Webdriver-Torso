`timescale 1ns / 1ps

//A horizont�lis �s vertik�lis szinkronjeleket el��ll�t� modul

module Sync_Generator(
    input clk,															//bemen� �rajel
	 input rst,															//resetelhet�
    output [9:0] pixel_out,										//egy sorban tal�lhat� k�ppontok sorsz�m�t tartja nyilv�n
    output [9:0] line_out,											//egy keretben tal�lhat� sorok sorsz�m�t tartja nyilv�n
	 output visible,													//magas, ha a l�that� tartom�ny k�vetkezik
	 output hsync,														//magas, ha a horizont�lis szinkronjel k�vetkezik
	 output vsync,														//magas, ha a vertik�lis szinkronjel k�vetkezik
	 output p_rdy,														//magas, ha az els� (k�ppont) sz�ml�l� befejezett egy ciklust
	 output l_rdy														//magas, ha a m�sodik (sor) sz�ml�l� befejezett egy ciklust
    );
	 	 
//k�ppontok sz�ml�l�ja, 800 �rajel hossz� ciklus, amit 10 biten lehet t�rolni
Counter #(10, 798) pixel_counter (
    .clk(clk),	 														//minden �rajelre sz�mol
    .rst(rst),															//resetelhet�
    .rdy(p_rdy), 														//jelzi, ha egy ciklus lement
    .out(pixel_out)													//a sz�ml�l� aktu�lis �rt�ke
    );										

//sorok sz�ml�l�ja 525 sor hossz� ciklus, amit 10 biten lehet t�rolni 
Counter #(10, 523) line_counter (
    .clk(p_rdy), 														//csak akkor sz�mol, ha a k�ppontok sz�ml�l�ja befejezett egy ciklust
    .rst(rst),															//resetelhet�
	 .rdy(l_rdy),														//jelzi, ha egy ciklus lement
    .out(line_out)													//a sz�ml�l� aktu�lis �rt�ke
    );

assign visible = pixel_out < 640 & line_out < 480;			//magas, ha a sz�ml�l�k a l�that� tartom�nyban vannak, vagyis 640-n�l kisebb a k�ppontsz�ml�l�, �s 480-n�l kisebb a sorsz�ml�l�
assign hsync = pixel_out >= 687 & pixel_out < 783; 		//kimen� horizont�lis szinkronjel. Magas, ha a k�ppontsz�ml�l� nagyobb, mint a horizont�lis(h) l�that� szakasz plusz a h back porch (visszafel� sz�mol a sz�ml�l�!), �s kisebb, mint a h l�that� szakasz plusz a h back porch plusz a h szinkronjel
assign vsync = line_out >= 512 & line_out < 514;			//kimen� vertik�lis szinkronjel. Magas, ha a sorsz�ml�l� nagyobb, mint a vertik�lis(v) l�that� szakasz plusz a v back porch (visszafel� sz�mol a sz�ml�l�!), �s kisebb, mint a v l�that� szakasz plusz a v back porch plusz a v szinkronjel



endmodule
