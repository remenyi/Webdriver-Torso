`timescale 1ns / 1ps

//t�lthet� regiszter, ha az enged�lyez� jel magas

module Register #(parameter WIDTH = 9)(		//a regiszter nagys�g�t megad� param�ter
    input enable,										//enged�lyez� jel
	 input rst,
    input [WIDTH:0] in,								//bemen� jel
    output reg [WIDTH:0] out						//regiszter
    );					
					
always @ (posedge enable, posedge rst)							//ha az enged�lyez� jel magas...
begin
	if(rst) out <= 0;
	else out <= in;											//bet�ltj�k a bemen� �rt�ket a regiszterbe
end

endmodule
