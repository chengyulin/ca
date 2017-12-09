module Sign_Extend(
    data_i,
    data_o
);

input	[15:0]	data_i;
output	[31:0]	data_o;

reg	[31:0]	tmpdata_o;
assign data_o = tmpdata_o;

always @(*) begin
	tmpdata_o[15:0] = data_i;
	if (data_i[15]) begin
		tmpdata_o[31:16] = 16'd255;
	end
	else begin
		tmpdata_o[31:16] = 16'd0;
	end
end

endmodule