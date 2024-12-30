module fsm10(
	input ck, rs,
	output reg [3:0] counter,
	output reg [1:0] state,
	output reg [2:0] light1, light2
);

parameter GREEN = 3'b001; // Đèn xanh 
parameter YELLOW= 3'b010; // Đèn vàng
parameter RED	 = 3'b100; // Đèn 

parameter GREEN_TIME	= 10; 
parameter YELLOW_TIME= 5; 
parameter RED_TIME	= 15;   

parameter S_GREEN1_RED2	= 2'b00; 
parameter S_YELLOW1_RED2= 2'b01; 
parameter S_RED1_GREEN2 = 2'b10; 
parameter S_RED1_YELLOW2= 2'b11; 

always @(posedge ck or negedge rs) begin
	if (!rs) begin
		state <= S_GREEN1_RED2;
		counter <= 4'b0000;
	end else begin
		counter <= counter + 1;

		case (state)
			S_GREEN1_RED2: begin
				if (counter == GREEN_TIME - 1) begin
					state <= S_YELLOW1_RED2;
					counter <= 4'b0000;
				end
			end
			S_YELLOW1_RED2: begin
				if (counter == YELLOW_TIME - 1) begin
					state <= S_RED1_GREEN2;
					counter <= 4'b0000;
				end
			end
			S_RED1_GREEN2: begin
				if (counter == GREEN_TIME - 1) begin
					state <= S_RED1_YELLOW2;
					counter <= 4'b0000;
				end
			end
			S_RED1_YELLOW2: begin
				if (counter == YELLOW_TIME - 1) begin
					state <= S_GREEN1_RED2;
					counter <= 4'b0000;
				end
			end
		endcase
	end
end

always @(posedge ck or negedge rs) begin
	if (!rs) begin
		light1 <= GREEN;
		light2 <= RED;
	end else begin
		case (state)
			S_GREEN1_RED2: begin
				light1 <= GREEN; 
				light2 <= RED;    
			end
			S_YELLOW1_RED2: begin
				light1 <= YELLOW;
				light2 <= RED;  
			end
			S_RED1_GREEN2: begin
				light1 <= RED;
				light2 <= GREEN;
			end
			S_RED1_YELLOW2: begin
				light1 <= RED; 
				light2 <= YELLOW;
			end
		endcase
	end
end
endmodule