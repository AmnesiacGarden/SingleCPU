`timescale 1ns/1ns

module mycpu_tb();
reg clk = 1'b0 ;
reg rst_n = 1'b0 ;
wire [31:0] inst_sram_addr;
wire [31:0] inst_sram_rdata;
wire [31:0] data_sram_addr;
wire [31:0] data_sram_wdata;
wire [31:0] data_sram_rdata;
wire [31:0] debug_wbdat;
wire [4:0]  debug_wbdst;

core core(
  .clk(clk),
  .rst_n(rst_n),
  .inst_sram_addr(inst_sram_addr),
  .inst_sram_rdata(inst_sram_rdata),
  .data_sram_addr(data_sram_addr),
  .data_sram_wdata(data_sram_wdata),
  .data_sram_rdata(data_sram_rdata),
  .debug_wbdat(debug_wbdat),
  .debug_wbdst(debug_wbdst)
);

initial
  forever #10 clk = ~clk;

initial begin
  wait(inst_sram_addr == 32'h0  & inst_sram_rdata == 32'h20020005 & debug_wbdat == 32'd5  & debug_wbdst == 5'd2 )     $display("Addr=%h,pass! 1",inst_sram_addr);
  wait(inst_sram_addr == 32'h4  & inst_sram_rdata == 32'h2003000c & debug_wbdat == 32'd12 & debug_wbdst == 5'd3 )     $display("Addr=%h,pass! 2",inst_sram_addr);
  wait(inst_sram_addr == 32'h8  & inst_sram_rdata == 32'h2067fff7 & debug_wbdat == 32'd3  & debug_wbdst == 5'd7 )     $display("Addr=%h,pass! 3",inst_sram_addr);
  wait(inst_sram_addr == 32'hc  & inst_sram_rdata == 32'h00e22025 & debug_wbdat == 32'd7  & debug_wbdst == 5'd4 )     $display("Addr=%h,pass! 4",inst_sram_addr);
  wait(inst_sram_addr == 32'h10 & inst_sram_rdata == 32'h00642824 & debug_wbdat == 32'd4  & debug_wbdst == 5'd5 )     $display("Addr=%h,pass! 5",inst_sram_addr);
  wait(inst_sram_addr == 32'h14 & inst_sram_rdata == 32'h00a42820 & debug_wbdat == 32'd11 & debug_wbdst == 5'd5 )     $display("Addr=%h,pass! 6",inst_sram_addr);
  wait(inst_sram_addr == 32'h18 & inst_sram_rdata == 32'h10a7000a                                               )     $display("Addr=%h,pass! 7",inst_sram_addr);
  wait(inst_sram_addr == 32'h1c & inst_sram_rdata == 32'h0064202a & debug_wbdat == 32'd0  & debug_wbdst == 5'd4 )     $display("Addr=%h,pass! 8",inst_sram_addr);
  wait(inst_sram_addr == 32'h20 & inst_sram_rdata == 32'h10800001                                               )     $display("Addr=%h,pass! 9",inst_sram_addr);
//wait(inst_sram_addr == 32'h24 & inst_sram_rdata == 32'h20050000 & debug_wbdat == 32'd5  & debug_wbdst == 5'd5 )     $display("Addr=%h,pass!",inst_sram_addr);
  wait(inst_sram_addr == 32'h28 & inst_sram_rdata == 32'h00e2202a & debug_wbdat == 32'd1  & debug_wbdst == 5'd4 )     $display("Addr=%h,pass! 10",inst_sram_addr);
  wait(inst_sram_addr == 32'h2c & inst_sram_rdata == 32'h00853820 & debug_wbdat == 32'd12 & debug_wbdst == 5'd7 )     $display("Addr=%h,pass! 11",inst_sram_addr);
  wait(inst_sram_addr == 32'h30 & inst_sram_rdata == 32'h00e23822 & debug_wbdat == 32'd7  & debug_wbdst == 5'd7 )     $display("Addr=%h,pass! 12",inst_sram_addr);
  wait(inst_sram_addr == 32'h34 & inst_sram_rdata == 32'hac670044 & data_sram_wdata == 32'd7 & data_sram_addr == 32'd80 )  $display("Addr=%h,pass! 13",inst_sram_addr);
  wait(inst_sram_addr == 32'h38 & inst_sram_rdata == 32'h8c020050 & debug_wbdat == 32'd7  & debug_wbdst == 5'd2 )     $display("Addr=%h,pass! 14",inst_sram_addr);
  wait(inst_sram_addr == 32'h3c & inst_sram_rdata == 32'h08000011                                              )      $display("Addr=%h,pass! 15",inst_sram_addr);
//wait(inst_sram_addr == 32'h40 & inst_sram_rdata == 32'h20020001 & debug_wbdat == 32'd5  & debug_wbdst == 5'd2 )     $display("Addr=%h,pass!",inst_sram_addr);
  wait(inst_sram_addr == 32'h44 & inst_sram_rdata == 32'hac020054 & data_sram_wdata == 32'd7 & data_sram_addr == 32'd84 )  $display("Addr=%h,pass! Over",inst_sram_addr);
end

initial begin
  #20 rst_n= 1'b1;
  #350 $stop;
end

endmodule