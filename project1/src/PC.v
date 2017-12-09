module PC
(
    clk_i,
    // rst_i,
    start_i,
    stall_i,
    pc_i,
    pc_o
);

// Ports
input               clk_i;
// input               rst_i;
input               start_i;
input               stall_i; // 1: stall, 0:continue
input   [31:0]      pc_i;
output  [31:0]      pc_o;

// Wires & Registers
reg     [31:0]      pc_o;

always @(posedge clk_i) begin
    if(start_i==0) begin
        pc_o <= 32'b0;
    end
    else begin
        if(start_i && ~stall_i)
            pc_o <= pc_i;
        else
            pc_o <= pc_o;
    end
end

endmodule
