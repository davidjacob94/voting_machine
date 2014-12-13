module voting_machine(clk, reset, vote_r, vote_b, confirmY, confirmN, hex_count0, hex_count1, hex_count2, hex_count3,enable_vga,VGA_R,VGA_G,VGA_B,VGA_HS,VGA_VS,VGA_CLK,VGA_SYNC,VGA_BLANK);




input clk, //50 MHz clock on board
      reset, //Switch 17
       vote_r, vote_b, // debounced keys
       confirmY, confirmN, //confirmN; //confirmN,  //debounced
		 enable_vga; // Switch
		 
output [6:0] hex_count0,  hex_count1,  hex_count2, hex_count3;
output [7:0] VGA_R, VGA_G, VGA_B;
output VGA_BLANK, VGA_SYNC, VGA_CLK, VGA_HS, VGA_VS;

reg [15:0] count_r, count_b, count_t; // 16 bit counters;
 
 
//state variable
reg [3:0] state;
reg [2:0] mode; // display control signal
reg [15:0] r_buffer, b_buffer;

reg [15:0] count;
wire [6:0] hex_count0,  hex_count1,  hex_count2, hex_count3; // hex_digits;


vga_out(clk, mode[1],VGA_R, VGA_G, VGA_B,VGA_HS, VGA_VS,VGA_CLK,VGA_SYNC, VGA_BLANK, count_r,count_b); 
sevseg(count_t, mode, hex_count0, hex_count1, hex_count2,hex_count3); // seven segment encoder, controlled by 'mode'

 
parameter WAITING = 4'b0000, RED_VOTE_BUTTON_PRESSED = 4'b0001, RED_VOTE_RECORDED = 4'b0010, confirm_WAITING = 4'b0011, confirmYES_PRESSED = 4'b0100, confirmYES_RECORDED = 4'b0101, display_count = 4'b0111, BLUE_VOTE_BUTTON_PRESSED = 4'b1000, BLUE_VOTE_RECORDED = 4'b1001, confirmNO_PRESSED = 4'b1010, confirmNO_RECORDED = 4'b1011, DISPLAY_MODE = 4'b1111;


always @ (posedge clk or negedge reset)
begin
	if (!reset)
		begin

		state <= WAITING;
		count_r <= 16'd0;
		count_b <= 16'd0;
		count_t <= 16'd0;
		
		r_buffer <= 0;
		b_buffer <= 0;
		end
	
	else begin
	
		case (state)
			WAITING: begin
				count_r <= count_r;
				count_b <= count_b;
				count_t <= count_t; 
				r_buffer <= 0;
				b_buffer <= 0;			
			
				if (vote_b == 1'b0) state <=BLUE_VOTE_BUTTON_PRESSED;
				else if (vote_r == 1'b0) state <=RED_VOTE_BUTTON_PRESSED;
				else if (enable_vga == 1'b1) state <= DISPLAY_MODE;
				else state <= WAITING;	
				end
			BLUE_VOTE_BUTTON_PRESSED: begin
				count_r <= count_r;
				count_b <= count_b;
				count_t <= count_t;
				r_buffer <= 0;
				b_buffer <= 0;			
			
				if (vote_b  == 1'b0)	state <=BLUE_VOTE_BUTTON_PRESSED;
				else state <= BLUE_VOTE_RECORDED;
				end
			BLUE_VOTE_RECORDED: begin
				count_r <= count_r;
				count_b <= count_b;
				count_t <= count_t; 
				r_buffer <= 0;
				b_buffer <= 1;			
				state <= confirm_WAITING;
				end
			RED_VOTE_BUTTON_PRESSED: begin
				count_r <= count_r;
				count_b <= count_b;
				count_t <= count_t; 
				r_buffer <= 0;
				b_buffer <= 0;			
							
				if (vote_r == 1'b0) state <= RED_VOTE_BUTTON_PRESSED;
				else state <= RED_VOTE_RECORDED;
			   end
			RED_VOTE_RECORDED: begin
				count_r <= count_r;
				count_b <= count_b;
				count_t <= count_t;
				r_buffer <= 1;
				b_buffer <= 0;			
				
				state <= confirm_WAITING;
				end
			confirm_WAITING: begin
				count_r <= count_r;
				count_b <= count_b;
				count_t <= count_t; 
				r_buffer <= r_buffer;
				b_buffer <= b_buffer;
				
				if (confirmY == 1'b0) state <=confirmYES_PRESSED;
				else if (confirmN == 1'b0) state <=confirmNO_PRESSED;
				else state <=confirm_WAITING;
				end
			confirmYES_PRESSED: begin
				count_r <= count_r;
				count_b <= count_b;
				count_t <= count_t; 
				r_buffer <= r_buffer;
				b_buffer <= b_buffer;
				
				if (confirmY == 1'b0) state <= confirmYES_PRESSED;
				else state<= confirmYES_RECORDED;	
				end
				
			confirmYES_RECORDED: begin
				count_r <= count_r + r_buffer;
				count_b <= count_b + b_buffer;
				count_t <= count_t + 1; 			
			
				r_buffer <= r_buffer;
				b_buffer <= b_buffer;
					
				state <= WAITING;
				end
			confirmNO_PRESSED: begin
				count_r <= count_r;
				count_b <= count_b;
				count_t <= count_t; 
				r_buffer <= r_buffer;
				b_buffer <= b_buffer;
				
				if (confirmN == 1'b0) state <= confirmNO_PRESSED;
				else state<= confirmNO_RECORDED;
				end
			confirmNO_RECORDED: begin
				count_r <= count_r;
				count_b <= count_b;
				count_t <= count_t; 
				r_buffer <= r_buffer;
				b_buffer <= b_buffer;
		
				state <= WAITING;
				end
			DISPLAY_MODE: begin
				count_r <= count_r;
				count_b <= count_b;
				count_t <= count_t; 
				r_buffer <= 0;
				b_buffer <= 0;			
				
				if (enable_vga == 0) state <= WAITING;
				else state <= DISPLAY_MODE;
			end
		endcase

	end

end
// Assigns Hex display mode
always @ (*)
begin
	case(state)
		WAITING: mode = 3'b000;
		RED_VOTE_BUTTON_PRESSED: mode = 3'b000;
		RED_VOTE_RECORDED: mode = 3'b000;
		BLUE_VOTE_BUTTON_PRESSED: mode = 3'b000;
		BLUE_VOTE_RECORDED: mode = 3'b000;
		confirm_WAITING: mode = 3'b101;
		confirmYES_PRESSED: mode = 3'b101;
		confirmYES_RECORDED: mode = 3'b101;
		DISPLAY_MODE: mode = 3'b111;
	endcase	
end
		
endmodule