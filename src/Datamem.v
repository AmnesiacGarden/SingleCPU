module Datamem(
input 		   clk,
input 		   wen,
input [31:0]   addr,
input [31:0]   data_i,

output [31:0]  data_o
);

reg [31:0] memory [0:127];

always @ (posedge clk) begin
	if(wen) begin
	      memory[addr[18:2]] <= data_i;
	end
end

assign data_o = memory[addr[18:2]] ; 	

endmodule