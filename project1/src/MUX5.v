module MUX5(
	data1_i,
	data2_i,
	select_i,
	data_o
);

input	[4:0]	data1_i;
input	[4:0]	data2_i;
input			select_i;
output	[4:0]	data_o;

reg	[4:0]	tmpdata_o;
assign data_o = tmpdata_o;

always @(*) begin
	if (select_i) begin
		tmpdata_o = data2_i;
	end
	else begin
		tmpdata_o = data1_i;
	end
end
// assign data_o = select_i ? data2_i : data1_i;

endmodule