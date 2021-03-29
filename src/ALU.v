module ALU(
input  wire [2:0] aluop,
input  wire [31:0] vsrc1,
input  wire [31:0] vsrc2,

output wire [31:0] result,
output            zero
);

wire [31:0] add_sub_result;
wire [31:0] slt_result;
wire [31:0] and_result;
wire [31:0] or_result;
wire [31:0] adder_a;
wire [31:0] adder_b;
wire        adder_cin;
wire [32:0] adder_result;
wire        adder_cout;

wire alu_add  = (aluop == 3'b000) ? 1'b1 : 1'b0;
wire alu_sub  = (aluop == 3'b001) ? 1'b1 : 1'b0;
wire alu_and  = (aluop == 3'b010) ? 1'b1 : 1'b0;
wire alu_or   = (aluop == 3'b011) ? 1'b1 : 1'b0;
wire alu_slt  = (aluop == 3'b100) ? 1'b1 : 1'b0;

assign and_result = vsrc1 & vsrc2;
assign or_result  = vsrc1 | vsrc2;

assign adder_a   = vsrc1;
assign adder_b   = vsrc2 ^ {32{alu_sub | alu_slt}};
assign adder_cin = alu_sub | alu_slt;
assign {adder_cout, adder_result} = {adder_a[31], adder_a} + {adder_b[31], adder_b} + {32'd0, adder_cin};

assign add_sub_result = adder_result[31:0];

assign slt_result[31:1] = 31'd0;
assign slt_result[0]    = (vsrc1[31] & ~vsrc2[31]) | (~(vsrc1[31] ^ vsrc2[31]) & adder_result[31]);

assign zero = (aluop == 3'b101) && (adder_result == 32'd0);

assign result = ({32{alu_add | alu_sub}} & add_sub_result) |
                ({32{alu_slt          }} & slt_result    ) |
                ({32{alu_and          }} & and_result    ) |
                ({32{alu_or           }} & or_result     );

endmodule
