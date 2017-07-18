`timescale 1ns / 1ps

module Sound_Driver(
    input clk,																	//bemenõ órajel: 16mhz
	 input rst,																	//reset gomb
	 input sec,																	//minden másodpercben jelez
	 output pwm																	//kimenõ pwm jel
    );												
												
wire [11:0] frequency;														//aktuális frekvencia értéke van rajta

//random frekvenciát elõállító modul
Random_Frequency_Generator random_frequency_generator (
    .clk(clk), 																//bemenõ órajel
    .rst(rst), 																//resetelhetõ
    .sec(sec), 																//bemenõ másodperc jelzõ vezeték
    .frequency(frequency)													//kimenõ véletlenszerûen generált frekvencia
    );

//frekvenciát pwm jellé átalakító modul
Frequency_To_PWM frequency_to_pwm (
    .clk(clk),    															//bemenõ órajel
    .rst(rst), 																//resetelhetõ
    .frequency(frequency), 												//bemenõ véletlenszerû frekvencia
    .pwm(pwm)																	//kimenõ pwm jel
    );

endmodule