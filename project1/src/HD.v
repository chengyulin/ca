module HD(
	instr_i,
	ID_EX_RegRt_i,
	MemRead_i,
	PC_o,
	IF_ID_o,
	mux8_o
);


// Ports

input	[31:0]		instr_i;
input	[4:0]		ID_EX_RegRt_i;
input				MemRead_i;
output				PC_o;
output				IF_ID_o;
output				mux8_o;


reg 	tmpPC_o;
reg 	tmpIF_ID_o;
reg 	tmpmux8_o;
assign PC_o = tmpPC_o;
assign IF_ID_o = tmpIF_ID_o;
assign mux8_o = tmpmux8_o;

always@(*) begin
	if (MemRead_i && ( ID_EX_RegRt_i == instr_i[25:21] || ID_EX_RegRt_i == instr_i[20:16] )) begin
		tmpPC_o = 1'b1;
		tmpIF_ID_o = 1'b1;
		tmpmux8_o = 1'b1;
	end
	else begin
		tmpPC_o = 1'b0;
		tmpIF_ID_o = 1'b0;
		tmpmux8_o = 1'b0;
	end
end

endmodule