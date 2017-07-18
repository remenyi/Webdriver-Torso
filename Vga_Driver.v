`timescale 1ns / 1ps

module Vga_Driver(
    input clk,																//bemen� �rajel
    input rst,																//bemen� reset jel
    output vsync,															//kimen� vertik�lis szinkronjel
    output hsync,															//kimen� horizont�lis szinkronjel
    output [1:0] red,													//kimen� piros jel
    output [1:0] green,													//kimen� z�ld jel
    output [1:0] blue,													//kimen� k�k jel
	 output sec 															//kimen� m�sodperc jel (a random frekvenci�k el��ll�t�s�hoz kell)
    );											
												
wire [9:0] pixel_out;													//aktu�lis k�ppont sz�ma van rajta
wire [8:0] line_out;														//aktu�lis sor sz�ma van rajta

//szinkronjeleket el��ll�t� modul
Sync_Generator sync_generator (
    .clk(clk), 															//bemen� �rajel	
    .rst(rst),  															//resetelhet�
    .pixel_out(pixel_out), 											//kimen� aktu�lis k�ppontsz�m
    .line_out(line_out), 												//kimen� aktu�lis sorsz�m
	 .visible(visible),													//magas, ha a l�that� tartom�ny k�vetkezik
    .hsync(hsync), 														//magas, ha a horizont�lis szinkronjel k�vetkezik
    .vsync(vsync),														//magas, ha a verti�lis szinkronjel k�vetkezik
	 .p_rdy(p_rdy),														//magas, ha az els� (k�ppont) sz�ml�l� egy ciklus v�g�re �rt
	 .l_rdy(l_rdy)															//magas, ha a m�sodik (sor) sz�ml�l� egy ciklus v�g�re �rt
    );

//m�sodperc jelet el��ll�t� modul
Timer timer (
    .clk(l_rdy), 															//csak akkor sz�mol, ha v�get �rt a sorok sz�mol�sa (ezzel cs�kkenteni lehet a sz�ml�l� regiszter m�ret�t)
    .rst(rst),																//resetelhet�
    .tmr_rdy0(tmr_rdy0), 												//kimen� m�sodperc jelz� vezet�k
    .tmr_rdy1(tmr_rdy1)													//kimen� m�sodperc jelz� vezet�k, az els� el�tt kb. 17 ms-al el�bb jelez
    );									
assign sec = tmr_rdy0;													//az els� m�sodperc jels� vezet�ket kivezetj�k (a random frekvenci�k el��ll�t�s�hoz kell)

//random t�glalapokat el��ll�t� modul
wire [9:0] rw0_out, rw1_out;											//piros t�glalap bal vagy jobb oldalai
wire [8:0] rh0_out, rh1_out;											//piros t�glalap als� vagy fels� oldalai						
wire [9:0] bw0_out, bw1_out;											//k�k t�glalap bal vagy jobb oldalai
wire [8:0] bh0_out, bh1_out;											//k�k t�glalap als� vagy fels� oldalai
Random_Rectangle_Generator random_rectangle_generator (
    .clk(clk), 															//bemen� �rajel
    .rst(rst),																//resetelhet�
	 .tmr_rdy0(tmr_rdy0),												//bemen� m�sodperc jelz� vezet�k
	 .tmr_rdy1(tmr_rdy1),												//bemen� m�sodperc jelz� vezet�k, az els� el�tt kb. 17 ms-al el�bb jelez
    .p_rdy(p_rdy),														//bemen� vezet�k, magas, ha az els� (k�ppont) sz�ml�l� egy ciklus v�g�re �rt
    .rw0_out(rw0_out), 													//piros t�glalap bal vagy jobb oldalai
    .rw1_out(rw1_out), 													//piros t�glalap bal vagy jobb oldalai
    .rh0_out(rh0_out), 													//piros t�glalap als� vagy fels� oldalai
    .rh1_out(rh1_out), 													//piros t�glalap als� vagy fels� oldalai
    .bw0_out(bw0_out), 													//k�k t�glalap bal vagy jobb oldalai
    .bw1_out(bw1_out), 													//k�k t�glalap bal vagy jobb oldalai
    .bh0_out(bh0_out), 													//k�k t�glalap als� vagy fels� oldalai
    .bh1_out(bh1_out) 													//k�k t�glalap als� vagy fels� oldalai
    );

//T�glalapokat megjelen�t� modul	 
Rectangle_Display rectangle_display (
    .pixel_out(pixel_out), 											//bemen� busz, az aktu�lis k�ppont sz�ma van rajta
    .line_out(line_out), 												//bemen� busz, aktu�lis sor sz�ma van rajta
    .rw0_out(rw0_out), 													//piros t�glalap bal vagy jobb oldalai
    .rw1_out(rw1_out), 													//piros t�glalap bal vagy jobb oldalai
    .rh0_out(rh0_out), 													//piros t�glalap als� vagy fels� oldalai
    .rh1_out(rh1_out), 													//piros t�glalap als� vagy fels� oldalai
    .bw0_out(bw0_out), 													//k�k t�glalap bal vagy jobb oldalai
    .bw1_out(bw1_out), 													//k�k t�glalap bal vagy jobb oldalai
    .bh0_out(bh0_out), 													//k�k t�glalap als� vagy fels� oldalai
    .bh1_out(bh1_out), 													//k�k t�glalap als� vagy fels� oldalai
    .visible(visible), 													//bemen� vezet�k, magas, ha a l�that� tartom�ny k�vetkezik
    .red(red), 															//kimen� busz, magas, ha �pp piros k�ppontokat akarunk megjelen�teni
    .green(green), 														//kimen� busz, magas, ha �pp z�ld k�ppontokat akarunk megjelen�teni
    .blue(blue)															//kimen� busz, magas, ha �pp k�k k�ppontokat akarunk megjelen�teni
    );

endmodule
