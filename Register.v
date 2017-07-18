`timescale 1ns / 1ps

//tölthetõ regiszter, ha az engedélyezõ jel magas

module Register #(parameter WIDTH = 9)(		//a regiszter nagyságát megadó paraméter
    input enable,										//engedélyezõ jel
	 input rst,
    input [WIDTH:0] in,								//bemenõ jel
    output reg [WIDTH:0] out						//regiszter
    );					
					
always @ (posedge enable, posedge rst)							//ha az engedélyezõ jel magas...
begin
	if(rst) out <= 0;
	else out <= in;											//betöltjük a bemenõ értéket a regiszterbe
end

endmodule
