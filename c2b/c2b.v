module c2b(
	input  [4:0] SW, // G = SW[4], a = SW[3:2], b = SW[1:0]
	output [3:0] LEDR // a < b, a = b, a > b
);

	wire [2:0] O1, O2;

	c1b C1(SW[4], SW[3], SW[1], O1);
	c1b C2(O1[0], SW[2], SW[0], O2);
	
	or X1(LEDR[1], O1[2], O2[2]);
	or X2(LEDR[2], O2[0]);
	or X3(LEDR[3], O1[1], O2[1]);
endmodule

module c1b(
	input  G, a, b,
	output [2:0] O // S, I, E
);

	wire notA, notB;
	
	not N1(notA, a);
	not N2(notB, b);
	
	wire I3, I2, I1, I0;
	
	and T1(I2,    a, notB);
	and T2(I1, notA,    b);
	
	or  T3(I3, I1, I2);
	not T4(I0, I3);
	
	and O1(O[2], G, I2);
	and O2(O[1], G, I1);
	and O3(O[0], G, I0);
endmodule