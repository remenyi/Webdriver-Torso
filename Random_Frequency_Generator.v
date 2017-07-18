`timescale 1ns / 1ps

//Random frekvenci�t el��ll�t� modul

module Random_Frequency_Generator(
    input clk,											//bej�v� �rajel
    input rst,											//bej�v� reset jel
    input sec,											//bej�v� m�sodpercet jelz� vezet�k
    output [11:0] frequency						//kimen� random frekvencia
    );
	 
wire [11:0] r_out;									//sz�ml�l� aktu�lis �rt�ke
Counter #(12, 3000) rnd_freq (					//3000-t�l 300-ig sz�mol� sz�ml�l�
    .clk(clk), 										//minden �rajelre sz�mol
    .rst(r_out < 300 | rst),						//ha el�rte a 300-at, vagy az rst vezet�k magas resetelj�k
    .out(r_out)										//kimen� busz, a sz�ml�l� aktu�lis �rt�k�vel
    );

Register #(11) frequency_reg (.enable(sec), .rst(rst), .in(r_out), .out(frequency));	//minden m�sodpecben a sz�ml�l� �rt�k�t beleteszi a frekvenci�t t�rol� regiszterbe

endmodule
