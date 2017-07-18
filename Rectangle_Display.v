`timescale 1ns / 1ps

module Rectangle_Display(
	 input [9:0] pixel_out,											//bemen� busz, rajta az aktu�lis k�ppontsz�mmal
	 input [9:0] line_out,											//bemen� busz, rajta az aktu�lis sorsz�mmal
	 input [9:0] rw0_out, rw1_out,								//piros t�glalap bal vagy jobb oldalai
	 input [8:0] rh0_out, rh1_out,								//piros t�glalap als� vagy fels� oldalai						
	 input [9:0] bw0_out, bw1_out,								//k�k t�glalap bal vagy jobb oldalai
	 input [8:0] bh0_out, bh1_out,								//k�k t�glalap als� vagy fels� oldalai
	 input visible,													//bemen� vezet�k, magas, ha a l�that� szakasz k�vetkezik
    output [1:0] red,												//kimen� busz, magas ha �pp piros k�ppontokat akarunk megjelen�teni
    output [1:0] green,												//kimen� busz, magas ha �pp z�ld k�ppontokat akarunk megjelen�teni
    output [1:0] blue												//kimen� busz, magas ha �pp k�k k�ppontokat akarunk megjelen�teni
    );

assign red_box = ((rw0_out > pixel_out & rw1_out < pixel_out) | (rw1_out > pixel_out & rw0_out < pixel_out)) & ((rh0_out > line_out & rh1_out < line_out) | (rh1_out > line_out & rh0_out < line_out));	//magas, ha a piros t�glalapot kell kirajzolni. Ez akkor lehets�ges, ha a k�ppontsz�ml�l� az el��ll�tott jobb �s bal oldal k�z�tt van (a k�t �rt�kr�l onnan tudjuk eld�nteni, hogy melyik a jobb(a magasabb) vagy bal(az alacsonyabb), hogy mindk�t lehet�s�get megvizsg�ljuk), �s az el��ll�tott fels� �s als� �rt�kek k�z�tt van

assign blue_box = ((bw0_out > pixel_out & bw1_out < pixel_out) | (bw1_out > pixel_out & bw0_out < pixel_out)) & ((bh0_out > line_out & bh1_out < line_out) | (bh1_out > line_out & bh0_out < line_out));	//magas, ha a k�k t�glalapot kell kirajzolni. Ez akkor lehets�ges, ha a sorsz�ml�l� az el��ll�tott jobb �s bal oldal k�z�tt van, �s az el��ll�tott fels� �s als� �rt�kek k�z�tt van

assign green[0] = ~(red_box | blue_box) & visible;			//a z�ld bitek akkor magasak, ha a piros �s k�k doboz bitek nem magasak, �s a sz�ml�l�k a l�that� tartom�nyban vannak
assign green[1] = green[0];										//ugyanaz mint az els� bitje
		
assign blue[0] = (~red_box & visible);							//a k�k bitek akkor magasak, ha a piros doboz bit nem magas �s a sz�ml�l�k a l�that� tartom�nyban vannak, vagy ha a z�ld bitek magasak
assign blue[1] = blue[0];											//ugyanaz mint az els� bitje
		
assign red[0] = red_box | green[0];								//a piros bitek akkor magasak, ha a piros doboz bit magas vagy a z�ld bit magas
assign red[1] = red[0];												//ugyanaz mint az els� bitje

endmodule
