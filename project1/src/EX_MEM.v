module EX_MEM(
	clk_i,
	WB_i,
	M_i,
	RegData_i,
	MemData_i,
	RegAddr_i,
	WB_o,
	MemRead_o,
	MemWrite_o,
	RegData_o,
	MemData_o,
	RegAddr_o
);

input			clk_i;
input	[1:0]	WB_i, M_i;
input	[4:0]	RegAddr_i;
input	[31:0]	RegData_i, MemData_i;
output			MemRead_o, MemWrite_o;
output	[1:0]	WB_o;
output	[4:0]	RegAddr_o;
output	[31:0]	RegData_o, MemData_o;

reg			tmpMemRead_o, tmpMemWrite_o;
reg	[1:0]	tmpWB_o;
reg	[4:0]	tmpRegAddr_o;
reg	[31:0]	tmpRegData_o, tmpMemData_o;

assign MemRead_o = tmpMemRead_o;
assign MemWrite_o = tmpMemWrite_o;
assign WB_o = tmpWB_o;
assign RegAddr_o = tmpRegAddr_o;
assign RegData_o = tmpRegData_o;
assign MemData_o = tmpMemData_o;

initial begin
#15
	tmpMemRead_o = 0;
	tmpMemWrite_o = 0;
	tmpWB_o = 0;
	tmpRegAddr_o = 0;
	tmpRegData_o = 0;
	tmpMemData_o = 0;
end

always @ (posedge clk_i) begin
	tmpMemRead_o <= M_i[0];
	tmpMemWrite_o <= M_i[1];
	tmpWB_o <= WB_i;
	tmpRegAddr_o <= RegAddr_i;
	tmpRegData_o <= RegData_i;
	tmpMemData_o <= MemData_i;
end

endmodule