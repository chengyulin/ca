module Shift_Left_32(
	data_i,
	data_o
);

input [31:0] data_i;
output [31:0] data_o;

assign data_o[31:2] = data_i[29:0];
assign data_o[2:0] = 2'b00;

endmodule
