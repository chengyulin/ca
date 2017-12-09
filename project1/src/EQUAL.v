module EQUAL
(
	data1_i,
	data2_i,
	eq_o
);

input [31:0] data1_i, data2_i;
output eq_o;
reg	tmpeq_o;
assign eq_o = tmpeq_o;

always @(*) begin
	if (data1_i == data2_i) begin
		tmpeq_o = 1'b1;
	end
	else begin
		tmpeq_o = 1'b0;
	end
end
// assign eq_o = (data1_i == data2_i)? 1:0;

endmodule