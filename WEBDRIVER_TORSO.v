`timescale 1ns / 1ps

module WEBDRIVER_TORSO(
    input clk16M,								//bemenõ 16 MHz-es órajel
	 input rstbt,								//bemenõ resetjel
    output [12:4] aio						//kimenõ piros, zöld és kék képpont jelek, valamint a kimenõ pwm jel a hangszóróhoz
    );

//A bemenõ 16 Mhz-es órajelbõl állít elõ 25 Mhz-est
Clock_Converter clock_converter (
    .CLKIN_IN(clk16M),						//bemenõ 16 MHz-es órajel
	 .RST_IN(rstbt),							//resetelhetõ
    .CLKFX_OUT(clk25M)						//kijövõ 25 MHz-es órajel
    );


//A képi megjelenítés modul
Vga_Driver vga_driver (
    .clk(clk25M), 							//bemenõ órajel
    .rst(rstbt), 								//bemenõ reset jel
    .vsync(aio[11]), 						//kimenõ vertikális szinkronjel
    .hsync(aio[12]), 						//kimenõ horizontális szinkronjel
    .red(aio[6:5]), 							//kimenõ piros képpont jelek
    .green(aio[8:7]), 						//kimenõ zöld képpont jelek
    .blue(aio[10:9]),						//kimenõ kék képpont jelek
	 .sec(sec)									//kimenõ másodperc jelzõ vezeték
    );

//Hang modul 
Sound_Driver sound_driver (
    .clk(clk25M), 							//bemenõ órajel
    .rst(rstbt), 								//bemenõ reset jel
    .sec(sec), 								//bemenõ másodperc jelzõ vezeték
    .pwm(aio[4])								//kimenõ pwm jel
    );

endmodule
