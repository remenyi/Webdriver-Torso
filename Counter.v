`timescale 1ns / 1ps

//Lefelé számláló számláló. A számláló regiszternek plusz egy bitje van, mivel a számláló nulla után alulcsordul, magasba állítva a msb bitet.
//így csak egyetlenegy bitet kell megvizsgálni, nem az összeset.

module Counter #(parameter WIDTH = 8, parameter LIMIT = 127)( 	//a számláló regiszter nagysága és értéke (mindig kettõvel kisebb értéket kell megadni, mivel 0 után a számláló regiszter átvált csupa egyesbe)
    input clk,																	//órajel
    input rst,																	//reset jel
    output rdy,																//magas, ha egy ciklus véget ért
    output [WIDTH-1:0] out													//a számláló regiszter értéke (leszámítva a msb-t)
    );				
					
reg[WIDTH:0] counter = {0,LIMIT};										//számláló regiszter
assign rdy = counter[WIDTH];												//ha a msb bit magas, akkor véget ért a számlálás
assign out = counter[WIDTH-1:0];											//a kimenet a számláló regiszter a msb kivételével
				
always @ (posedge clk)				
begin				
	if(rst)counter <= {0,LIMIT};											//resetelhetõ
	else if(!counter[WIDTH])counter <= counter-1;					//ha nem magas a msb, akkor kivonunk
	else counter <= {0,LIMIT};												//ha magas, az azt jelenti, hogy a számlálás véget ért
end

endmodule
