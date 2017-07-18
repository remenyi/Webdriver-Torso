`timescale 1ns / 1ps

module WEBDRIVER_TORSO(
    input clk16M,								//bemen� 16 MHz-es �rajel
	 input rstbt,								//bemen� resetjel
    output [12:4] aio						//kimen� piros, z�ld �s k�k k�ppont jelek, valamint a kimen� pwm jel a hangsz�r�hoz
    );

//A bemen� 16 Mhz-es �rajelb�l �ll�t el� 25 Mhz-est
Clock_Converter clock_converter (
    .CLKIN_IN(clk16M),						//bemen� 16 MHz-es �rajel
	 .RST_IN(rstbt),							//resetelhet�
    .CLKFX_OUT(clk25M)						//kij�v� 25 MHz-es �rajel
    );


//A k�pi megjelen�t�s modul
Vga_Driver vga_driver (
    .clk(clk25M), 							//bemen� �rajel
    .rst(rstbt), 								//bemen� reset jel
    .vsync(aio[11]), 						//kimen� vertik�lis szinkronjel
    .hsync(aio[12]), 						//kimen� horizont�lis szinkronjel
    .red(aio[6:5]), 							//kimen� piros k�ppont jelek
    .green(aio[8:7]), 						//kimen� z�ld k�ppont jelek
    .blue(aio[10:9]),						//kimen� k�k k�ppont jelek
	 .sec(sec)									//kimen� m�sodperc jelz� vezet�k
    );

//Hang modul 
Sound_Driver sound_driver (
    .clk(clk25M), 							//bemen� �rajel
    .rst(rstbt), 								//bemen� reset jel
    .sec(sec), 								//bemen� m�sodperc jelz� vezet�k
    .pwm(aio[4])								//kimen� pwm jel
    );

endmodule
