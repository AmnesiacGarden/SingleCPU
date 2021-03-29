module ControlUnit(
input [5:0]op,
input [5:0]fc,

output MemtoReg,        
output MemWrite,
output Branch,
output Jump,
output ALUSrc,
output RegDst,
output RegWirte,	
output [2:0]ALUControl
);

wire opcode_000000 = (op == 6'b000000);

wire add_req  = opcode_000000 & (fc == 6'b100000);
wire sub_req  = opcode_000000 & (fc == 6'b100010);
wire slt_req  = opcode_000000 & (fc == 6'b101010);
wire and_req  = opcode_000000 & (fc == 6'b100100);
wire or_req   = opcode_000000 & (fc == 6'b100101);
wire addi_req =                 (op == 6'b001000);
wire sw_req   =                 (op == 6'b101011);
wire lw_req   =                 (op == 6'b100011);
wire beq_req  =                 (op == 6'b000100);
wire j_req    =                 (op == 6'b000010);

assign MemtoReg = lw_req ? 1'b1 : 1'b0;

assign MemWrite = sw_req ? 1'b1 : 1'b0;

assign Branch = beq_req ? 1'b1 : 1'b0;

assign Jump = j_req ? 1'b1 : 1'b0;

assign ALUSrc = addi_req | sw_req | lw_req;

assign RegDst = addi_req | sw_req | lw_req;

assign RegWirte = add_req | sub_req | slt_req | and_req | or_req | addi_req | lw_req;

assign ALUControl = ({3{add_req}}  & 3'b000) |
                    ({3{sub_req}}  & 3'b001) |
                    ({3{slt_req}}  & 3'b100) |
                    ({3{and_req}}  & 3'b010) |
                    ({3{or_req}}   & 3'b011) |
                    ({3{addi_req}} & 3'b000) |
                    ({3{sw_req}}   & 3'b000) |
                    ({3{lw_req}}   & 3'b000) |
                    ({3{beq_req}}  & 3'b101) |
                    ({3{j_req}}    & 3'b000);

endmodule
