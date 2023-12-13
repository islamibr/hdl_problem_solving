module full_adder (
	input x, y, c_in,
	output sum, c_out
);

	assign sum = x ^ y ^ c_in;
	assign c_out = ((x ^ y) & c_in) | (x & y);

endmodule


module adder_subtractor (
	input [7:0] x,y,
	input add_in,
	output [7:0] sum,
	output c_out
);

	wire [7:0] xored_y;
	wire [8:0] c;
	assign c[0] = add_in;
	assign c_out = c[8];

	generate 
		genvar k;
		for (k = 0; k < 8; k = k + 1)
		begin: state
		assign xored_y[k] = y[k] ^ add_in;
		end
	endgenerate

	generate
		genvar i;

		for (i = 0; i < 8; i = i + 1)
			begin: bit
			full_adder FA (
				.x(x[i]),
				.y(xored_y[i]),
				.c_in(c[i]),
				.sum(sum[i]),
				.c_out(c[i+1])
			);
			end
	endgenerate

endmodule


module alu (
    input [7:0] A,
    input [7:0] B,
    input [2:0] opCode,
    output [7:0] Out,
    output Carry_out,
    output C_flag
);

wire [7:0] sum;
wire [8:0] c;

adder_subtractor AS (
    .x(A),
    .y(B),
    .add_in(opCode[0]),
    .sum(sum),
    .c_out(c[8])
);
  

assign C_flag = (A > B);

assign Carry_out = c[8];

assign Out = (opCode == 3'b000) ? sum :
 	     (opCode == 3'b001) ? sum :
             (opCode == 3'b010) ? (A & B) :
             (opCode == 3'b011) ? (A | B) :
             (opCode == 3'b100) ? (A ^ B) :
             (opCode == 3'b101) ? (A > B) :
             (opCode == 3'b110) ? (A << 1) :
             (opCode == 3'b111) ? (B << 1) :
             8'b0;

endmodule
