module Register (
input         clk,
input         wen,
input [4:0]   waddr,
input [31:0]  wdata,
input [4:0]   raddr_a,
input [4:0]   raddr_b,

output [31:0] rdata_a,
output [31:0] rdata_b
);

// reg [31:0] regs [31:0];

// integer i;

// initial begin
//     for(i = 0; i < 32; i = i + 1)
//             regs[i] <= 32'd0;
// end

// assign rdata_a = (raddr_a != 5'b0) ? regs[raddr_a] : 32'd0; 
// assign rdata_b = (raddr_b != 5'b0) ? regs[raddr_b] : 32'd0; 

// always @(posedge clk) begin
//     if(wen) begin
//             regs[waddr] <= wdata;
//     end
// end

wire [31:0] rf_reg [31:0];
wire [31:0] rf_wen;

assign rdata_a = rf_reg[raddr_a];
assign rdata_b = rf_reg[raddr_b];

genvar i;
generate
  for (i=0; i<32; i=i+1) begin:regfile
      if(i==0) begin: rf0
          assign rf_wen[i] = 1'b0;
          assign rf_reg[i] = 32'b0;
      end
      else begin: rfno0
          assign rf_wen[i] = wen & (waddr == i) ;
          gnrl_dffl #(32) rf_dffl (clk, rf_wen[i], wdata, rf_reg[i]);
      end
  end
endgenerate

endmodule