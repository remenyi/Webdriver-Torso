`timescale 1ns / 1ps

module Vga_Driver(
    input clk,																//bemenõ órajel
    input rst,																//bemenõ reset jel
    output vsync,															//kimenõ vertikális szinkronjel
    output hsync,															//kimenõ horizontális szinkronjel
    output [1:0] red,													//kimenõ piros jel
    output [1:0] green,													//kimenõ zöld jel
    output [1:0] blue,													//kimenõ kék jel
	 output sec 															//kimenõ másodperc jel (a random frekvenciák elõállításához kell)
    );											
												
wire [9:0] pixel_out;													//aktuális képpont száma van rajta
wire [8:0] line_out;														//aktuális sor száma van rajta

//szinkronjeleket elõállító modul
Sync_Generator sync_generator (
    .clk(clk), 															//bemenõ órajel	
    .rst(rst),  															//resetelhetõ
    .pixel_out(pixel_out), 											//kimenõ aktuális képpontszám
    .line_out(line_out), 												//kimenõ aktuális sorszám
	 .visible(visible),													//magas, ha a látható tartomány következik
    .hsync(hsync), 														//magas, ha a horizontális szinkronjel következik
    .vsync(vsync),														//magas, ha a vertiális szinkronjel következik
	 .p_rdy(p_rdy),														//magas, ha az elsõ (képpont) számláló egy ciklus végére ért
	 .l_rdy(l_rdy)															//magas, ha a második (sor) számláló egy ciklus végére ért
    );

//másodperc jelet elõállító modul
Timer timer (
    .clk(l_rdy), 															//csak akkor számol, ha véget ért a sorok számolása (ezzel csökkenteni lehet a számláló regiszter méretét)
    .rst(rst),																//resetelhetõ
    .tmr_rdy0(tmr_rdy0), 												//kimenõ másodperc jelzõ vezeték
    .tmr_rdy1(tmr_rdy1)													//kimenõ másodperc jelzõ vezeték, az elsõ elõtt kb. 17 ms-al elõbb jelez
    );									
assign sec = tmr_rdy0;													//az elsõ másodperc jelsõ vezetéket kivezetjük (a random frekvenciák elõállításához kell)

//random téglalapokat elõállító modul
wire [9:0] rw0_out, rw1_out;											//piros téglalap bal vagy jobb oldalai
wire [8:0] rh0_out, rh1_out;											//piros téglalap alsó vagy felsõ oldalai						
wire [9:0] bw0_out, bw1_out;											//kék téglalap bal vagy jobb oldalai
wire [8:0] bh0_out, bh1_out;											//kék téglalap alsó vagy felsõ oldalai
Random_Rectangle_Generator random_rectangle_generator (
    .clk(clk), 															//bemenõ órajel
    .rst(rst),																//resetelhetõ
	 .tmr_rdy0(tmr_rdy0),												//bemenõ másodperc jelzõ vezeték
	 .tmr_rdy1(tmr_rdy1),												//bemenõ másodperc jelzõ vezeték, az elsõ elõtt kb. 17 ms-al elõbb jelez
    .p_rdy(p_rdy),														//bemenõ vezeték, magas, ha az elsõ (képpont) számláló egy ciklus végére ért
    .rw0_out(rw0_out), 													//piros téglalap bal vagy jobb oldalai
    .rw1_out(rw1_out), 													//piros téglalap bal vagy jobb oldalai
    .rh0_out(rh0_out), 													//piros téglalap alsó vagy felsõ oldalai
    .rh1_out(rh1_out), 													//piros téglalap alsó vagy felsõ oldalai
    .bw0_out(bw0_out), 													//kék téglalap bal vagy jobb oldalai
    .bw1_out(bw1_out), 													//kék téglalap bal vagy jobb oldalai
    .bh0_out(bh0_out), 													//kék téglalap alsó vagy felsõ oldalai
    .bh1_out(bh1_out) 													//kék téglalap alsó vagy felsõ oldalai
    );

//Téglalapokat megjelenítõ modul	 
Rectangle_Display rectangle_display (
    .pixel_out(pixel_out), 											//bemenõ busz, az aktuális képpont száma van rajta
    .line_out(line_out), 												//bemenõ busz, aktuális sor száma van rajta
    .rw0_out(rw0_out), 													//piros téglalap bal vagy jobb oldalai
    .rw1_out(rw1_out), 													//piros téglalap bal vagy jobb oldalai
    .rh0_out(rh0_out), 													//piros téglalap alsó vagy felsõ oldalai
    .rh1_out(rh1_out), 													//piros téglalap alsó vagy felsõ oldalai
    .bw0_out(bw0_out), 													//kék téglalap bal vagy jobb oldalai
    .bw1_out(bw1_out), 													//kék téglalap bal vagy jobb oldalai
    .bh0_out(bh0_out), 													//kék téglalap alsó vagy felsõ oldalai
    .bh1_out(bh1_out), 													//kék téglalap alsó vagy felsõ oldalai
    .visible(visible), 													//bemenõ vezeték, magas, ha a látható tartomány következik
    .red(red), 															//kimenõ busz, magas, ha épp piros képpontokat akarunk megjeleníteni
    .green(green), 														//kimenõ busz, magas, ha épp zöld képpontokat akarunk megjeleníteni
    .blue(blue)															//kimenõ busz, magas, ha épp kék képpontokat akarunk megjeleníteni
    );

endmodule
