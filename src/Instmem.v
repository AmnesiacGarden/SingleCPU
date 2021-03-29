module Instmem(
input [31:0]    addr,

output reg [31:0]   data_o
);

reg [7:0] rom [0:71];

initial begin // 加载数据到存储器rom。注意：必须使用绝对路径，如：E:/Xlinx/VivadoProject/ROM/（自己定）
    $readmemh ("E:/Workshop/C00/ins.txt", rom); // 数据文件rom_data（.coe或.txt）。未指定，就从0地址开始存放。
    data_o = 32'd0;
end

always @(*) begin
    data_o[31:24] = rom[addr];
    data_o[23:16] = rom[addr+1];
    data_o[15:8] = rom[addr+2];
    data_o[7:0] = rom[addr+3];
end

endmodule










