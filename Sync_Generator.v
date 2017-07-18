`timescale 1ns / 1ps

//A horizontális és vertikális szinkronjeleket elõállító modul

module Sync_Generator(
    input clk,															//bemenõ órajel
	 input rst,															//resetelhetõ
    output [9:0] pixel_out,										//egy sorban található képpontok sorszámát tartja nyilván
    output [9:0] line_out,											//egy keretben található sorok sorszámát tartja nyilván
	 output visible,													//magas, ha a látható tartomány következik
	 output hsync,														//magas, ha a horizontális szinkronjel következik
	 output vsync,														//magas, ha a vertikális szinkronjel következik
	 output p_rdy,														//magas, ha az elsõ (képpont) számláló befejezett egy ciklust
	 output l_rdy														//magas, ha a második (sor) számláló befejezett egy ciklust
    );
	 	 
//képpontok számlálója, 800 órajel hosszú ciklus, amit 10 biten lehet tárolni
Counter #(10, 798) pixel_counter (
    .clk(clk),	 														//minden órajelre számol
    .rst(rst),															//resetelhetõ
    .rdy(p_rdy), 														//jelzi, ha egy ciklus lement
    .out(pixel_out)													//a számláló aktuális értéke
    );										

//sorok számlálója 525 sor hosszú ciklus, amit 10 biten lehet tárolni 
Counter #(10, 523) line_counter (
    .clk(p_rdy), 														//csak akkor számol, ha a képpontok számlálója befejezett egy ciklust
    .rst(rst),															//resetelhetõ
	 .rdy(l_rdy),														//jelzi, ha egy ciklus lement
    .out(line_out)													//a számláló aktuális értéke
    );

assign visible = pixel_out < 640 & line_out < 480;			//magas, ha a számlálók a látható tartományban vannak, vagyis 640-nél kisebb a képpontszámláló, és 480-nál kisebb a sorszámláló
assign hsync = pixel_out >= 687 & pixel_out < 783; 		//kimenõ horizontális szinkronjel. Magas, ha a képpontszámláló nagyobb, mint a horizontális(h) látható szakasz plusz a h back porch (visszafelé számol a számláló!), és kisebb, mint a h látható szakasz plusz a h back porch plusz a h szinkronjel
assign vsync = line_out >= 512 & line_out < 514;			//kimenõ vertikális szinkronjel. Magas, ha a sorszámláló nagyobb, mint a vertikális(v) látható szakasz plusz a v back porch (visszafelé számol a számláló!), és kisebb, mint a v látható szakasz plusz a v back porch plusz a v szinkronjel



endmodule
