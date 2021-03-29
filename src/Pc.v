module Pc(
input         clk,
input         rst_n,
input         nxt_sel_j,
input         nxt_sel_b,
input [31:0]  ord_value,
input [31:0]  br_value,
input [31:0]  j_value,

output [31:0] addr_value
);

wire [31:0] nxt_addr;

assign nxt_addr = nxt_sel_b ? br_value :
                  nxt_sel_j ? j_value : ord_value;

gnrl_dffr #(32) cnt_valid_dff (clk, rst_n, nxt_addr, addr_value);
    
endmodule
