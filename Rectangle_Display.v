`timescale 1ns / 1ps

module Rectangle_Display(
	 input [9:0] pixel_out,											//bemenõ busz, rajta az aktuális képpontszámmal
	 input [9:0] line_out,											//bemenõ busz, rajta az aktuális sorszámmal
	 input [9:0] rw0_out, rw1_out,								//piros téglalap bal vagy jobb oldalai
	 input [8:0] rh0_out, rh1_out,								//piros téglalap alsó vagy felsõ oldalai						
	 input [9:0] bw0_out, bw1_out,								//kék téglalap bal vagy jobb oldalai
	 input [8:0] bh0_out, bh1_out,								//kék téglalap alsó vagy felsõ oldalai
	 input visible,													//bemenõ vezeték, magas, ha a látható szakasz következik
    output [1:0] red,												//kimenõ busz, magas ha épp piros képpontokat akarunk megjeleníteni
    output [1:0] green,												//kimenõ busz, magas ha épp zöld képpontokat akarunk megjeleníteni
    output [1:0] blue												//kimenõ busz, magas ha épp kék képpontokat akarunk megjeleníteni
    );

assign red_box = ((rw0_out > pixel_out & rw1_out < pixel_out) | (rw1_out > pixel_out & rw0_out < pixel_out)) & ((rh0_out > line_out & rh1_out < line_out) | (rh1_out > line_out & rh0_out < line_out));	//magas, ha a piros téglalapot kell kirajzolni. Ez akkor lehetséges, ha a képpontszámláló az elõállított jobb és bal oldal között van (a két értékrõl onnan tudjuk eldönteni, hogy melyik a jobb(a magasabb) vagy bal(az alacsonyabb), hogy mindkét lehetõséget megvizsgáljuk), és az elõállított felsõ és alsó értékek között van

assign blue_box = ((bw0_out > pixel_out & bw1_out < pixel_out) | (bw1_out > pixel_out & bw0_out < pixel_out)) & ((bh0_out > line_out & bh1_out < line_out) | (bh1_out > line_out & bh0_out < line_out));	//magas, ha a kék téglalapot kell kirajzolni. Ez akkor lehetséges, ha a sorszámláló az elõállított jobb és bal oldal között van, és az elõállított felsõ és alsó értékek között van

assign green[0] = ~(red_box | blue_box) & visible;			//a zöld bitek akkor magasak, ha a piros és kék doboz bitek nem magasak, és a számlálók a látható tartományban vannak
assign green[1] = green[0];										//ugyanaz mint az elsõ bitje
		
assign blue[0] = (~red_box & visible);							//a kék bitek akkor magasak, ha a piros doboz bit nem magas és a számlálók a látható tartományban vannak, vagy ha a zöld bitek magasak
assign blue[1] = blue[0];											//ugyanaz mint az elsõ bitje
		
assign red[0] = red_box | green[0];								//a piros bitek akkor magasak, ha a piros doboz bit magas vagy a zöld bit magas
assign red[1] = red[0];												//ugyanaz mint az elsõ bitje

endmodule
