module Control(
    Op_i,
    RegDst_o,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o,
    MemWrite_o,
    MemRead_o,
    MemtoReg_o,
    Branch_o,
    Jump_o
);

// Ports
input	[5:0]		Op_i; // from wire_inst[31:26]
output				RegDst_o;
output	[1:0]		ALUOp_o;
output				ALUSrc_o;
output				RegWrite_o;
output				MemWrite_o;
output				MemRead_o;
output				MemtoReg_o;
output				Branch_o;
output				Jump_o;

// Wires & Registers
reg			tmpRegDst_o;
reg	[1:0]	tmpALUOp_o;
reg			tmpALUSrc_o;
reg			tmpRegWrite_o;
reg			tmpMemWrite_o;
reg			tmpMemRead_o;
reg			tmpMemtoReg_o;
reg			tmpBranch_o;
reg			tmpJump_o;

assign RegDst_o = tmpRegDst_o;
assign ALUOp_o = tmpALUOp_o;
assign ALUSrc_o = tmpALUSrc_o;
assign RegWrite_o = tmpRegWrite_o;
assign MemWrite_o = tmpMemWrite_o;
assign MemRead_o = tmpMemRead_o;
assign MemtoReg_o = tmpMemtoReg_o;
assign Branch_o = tmpBranch_o;
assign Jump_o = tmpJump_o;


always @(*) begin
	if(Op_i == 6'b001000) begin // addi
		tmpRegDst_o = 0;
		tmpALUOp_o = 2'b00;
		tmpALUSrc_o = 1;
		tmpRegWrite_o = 1;
		tmpMemWrite_o = 0;
		tmpMemRead_o = 0;
		tmpMemtoReg_o = 0; 
		tmpBranch_o = 0;
		tmpJump_o = 0;
	end
	else if (Op_i == 6'b000000) begin // R-type
		tmpRegDst_o = 1;
		tmpALUOp_o = 2'b10;
		tmpALUSrc_o = 0;
		tmpRegWrite_o = 1;
		tmpMemWrite_o = 0;
		tmpMemRead_o = 0;
		tmpMemtoReg_o = 0;
		tmpBranch_o = 0;
		tmpJump_o = 0;
	end
	else if (Op_i == 6'b100011) begin // lw instruction
		tmpRegDst_o = 0;
		tmpALUOp_o = 2'b00;
		tmpALUSrc_o = 1;
		tmpRegWrite_o = 1;
		tmpMemWrite_o = 0;
		tmpMemRead_o = 1;
		tmpMemtoReg_o = 1;
		tmpBranch_o = 0;
		tmpJump_o = 0;
	end
	else if (Op_i == 6'b101011) begin // sw instruction
		tmpRegDst_o = 0;
		tmpALUOp_o = 2'b00;
		tmpALUSrc_o = 1;
		tmpRegWrite_o = 0;
		tmpMemWrite_o = 1;
		tmpMemRead_o = 0;
		tmpMemtoReg_o = 1; //<-
		tmpBranch_o = 0;
		tmpJump_o = 0;
	end
	else if (Op_i == 6'b000100) begin // beq instruction
		tmpRegDst_o = 0; // don't care
		tmpALUOp_o = 2'b01; // don't care
		tmpALUSrc_o = 0; // don't care <-
		tmpRegWrite_o = 0;
		tmpMemWrite_o = 0;
		tmpMemRead_o = 0;
		tmpMemtoReg_o = 0; // don't care <-
		tmpBranch_o = 1;
		tmpJump_o = 0;
	end
	else if (Op_i == 6'b000010) begin // j instruction
		tmpRegDst_o = 0; // don't care
		tmpALUOp_o = 2'b00; // don't care
		tmpALUSrc_o = 0; // don't care <-
		tmpRegWrite_o = 0;
		tmpMemWrite_o = 0;
		tmpMemRead_o = 0;
		tmpMemtoReg_o = 0; // don't care <-
		tmpBranch_o = 0;
		tmpJump_o = 1;
	end
	else begin // just do something
		tmpRegDst_o = 0;
		tmpALUOp_o = 2'b00;
		tmpALUSrc_o = 0;
		tmpRegWrite_o = 0;
		tmpMemWrite_o = 0;
		tmpMemRead_o = 0;
		tmpMemtoReg_o = 0;
		tmpBranch_o = 0;
		tmpJump_o = 0;
	end
end

endmodule