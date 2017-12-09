module MEM_WB(
	clk_i,
	WB_i,
	MemData_i,
	RegData_i,
	RegAddr_i,
	RegWrite_o,
	MemtoReg_o,
	MemData_o,
	RegData_o,
	RegAddr_o
);

input			clk_i;
input	[1:0]	WB_i;
input	[31:0]	MemData_i, RegData_i;
input	[4:0]	RegAddr_i;
output			RegWrite_o, MemtoReg_o;
output	[31:0]	MemData_o, RegData_o;
output	[4:0]	RegAddr_o;

reg			tmpRegWrite_o, tmpMemtoReg_o;
reg	[31:0]	tmpMemData_o, tmpRegData_o;
reg	[4:0]	tmpRegAddr_o;

assign RegWrite_o = tmpRegWrite_o;
assign MemtoReg_o = tmpMemtoReg_o;
assign MemData_o = tmpMemData_o;
assign RegData_o = tmpRegData_o;
assign RegAddr_o = tmpRegAddr_o;

// initial begin
// #20
// 	tmpRegWrite_o = 0;
// 	tmpMemtoReg_o = 0;
// 	tmpMemData_o = 0;
// 	tmpRegData_o = 0;
// 	tmpRegAddr_o = 0;
// end

always @ (posedge clk_i) begin
 	tmpRegWrite_o <= WB_i[0];
	tmpMemtoReg_o <= WB_i[1];
	tmpMemData_o <= MemData_i;
	tmpRegData_o <= RegData_i;
	tmpRegAddr_o <= RegAddr_i;
end

endmodule