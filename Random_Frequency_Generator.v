`timescale 1ns / 1ps

//Random frekvenciát elõállító modul

module Random_Frequency_Generator(
    input clk,											//bejövõ órajel
    input rst,											//bejövõ reset jel
    input sec,											//bejövõ másodpercet jelzõ vezeték
    output [11:0] frequency						//kimenõ random frekvencia
    );
	 
wire [11:0] r_out;									//számláló aktuális értéke
Counter #(12, 3000) rnd_freq (					//3000-tõl 300-ig számoló számláló
    .clk(clk), 										//minden órajelre számol
    .rst(r_out < 300 | rst),						//ha elérte a 300-at, vagy az rst vezeték magas reseteljük
    .out(r_out)										//kimenõ busz, a számláló aktuális értékével
    );

Register #(11) frequency_reg (.enable(sec), .rst(rst), .in(r_out), .out(frequency));	//minden másodpecben a számláló értékét beleteszi a frekvenciát tároló regiszterbe

endmodule
