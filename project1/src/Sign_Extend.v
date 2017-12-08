module Sign_Extend
(
	data_i,
	data_o
);

input [15:0] data_i;
output [31:0] data_o;

assign data_o = ( data_i[15]==1'b1) ? {16'b1111111111111111,data_i}:{16'b0000000000000000,data_i};
//if the 16-bit number is negative, add 16 ones to make it 32-bit
//if the 16-bit number is positive, add 16 zeroes to make it 32-bit

endmodule