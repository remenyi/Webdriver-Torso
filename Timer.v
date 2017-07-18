`timescale 1ns / 1ps

//Egy másodperc leteltét jelzõ modul

module Timer(
    input clk,															//bemenõ órajel
    input rst,															//bemenõ reset
    output tmr_rdy0,													//kimenõ másodperc jelzõ vezeték
    output tmr_rdy1													//kimenõ másodperc jelzõ vezeték, az elsõ elõtt kb. 17 ms-al elõbb jelez
    );

wire [5:0] timer_out;												//az óra számláló regiszter értéke

//másodperc számláló, 60 frame hosszú ciklus, amit 6 biten lehet tárolni (a sorszámláló számláló ready vezetékét használja számláláshoz, így elég 6 bit)
Counter #(6, 58) timer (
    .clk(clk), 														//csak akkor számol, ha befejezõdött a sorok számolása (felhasználva azt, hogy a szabvány szerinti frissítési sebesség 60 Hz)
    .rst(rst),															//resetelhetõ
    .rdy(tmr_rdy0),													//jelzi, ha letelt egy másodperc
	 .out(timer_out)													//a számláló kimenõ értéke
    );

assign tmr_rdy1 = timer_out == 1;								//egy másik vezetéken is jelezzük az egy másodperc leteltét 25 000 000 / 60 órajellel elõtte (kb. 17 ms idõ)

endmodule
