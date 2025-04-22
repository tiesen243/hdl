module lcd_3(
	input CLOCK_50, 
	output LCD_ON, LCD_BLON, LCD_EN, LCD_RS, LCD_RW,
	output [1:0] LEDR,
	inout [7:0] LCD_DATA
);
	reg [8:0] data;
	reg on, blon, en, rw, flag, mode, r_l;
	reg [5:0] state;
	reg [2:0] index;
	reg [19:0] count_lcd, countend;
	reg [3:0] times;
	assign LCD_ON = on;
	assign LCD_BLON = blon;
	assign LCD_EN = en;
	assign LCD_RS = data[8];
	assign LCD_RW = rw;
	assign LCD_DATA = (!rw) ? data[7:0] : 8'hzz;
	
	initial begin
		on <= 1'b1;
		blon <= 1'b0;
		en <= 1'b0;
		rw <= 1'b0;
		data <= 9'b0;
		
		state <= 6'b0;
		flag <= 1;
		index <= 0;
		countend <= 20'hFFFFF;
	end

	always @ (posedge CLOCK_50) begin
		if (flag) begin
			if (count_lcd < countend) count_lcd <= count_lcd + 20'b1;
			else count_lcd <= 20'b0;
		end
	end
	
	always @ (posedge CLOCK_50) begin
		if (state >= 6'h29) begin
			if (prev_state_2 != state_2) state <= 0;
		end else case (index)
			3'h0: begin
				if (count_lcd == countend) begin
					flag <= 0;
					if (state < 6'h29) state <= state + 1;
					index <= index + 1;
				end
			end
			3'h1: index <= index + 1;
			3'h2: begin
				en <= 1;
				flag <= 1;
				countend <= 8'h10;
				index <= index + 1;
			end
			3'h3: begin
				if (count_lcd == countend) begin
					en <= 0;
					flag <= 1;
					countend <= 20'h40000;
					index <= 0;
				end
			end
			default: index <= 0;
		endcase
	end
	
	always @ (posedge CLOCK_50) begin
		case (state) 
			/* Init LCD */
			6'h00: data <= 9'h030; 
			6'h01: data <= 9'h030;
			6'h02: data <= 9'h030;
			6'h03: data <= 9'h038;
			6'h04: data <= 9'h00C;
			6'h05: data <= 9'h001;
			6'h06: data <= 9'h006;
			6'h07: data <= 9'h080;
			/* Data */
			6'h08: data <= 9'h083; // Dich con tro den vi tri 03
			6'h09: data <= state_2 ? 9'h154 : 9'h132; // T 2
			6'h0A: data <= state_2 ? 9'h152 : 9'h132; // R 2
			6'h0B: data <= state_2 ? 9'h141 : 9'h120; // A 
			6'h0C: data <= state_2 ? 9'h14E : 9'h130; // N 0
			6'h0D: data <= state_2 ? 9'h120 : 9'h136; //   6
			6'h0E: data <= 9'h120;
			6'h0F: data <= state_2 ? 9'h154 : 9'h132; // T 2
			6'h10: data <= state_2 ? 9'h149 : 9'h130; // I 0
			6'h11: data <= state_2 ? 9'h145 : 9'h130; // E 0
			6'h12: data <= state_2 ? 9'h14E : 9'h134; // N 4
			6'h13: data <= 9'h0C4; // Dich con tro den vi tri 44
			6'h14: data <= state_2 ? 9'h132 : 9'h148; // 2 H
			6'h15: data <= state_2 ? 9'h132 : 9'h14F; // 2 O
			6'h16: data <= state_2 ? 9'h136 : 9'h143; // 6 C
			6'h17: data <= state_2 ? 9'h135 : 9'h148; // 5 H
			6'h18: data <= state_2 ? 9'h133 : 9'h149; // 3 I
			6'h19: data <= state_2 ? 9'h139 : 9'h14D; // 9 M
			6'h1A: data <= state_2 ? 9'h139 : 9'h149; // 9 I
			6'h1B: data <= state_2 ? 9'h131 : 9'h14E; // 1 N
			6'h1C: data <= state_2 ? 9'h120 : 9'h148; //   H
			default: data <= 9'h120;
		endcase
	end
	
	reg ck2s, state_2, prev_state_2;
	integer q;
	always @ (posedge CLOCK_50) begin
		q = q + 1;
		
		if (q == 100000000) begin
			ck2s = ~ck2s;
			q = 0;
		end
	end
	
	always @ (posedge ck2s) begin
		prev_state_2 <= state_2;
		case (state_2)
			0: state_2 <= 1;
			1: state_2 <= 0;
		endcase
	end
	
	assign LEDR = { prev_state_2, state_2 };
endmodule
