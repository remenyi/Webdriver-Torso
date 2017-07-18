`timescale 1ns / 1ps

//Random piros �s k�k t�glalapokat el��ll�t� modul

module Random_Rectangle_Generator(
    input clk,															//bemen� �rajel
	 input rst,															//bemen� reset
    input p_rdy,														//bemen� vezet�k, magas, ha v�gzett a k�ppontsz�ml�l�
	 input tmr_rdy0,													//bemen� vezet�k, magas, ha eltelt egy m�sodperc
	 input tmr_rdy1,													//bemen� vezet�k, magas, ha eltelt egy m�sodperc, az els� el�tt kb. 17 ms-al el�bb jelez
	 output [9:0] rw0_out, rw1_out,								//piros t�glalap bal vagy jobb oldalai
	 output [8:0] rh0_out, rh1_out,								//piros t�glalap als� vagy fels� oldalai						
	 output [9:0] bw0_out, bw1_out,								//k�k t�glalap bal vagy jobb oldalai	 
	 output [8:0] bh0_out, bh1_out								//k�k t�glalap als� vagy fels� oldalai
    );

wire [9:0] w0_in, w1_in;											//mindk�t t�glalap bal vagy jobb oldalai (width)
wire [8:0] h0_in, h1_in;											//mindk�t t�glalap als� vagy fels� oldalai (height)
							
Random_Counter #(9, 640) random_width0 (						//mindk�t t�glalap bal vagy jobb oldal�t el��ll�t� sz�ml�l� (0-t�l 639-ig plusz 2^10 is)
    .clk(clk), 														//minden �rajelre sz�mol
    .rst(rst), 														//resetelhet�
    .out(w0_in)														//sz�ml�l� regiszer �rt�ke
    );
	 
Register #(9) red_width0(.enable(tmr_rdy0), .rst(rst), .in(w0_in), .out(rw0_out));			//elt�roljuk a bal vagy jobb oldalt, ha letelt egy m�sodperc
Register #(9) blue_width0(.enable(tmr_rdy1), .rst(rst), .in(w0_in), .out(bw0_out));		//elt�roljuk a bal vagy jobb oldalt, ha letelt egy m�sodperc (17 ms-el az el�z� el�tt)
	 
Random_Counter #(9, 640) random_width1 (						//mindk�t t�glalap m�sik bal vagy jobb oldal�t el��ll�t� sz�ml�l�
    .clk(p_rdy), 														//akkor sz�mol, ha a k�ppontsz�ml�l� befejezett egy ciklust (ezzel elker�lhet�, hogy a random_width0 sz�ml�l�val megegyez� �rt�keket kapjunk)
    .rst(rst),															//resetelhet�
    .out(w1_in)														//sz�ml�l� regiszter �rt�ke
    );
	 
Register #(9) red_width1(.enable(tmr_rdy0), .rst(rst), .in(w1_in), .out(rw1_out));			//elt�roljuk a m�sik bal vagy jobb oldalt, ha letelt egy m�sodperc
Register #(9) blue_width1(.enable(tmr_rdy1), .rst(rst), .in(w1_in), .out(bw1_out));		//elt�roljuk a m�sik bal vagy jobb oldalt, ha letelt egy m�sodperc (17 ms-el az el�z� el�tt)

Random_Counter #(8, 480) random_height0 (						//mindk�t t�glalap als� vagy f�ls� oldal�t el��ll�t� sz�ml�l�
    .clk(clk), 														//minden �rajelre sz�mol
    .rst(rst), 														//resetelhet�
    .out(h0_in)														//sz�ml�l� regiszter �rt�ke
    );
	 
Register #(8) red_height0(.enable(tmr_rdy0), .rst(rst), .in(h0_in), .out(rh0_out));		//elt�roljuk az als� vagy fels� oldalt, ha letelt egy m�sodperc
Register #(8) blue_height0(.enable(tmr_rdy1), .rst(rst), .in(h0_in), .out(bh0_out));		//elt�roljuk az als� vagy fels� oldalt, ha letelt egy m�sodperc (17 ms-el az el�z� el�tt)
	 
Random_Counter #(8, 480) random_height1 (						//mindk�t t�glalap m�sik als� vagy f�ls� oldal�t el��ll�t� sz�ml�l�
    .clk(p_rdy),														//akkor sz�mol, ha a k�ppontsz�ml�l� befejezett egy ciklust (ezzel elker�lhet�, hogy a random_height0 sz�ml�l�val megegyez� �rt�keket kapjunk)
    .rst(rst), 														//resetelhet�
    .out(h1_in)														//sz�ml�l� regiszter �rt�ke
    );

Register #(8) red_height1(.enable(tmr_rdy0), .rst(rst), .in(h1_in), .out(rh1_out));		//elt�roljuk a m�sik als� vagy fels� oldalt, ha letelt egy m�sodperc
Register #(8) blue_height1(.enable(tmr_rdy1), .rst(rst), .in(h1_in), .out(bh1_out));		//elt�roljuk a m�sik als� vagy fels� oldalt, ha letelt egy m�sodperc (17 ms-el az el�z� el�tt)

endmodule
