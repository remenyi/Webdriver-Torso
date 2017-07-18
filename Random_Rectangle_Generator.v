`timescale 1ns / 1ps

//Random piros és kék téglalapokat elõállító modul

module Random_Rectangle_Generator(
    input clk,															//bemenõ órajel
	 input rst,															//bemenõ reset
    input p_rdy,														//bemenõ vezeték, magas, ha végzett a képpontszámláló
	 input tmr_rdy0,													//bemenõ vezeték, magas, ha eltelt egy másodperc
	 input tmr_rdy1,													//bemenõ vezeték, magas, ha eltelt egy másodperc, az elsõ elõtt kb. 17 ms-al elõbb jelez
	 output [9:0] rw0_out, rw1_out,								//piros téglalap bal vagy jobb oldalai
	 output [8:0] rh0_out, rh1_out,								//piros téglalap alsó vagy felsõ oldalai						
	 output [9:0] bw0_out, bw1_out,								//kék téglalap bal vagy jobb oldalai	 
	 output [8:0] bh0_out, bh1_out								//kék téglalap alsó vagy felsõ oldalai
    );

wire [9:0] w0_in, w1_in;											//mindkét téglalap bal vagy jobb oldalai (width)
wire [8:0] h0_in, h1_in;											//mindkét téglalap alsó vagy felsõ oldalai (height)
							
Random_Counter #(9, 640) random_width0 (						//mindkét téglalap bal vagy jobb oldalát elõállító számláló (0-tól 639-ig plusz 2^10 is)
    .clk(clk), 														//minden órajelre számol
    .rst(rst), 														//resetelhetõ
    .out(w0_in)														//számláló regiszer értéke
    );
	 
Register #(9) red_width0(.enable(tmr_rdy0), .rst(rst), .in(w0_in), .out(rw0_out));			//eltároljuk a bal vagy jobb oldalt, ha letelt egy másodperc
Register #(9) blue_width0(.enable(tmr_rdy1), .rst(rst), .in(w0_in), .out(bw0_out));		//eltároljuk a bal vagy jobb oldalt, ha letelt egy másodperc (17 ms-el az elõzõ elõtt)
	 
Random_Counter #(9, 640) random_width1 (						//mindkét téglalap másik bal vagy jobb oldalát elõállító számláló
    .clk(p_rdy), 														//akkor számol, ha a képpontszámláló befejezett egy ciklust (ezzel elkerülhetõ, hogy a random_width0 számlálóval megegyezõ értékeket kapjunk)
    .rst(rst),															//resetelhetõ
    .out(w1_in)														//számláló regiszter értéke
    );
	 
Register #(9) red_width1(.enable(tmr_rdy0), .rst(rst), .in(w1_in), .out(rw1_out));			//eltároljuk a másik bal vagy jobb oldalt, ha letelt egy másodperc
Register #(9) blue_width1(.enable(tmr_rdy1), .rst(rst), .in(w1_in), .out(bw1_out));		//eltároljuk a másik bal vagy jobb oldalt, ha letelt egy másodperc (17 ms-el az elõzõ elõtt)

Random_Counter #(8, 480) random_height0 (						//mindkét téglalap alsó vagy fölsõ oldalát elõállító számláló
    .clk(clk), 														//minden órajelre számol
    .rst(rst), 														//resetelhetõ
    .out(h0_in)														//számláló regiszter értéke
    );
	 
Register #(8) red_height0(.enable(tmr_rdy0), .rst(rst), .in(h0_in), .out(rh0_out));		//eltároljuk az alsó vagy felsõ oldalt, ha letelt egy másodperc
Register #(8) blue_height0(.enable(tmr_rdy1), .rst(rst), .in(h0_in), .out(bh0_out));		//eltároljuk az alsó vagy felsõ oldalt, ha letelt egy másodperc (17 ms-el az elõzõ elõtt)
	 
Random_Counter #(8, 480) random_height1 (						//mindkét téglalap másik alsó vagy fölsõ oldalát elõállító számláló
    .clk(p_rdy),														//akkor számol, ha a képpontszámláló befejezett egy ciklust (ezzel elkerülhetõ, hogy a random_height0 számlálóval megegyezõ értékeket kapjunk)
    .rst(rst), 														//resetelhetõ
    .out(h1_in)														//számláló regiszter értéke
    );

Register #(8) red_height1(.enable(tmr_rdy0), .rst(rst), .in(h1_in), .out(rh1_out));		//eltároljuk a másik alsó vagy felsõ oldalt, ha letelt egy másodperc
Register #(8) blue_height1(.enable(tmr_rdy1), .rst(rst), .in(h1_in), .out(bh1_out));		//eltároljuk a másik alsó vagy felsõ oldalt, ha letelt egy másodperc (17 ms-el az elõzõ elõtt)

endmodule
