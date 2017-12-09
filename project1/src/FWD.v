module FWD(
	IDEX_RegRs_i,
	IDEX_RegRt_i,
	EXMEM_RegRd_i,
	EXMEM_RegWr_i,
	MEMWB_RegRd_i,
	MEMWB_RegWr_i,
	Fw1_o,
	Fw2_o
);

// Ports
input	[4:0]		IDEX_RegRs_i;
input	[4:0]		IDEX_RegRt_i;
input	[4:0]		EXMEM_RegRd_i;
input				EXMEM_RegWr_i;
input	[4:0]		MEMWB_RegRd_i;
input				MEMWB_RegWr_i;
output	[1:0]		Fw1_o;
output	[1:0]		Fw2_o;

// Wires & Registers
reg	[1:0]	tmpFw1_o;
reg	[1:0]	tmpFw2_o;
assign Fw1_o = tmpFw1_o;
assign Fw2_o = tmpFw2_o;

always@(*) begin
	if (EXMEM_RegWr_i && EXMEM_RegRd_i && IDEX_RegRs_i == EXMEM_RegRd_i) // from ALU, to Rs
		tmpFw1_o = 2'b10;
	else if (MEMWB_RegWr_i && MEMWB_RegRd_i && IDEX_RegRs_i == MEMWB_RegRd_i) // from DM, to Rs
		tmpFw1_o = 2'b01;
	else
		tmpFw1_o = 2'b00;

	if (EXMEM_RegWr_i && EXMEM_RegRd_i && IDEX_RegRt_i == EXMEM_RegRd_i) // from ALU, to Rt
		tmpFw2_o = 2'b10;
	else if (MEMWB_RegWr_i && MEMWB_RegWr_i && IDEX_RegRt_i == MEMWB_RegRd_i) // from DM, to Rt
		tmpFw2_o = 2'b01;
	else
		tmpFw2_o = 2'b00;	
end

endmodule