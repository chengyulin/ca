module IF_ID(
	clk_i,
	Stall_i,
	PC_i,
	instruction_i,
	Flush_i,
	PC_o,
	instruction_o
);

input			clk_i;
input			Stall_i;
input			Flush_i;
input	[31:0]	PC_i;
input	[31:0]	instruction_i;
output	[31:0]	PC_o;
output	[31:0]	instruction_o;

reg	[31:0]	tmpPC_o;
reg	[31:0]	tmpinstruction_o;
assign PC_o = tmpPC_o;
assign instruction_o = tmpinstruction_o;

initial begin
#5
	tmpPC_o = 0;
	tmpinstruction_o = 0;	
end


always @(posedge clk_i) begin
	if (Stall_i) begin
		tmpPC_o = PC_o;
		tmpinstruction_o = instruction_o;
	end
	else if (Flush_i) begin
		tmpPC_o = 32'd0;
		tmpinstruction_o = 32'd0;
	end
	else begin
		tmpPC_o = PC_i;
		tmpinstruction_o = instruction_i;
	end
end

endmodule