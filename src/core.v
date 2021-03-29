module core(
input         clk,
input         rst_n,

output [31:0] inst_sram_addr,
output [31:0] inst_sram_rdata,
output [31:0] data_sram_addr,
output [31:0] data_sram_wdata,
output [31:0] data_sram_rdata,
output [31:0] debug_wbdat,
output [4:0]  debug_wbdst
);

wire data_sram_wen;

mycpu mycpu(
  .clk(clk),
  .rst_n(rst_n),
  .inst_sram_addr(inst_sram_addr),
  .inst_sram_rdata(inst_sram_rdata),
  .data_sram_wen(data_sram_wen),
  .data_sram_addr(data_sram_addr),
  .data_sram_wdata(data_sram_wdata),
  .data_sram_rdata(data_sram_rdata),
  .debug_wbdat(debug_wbdat),
  .debug_wbdst(debug_wbdst)
);

Instmem Instmem( 
    .addr(inst_sram_addr), 
    .data_o(inst_sram_rdata)
    );

Datamem Datamem( 
    .clk(clk), 
    .wen(data_sram_wen), 
    .addr(data_sram_addr), 
    .data_i(data_sram_wdata), 
    .data_o(data_sram_rdata)
    );

endmodule