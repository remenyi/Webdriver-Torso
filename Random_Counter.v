`timescale 1ns / 1ps

//Egyszerû felfelé számláló számláló

module Random_Counter #(parameter WIDTH = 8, parameter LIMIT = 255)( 	//a számláló regiszter nagysága és értéke
    input clk,																				//órajel
    input rst,																				//reset jel
    output [WIDTH:0] out																//a számláló regiszter értéke 
    );											
												
reg [WIDTH:0] counter = 0;																//számláló regiszter
assign out = counter;																	//kimenõ számláló regiszter értéke

always @ (posedge clk)
begin
	if(rst)counter <= 0;																	//resetelhetõ
	else if(counter < LIMIT)counter <= counter + 1;								//ha nem éri el a limitet, hozzáadunk a számlálóhoz egyet
	else counter <= 0;																	//ha elérte, akkor lenullázuk a számlálót
end							
endmodule
