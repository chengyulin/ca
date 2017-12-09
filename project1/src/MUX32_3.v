module MUX32_3(
	data1_i,
	data2_i,
	data3_i,
	select_i,
	data_o
);

input	[31:0]	data1_i, data2_i, data3_i;
input	[1:0]	select_i;
output	[31:0]	data_o;

reg	[31:0]	tmpdata_o;
assign data_o = tmpdata_o;

always @(*) begin
	if (select_i==2'b00) begin
		tmpdata_o = data1_i;
	end
	else if (select_i==2'b01) begin
		tmpdata_o = data2_i;
	end
	else begin
		tmpdata_o = data3_i;
	end
end

endmodule