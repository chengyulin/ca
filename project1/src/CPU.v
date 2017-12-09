module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;

//wire[31:0]  inst_addr, inst;
wire    [31:0]      wire_pc;
wire    [31:0]      wire_pc_ret;
wire    [31:0]      wire_ifid_pc_ret;
wire    [31:0]      wire_inst;
wire    [31:0]      wire_ifid_inst;
wire                wire_reg_dst; // from Control
wire                wire_reg_wr; // from Control
wire                wire_alu_src; // from Control
wire                wire_ctrl_mtr; // from Control to mux32 WBSrc
wire                wire_ctrl_mw; // from Control to Data_Memory
wire                wire_ctrl_mr; // from Control to Data_Memory
wire                wire_ctrl_br; // from Control to AND_Branch
wire                wire_ctrl_j; // from Control to MUX_Jump
wire                wire_zero; // from EQ to AND_Branch
wire                wire_isbr; // from AND_Branch to MUX_Branch
wire    [1:0]       wire_alu_op; // from Control
wire    [2:0]       wire_alu_ctrl; // from ALU_Control
wire    [4:0]       wire_wr_reg; // from MUX5
wire    [31:0]      wire_data1; // from Registers
wire    [31:0]      wire_data2; // from Registers
wire    [31:0]      wire_sign_ext; // from Sign_Extend
wire    [31:0]      wire_mux32_alusrc; // from MUX32 alusrc
wire    [31:0]      wire_mux32_wbsrc; // from MUX32 wbsrc
wire    [31:0]      wire_mux32_br; // from MUX_Branch
wire    [31:0]      wire_mux32_j; // from MUX_Jump
wire    [31:0]      wire_alu_out; // from ALU
wire    [31:0]      wire_mem_out; // from Data_Memory
wire    [31:0]      wire_sll_br; // from ssl_branch
wire    [31:0]      wire_sll_j; // from ssl_j
wire    [31:0]      wire_add_br; // from Add_Branch

wire            wire_memwb_ctrl_rw;
wire            wire_memwb_ctrl_mtr;
wire    [31:0]      wire_memwb_alu_out;
wire    [31:0]      wire_memwb_mem_out;
wire    [4:0]       wire_memwb_wr_reg;

wire            wire_exmem_ctrl_mr;
wire            wire_exmem_ctrl_mw;
wire    [1:0]       wire_exmem_wb;
wire    [4:0]       wire_exmem_wr_reg;
wire    [31:0]      wire_exmem_alu_out;
wire    [31:0]      wire_exmem_data2;

wire    [1:0]       wire_idex_wb;
wire    [1:0]       wire_idex_m;
wire            wire_idex_ctrl_alusrc;
wire    [1:0]       wire_idex_ctrl_aluop;
wire            wire_idex_ctrl_rd;
wire    [31:0]      wire_idex_data1;
wire    [31:0]      wire_idex_data2;
wire    [31:0]      wire_idex_signext;
wire    [4:0]       wire_idex_rsaddr;
wire    [4:0]       wire_idex_rtaddr;
wire    [4:0]       wire_idex_rdaddr;

wire    [1:0]       wire_fw_sel1;
wire    [1:0]       wire_fw_sel2;
wire    [31:0]      wire_fw_out1;
wire    [31:0]      wire_fw_out2;


wire                wire_pc_stall;
wire                wire_ifid_stall;
wire                wire_mux8_stall;
wire    [7:0]       wire_mux8_data_o;

wire                wire_flush;


assign JumpAddr = {MUX1Res[31:28], Shift_Left_26to28.data_o};
assign WB_RegWrite = WBWB[1];


Control Control(
    .Op_i       (instr_o[31:26]),
    .Jump_o(MUX2_sel),
    .Branch_o(AND.branch_i),
    .Control_o(MUX8_8.signal_i)
);

Adder Add_PC(
    .data1_in   (pc_o),
    .data2_in   (32'h4),
    .data_o     (pc_plus4)
);

PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .stall_i   (bubble_o),
    .pc_i       (pc_i),
    .pc_o       (pc_o)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (wire_pc),
    .instr_o    (wire_inst)
);

Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (instr_o[25:21]),
    .RTaddr_i   (instr_o[20:16]),
    .RDaddr_i   (regDst_o),
    .RDdata_i   (alu_o),
    .RegWrite_i (ctrl_RegWrite),
    .RSdata_o   (rsData_o),
    .RTdata_o   (rtData_o)
);

