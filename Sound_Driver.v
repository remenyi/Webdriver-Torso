`timescale 1ns / 1ps

module Sound_Driver(
    input clk,																	//bemen� �rajel: 16mhz
	 input rst,																	//reset gomb
	 input sec,																	//minden m�sodpercben jelez
	 output pwm																	//kimen� pwm jel
    );												
												
wire [11:0] frequency;														//aktu�lis frekvencia �rt�ke van rajta

//random frekvenci�t el��ll�t� modul
Random_Frequency_Generator random_frequency_generator (
    .clk(clk), 																//bemen� �rajel
    .rst(rst), 																//resetelhet�
    .sec(sec), 																//bemen� m�sodperc jelz� vezet�k
    .frequency(frequency)													//kimen� v�letlenszer�en gener�lt frekvencia
    );

//frekvenci�t pwm jell� �talak�t� modul
Frequency_To_PWM frequency_to_pwm (
    .clk(clk),    															//bemen� �rajel
    .rst(rst), 																//resetelhet�
    .frequency(frequency), 												//bemen� v�letlenszer� frekvencia
    .pwm(pwm)																	//kimen� pwm jel
    );

endmodule