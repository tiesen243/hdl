+	input  [8:0] SW, // G = SW[8], a = SW[7:4], b = SW[3:0]
	output [3:0] LEDR
);

	wire [2:0] O1, O2, O3, O4;

	c1b C1(SW[8], SW[7], SW[3], O1);
	c1b C2(O1[0], SW[6], SW[2], O2);
	c1b C3(O2[0], SW[5], SW[1], O3);
	c1b C4(O3[0], SW[4], SW[0], O4);
	
	or X1(LEDR[1], O1[2], O2[2], O3[2], O4[2]); //a>b
	or X2(LEDR[2], O4[0]); // a = b
	or X3(LEDR[3], O1[1], O2[1], O3[1], O4[1]); // a < b
endmodule

module c1b(
	input  G, a, b,
	output [2:0] O // S, I, E
);
	assign O[2] = G & (a & ~b);
	assign O[1] = G & (~a & b);
	assign O[0] = G & (a ~^ b);
endmodule