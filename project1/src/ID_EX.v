module ID_EX(
	clk_i,
	WB_i,
	M_i,
	EX_i,
	PC_i,
	RegData1_i,
	RegData2_i,
	SignExt_i,
	RegAddrRs_i,
	RegAddrRt_i,
	RegAddrRd_i,
	WB_o,
	M_o,
	ALUSrc_o,
	ALUOp_o,
	RegDst_o,
	PC_o,
	RegData1_o,
	RegData2_o,
	SignExt_o,
	RegAddrRs_o,
	RegAddrRt_o,
	RegAddrRd_o
);

input			clk_i;
input	[1:0]	WB_i, M_i;
input	[3:0]	EX_i;
input	[31:0]	PC_i, RegData1_i, RegData2_i, SignExt_i;
input	[4:0]	RegAddrRs_i, RegAddrRt_i, RegAddrRd_i;

output	[1:0]	WB_o, M_o;
output			ALUSrc_o;
output	[1:0]	ALUOp_o;
output			RegDst_o;
output	[31:0]	PC_o, RegData1_o, RegData2_o, SignExt_o;
output	[4:0]	RegAddrRs_o, RegAddrRt_o, RegAddrRd_o;

reg	[1:0]	tmpWB_o, tmpM_o;
reg			tmpALUSrc_o;
reg	[1:0]	tmpALUOp_o;
reg			tmpRegDst_o;
reg	[31:0]	tmpPC_o, tmpRegData1_o, tmpRegData2_o, tmpSignExt_o;
reg	[4:0]	tmpRegAddrRs_o, tmpRegAddrRt_o, tmpRegAddrRd_o;

assign WB_o = tmpWB_o;
assign M_o = tmpM_o;
assign ALUSrc_o = tmpALUSrc_o;
assign ALUOp_o = tmpALUOp_o;
assign RegDst_o = tmpRegDst_o;
assign PC_o = tmpPC_o;
assign RegData1_o = tmpRegData1_o;
assign RegData2_o = tmpRegData2_o;
assign SignExt_o = tmpSignExt_o;
assign RegAddrRs_o = tmpRegAddrRs_o;
assign RegAddrRt_o = tmpRegAddrRt_o;
assign RegAddrRd_o = tmpRegAddrRd_o;

initial begin
#10
	tmpWB_o = 0;
	tmpM_o = 0;
	tmpALUSrc_o = 0;
	tmpALUOp_o = 0;
	tmpRegDst_o = 0;
	tmpPC_o = 0;
	tmpRegData1_o = 0;
	tmpRegData2_o = 0;
	tmpSignExt_o = 0;
	tmpRegAddrRs_o = 0;
	tmpRegAddrRt_o = 0;
	tmpRegAddrRd_o = 0;
end

always @(posedge clk_i) begin
	tmpWB_o <= WB_i;
	tmpM_o <= M_i;
	tmpALUSrc_o <= EX_i[0];
	tmpALUOp_o <= EX_i[2:1];
	tmpRegDst_o <= EX_i[3];
	tmpPC_o <= PC_i;
	tmpRegData1_o <= RegData1_i;
	tmpRegData2_o <= RegData2_i;
	tmpSignExt_o <= SignExt_i;
	tmpRegAddrRs_o <= RegAddrRs_i;
	tmpRegAddrRt_o <= RegAddrRt_i;
	tmpRegAddrRd_o <= RegAddrRd_i;
end

endmodule