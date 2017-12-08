module ALU_Control
(
	funct_i,
	ALUOp_i,
	ALUCtrl_o
);

input [5:0] funct_i;
input [1:0] ALUOp_i;
output [2:0] ALUCtrl_o;
reg [2:0] tmp;

assign ALUCtrl_o = tmp;

always@(*) begin
	if(ALUOp_i == 2'd0) begin //add
		tmp = 3'b010;
	end
	else begin
		case(funct_i)
			6'b100000:	tmp = 3'b010;//add
			6'b100010:	tmp = 3'b011;//sub
			6'b100100:	tmp = 3'b000;//and
			6'b100101:	tmp = 3'b001;//or
			6'b011000:	tmp = 3'b111;//mul
		endcase
	end
end

endmodule