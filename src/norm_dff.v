//带有load-enable使能，不带有reset的寄存器
module gnrl_dffl #(parameter width = 32) (
input  clk,
input  lden, 
input  [width-1:0] dnxt,
output [width-1:0] qout 
);

reg [width-1:0] qout_r;

always @(posedge clk) begin
  if (lden == 1'b1)
    qout_r <= dnxt;
end

assign qout = qout_r;    

endmodule

//带有load-enable使能，带有异步reset，复位默认值为0的寄存器
module gnrl_dfflr #(parameter width = 32) (
input  clk,
input  rst_n,
input  lden, 
input  [width-1:0] dnxt,
output [width-1:0] qout
);

reg [width-1:0] qout_r;

always @(posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0)
    qout_r <= {width{1'b0}};
  else if (lden == 1'b1)
    qout_r <= dnxt;
end

assign qout = qout_r;    

endmodule

//不带有load-enable使能，带有异步reset，复位默认值为0的寄存器
module gnrl_dffr # (parameter width = 32) (
input  clk,
input  rst_n,
input  [width-1:0] dnxt,
output [width-1:0] qout
);

reg [width-1:0] qout_r;

always @(posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0)
    qout_r <= {width{1'b0}};
  else                  
    qout_r <= dnxt;
end

assign qout = qout_r;

endmodule