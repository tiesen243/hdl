module mux(
	input a,b,s,
	output y
	);
	
	assign y = s ? b : a;
endmodule