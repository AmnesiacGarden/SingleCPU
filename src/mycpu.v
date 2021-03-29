module mycpu(
input         clk,
input         rst_n,

output [31:0] inst_sram_addr,
input  [31:0] inst_sram_rdata,

output        data_sram_wen,
output [31:0] data_sram_addr,
output [31:0] data_sram_wdata,
input  [31:0] data_sram_rdata,

output [31:0] debug_wbdat,
output [4:0] debug_wbdst
);

wire [31:0] addr_value;
wire [31:0] reg1;
wire [31:0] reg2;
wire [31:0] ALUResult;
wire MemtoReg;       
wire Branch;
wire Jump;
wire ALUSrc;
wire RegDst;
wire RegWirte;
wire [2:0] ALUControl;
wire zero;

wire [5:0] opcode = inst_sram_rdata[31:26];
wire [5:0] fc = inst_sram_rdata[5:0];
wire [15:0] imm = inst_sram_rdata[15:0];
wire [4:0] rs = inst_sram_rdata[25:21];
wire [4:0] rt = inst_sram_rdata[20:16];
wire [4:0] rd = inst_sram_rdata[15:11];

wire [31:0] npc = addr_value + 32'd4 ;
wire [31:0] Jpc = {npc[31:28],inst_sram_rdata[25:0],2'b0};
wire [31:0] Branchsl =  {{14{imm[15]}},imm,2'b0};
wire [31:0] Brpc = Branchsl + npc ;

wire [4:0] regds = RegDst ? rt : rd ;

wire [31:0] eximm = {{16{imm[15]}},imm} ;

wire [31:0] reg2_b = ALUSrc ? eximm : reg2 ;

wire [31:0] wbdata = MemtoReg ? data_sram_rdata : ALUResult ;

assign inst_sram_addr = addr_value;

assign data_sram_addr = ALUResult;
assign data_sram_wdata = reg2;

assign debug_wbdat = wbdata;
assign debug_wbdst = regds;

Pc Pc( 
    .clk(clk), 
    .rst_n(rst_n), 
    .nxt_sel_j(Jump), 
    .nxt_sel_b(Branch && zero), 
    .ord_value(npc), 
    .br_value(Brpc), 
    .j_value(Jpc), 
    .addr_value(addr_value)
    );

ControlUnit ControlUnit( 
    .op(opcode), 
    .fc(fc), 
    .MemtoReg(MemtoReg), 
    .MemWrite(data_sram_wen), 
    .Branch(Branch), 
    .Jump(Jump), 
    .ALUSrc(ALUSrc), 
    .RegDst(RegDst), 
    .RegWirte(RegWirte), 
    .ALUControl(ALUControl)
    );

Register Register( 
    .clk(clk), 
    .wen(RegWirte), 
    .waddr(regds), 
    .wdata(wbdata), 
    .raddr_a(rs), 
    .raddr_b(rt), 
    .rdata_a(reg1), 
    .rdata_b(reg2)
    );

ALU ALU( 
    .aluop(ALUControl), 
    .vsrc1(reg1), 
    .vsrc2(reg2_b), 
    .result(ALUResult), 
    .zero(zero)
    );

endmodule