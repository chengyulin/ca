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
	if(ALUOp_i == 2'b00) begin // addi
		tmp = 3'b000;
	end
	else if(ALUOp_i == 2'b01) begin // sub
		tmp = 3'b001;
	end
	else if(ALUOp_i == 2'b10) begin
		case(funct_i)
			6'b100000:	tmp = 3'b000; //add
			6'b100010:	tmp = 3'b001; //sub
			6'b100100:	tmp = 3'b010; //and
			6'b100101:	tmp = 3'b011; //or
			6'b011000:	tmp = 3'b100; //mul
		endcase
	end
end

// always @(*) begin
// 	if(ALUOp_i == 2'b10) begin
// 		case(funct_i)
// 			6'b100000:	tmp = 3'b000; // add
// 			6'b100010:	tmp = 3'b001; // sub
// 			6'b100100:	tmp = 3'b010; // and
// 			6'b100101:	tmp = 3'b011; // or
// 			6'b011000:	tmp = 3'b100; // mul
// 			default:	tmp = 3'b111;
// 		endcase
// 	end
// 	else if(ALUOp_i == 2'b01) begin
// 		tmp = 3'b001;
// 	end
// 	else begin
// 		tmp = 3'b000; // addi
// 	end
// end

endmodule