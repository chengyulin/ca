module Shift_Left_26(
	data_i,
	data_o
);

input [25:0] data_i;
output [27:0] data_o;

assign data_o[27:2] = data_i;
assign data_o[2:0] = 2'b00;

endmodule