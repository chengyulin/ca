module ALU(
    data1_i,
    data2_i,
    ALUCtrl_i,
    data_o,
    Zero_o
);

input	[31:0]	data1_i;
input	[31:0]	data2_i;
input	[2:0]	ALUCtrl_i;
output	[31:0]	data_o;
output			Zero_o;

assign Zero_o = 1'b0;
reg	[31:0]	tmpdata_o;
assign data_o = tmpdata_o;


always @(*) begin
	case(ALUCtrl_i)
		3'b000: tmpdata_o = data1_i + data2_i;	// add
		3'b001: tmpdata_o = data1_i - data2_i;	// sub
		3'b010: tmpdata_o = data1_i & data2_i;	// and
		3'b011: tmpdata_o = data1_i | data2_i;	// or
		3'b100: tmpdata_o = data1_i * data2_i;	// mul
	endcase
	// $fdisplay(3, "alu result = %d", tmpdata_o);
end

endmodule