MUX5 MUX_RegDst(
    .data1_i    (instr_o[20:16]),
    .data2_i    (instr_o[15:11]),
    .select_i   (ctrl_RegDst),
    .data_o     (regDst_o)
);

MUX32 MUX_ALUSrc(
    .data1_i    (rtData_o),
    .data2_i    (imm32),
    .select_i   (ctrl_ALUSrc),
    .data_o     (aluSrc_o)
);

Sign_Extend Sign_Extend(
    .data_i     (instr_o[15:0]),
    .data_o     (imm32)
);

ALU ALU(
    .data1_i    (rsData_o),
    .data2_i    (aluSrc_o),
    .ALUCtrl_i  (aluCtrl_o),
    .data_o     (alu_o),
    .Zero_o     (zero)
);

ALU_Control ALU_Control(
    .funct_i    (instr_o[5:0]),
    .ALUOp_i    (ctrl_ALUOp),
    .ALUCtrl_o  (aluCtrl_o)
);

HazardDetection HazardDetection(
    .bubble_o           (bubble_o),
    .IF_ID_rs_i         (IF_ID_instr[25:21]),
    .IF_ID_rt_i         (IF_ID_instr[20:16]),
    .ID_EX_rt_i         (ID_EX_mux3_o1),
    .ID_EX_MemRead_i    (ID_EX_M[1])
);

FW FW
(
    .forward_MUX6   (),
    .forward_MUX7   (),
    .IDEX_rs        (ID_EX.FW_o1),
    .IDEX_rt        (ID_EX.FW_o2),
    .EXMEM_rd       (EX_MEM_in3),
    .EXMEM_write    (EX_MEM_wb[1]),
    .MEMWB_rd       (MEM_WB_in3),
    .MEMWB_write    (MEM_WB_RegWrite)
);

Equal Equal(
    .data1_i    (rsData_o),
    .data2_i    (rtData_o),
    .data_o     ()
);

IF_ID IF_ID
(
    .clk(clk_i),
    .hazard_i(bubble_o),
    .pc_i(Add_PC_o),
    .Instruction_Memory_i(instr_o),
    .flush_i(mux1.cond_o),
    .instr_o(IF_ID_instr),
    .addr_o(IF_ID_addr),
    .pc_o(Add_PC_o),
);

ID_EX ID_EX
(
    .clk(clk_i),
    .mux8_i(mux8_out),
    .addr_i(IF_ID_addr),
    .data1_i(rsData_o),
    .data2_i(rtData_o),
    .Sign_extend_i(imm32),
    .instr_i(IF_ID_instr),
    .EX_MEM_WB_o(),
    .EX_MEM_M_o(ID_EX_M),
    .ALUSrc_o(),
    .ALUOp_o(),
    .RegDst_o(),
    .mux6_o(),
    .mux7_o(),
    .mux4_o(ID_EX_mux4_out),
    .ALU_control_o(),
    .FW_o1(),
    .FW_o2(),
    .mux3_o1(ID_EX_mux3_o1),
    .mux3_o2()
);

EX_MEM EX_MEM
(
    .clk(clk_i),
    .wb(ID_EX.EX_MEM_WB_o),
    .m(ID_EX_M),
    .in1(alu_o),
    .in2(mux7_data_o),
    .in3(mux3.data_o),
    .wb_out(EX_MEM_wb),
    .mem_read(),
    .mem_write(),
    .in1_out(EX_MEM_in1),
    .in2_out(),
    .in3_out(EX_MEM_in3)
);

MEM_WB MEM_WB
(
    .clk(clk_i),
    .wb(EX_MEM_wb),
    .in1(Data_Memory.read_data_o),
    .in2(EX_MEM_in1),
    .in3(EX_MEM_in3),
    .reg_write(MEM_WB_RegWrite),
    .mem_to_reg(),
    .in1_out(),
    .in2_out(),
    .in3_out(MEM_WB_in3)
);
Shift_Left_32 Shift_Left_32(
    .data_i(signExtended),
    .data_o(Add_Branch.data1_in)  
);//DONE

Shift_Left_26 Shift_Left_26(
    .data_i(inst[25:0]),
    .data_o(sl26_o)  
);//DONE
endmodule

AND AND(
    .data1_i(wire_ctrl_br),
    .data2_i(wire_zero),
    .and_o(wire_isbr)
); 

OR OR(
    .data1_i(wire_ctrl_j),
    .data2_i(wire_isbr),
    .or_o(wire_flush)
);
