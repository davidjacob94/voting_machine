module sevseg(in, mode, ones, tens, hundreds, thousands);
	input [2:0] mode;
	input[16:0] in;
	
	output [6:0] ones;
	output[6:0] tens;
	output[6:0] hundreds;
	output [6:0] thousands;
	
	wire [2:0] mode; //010 - numbers, 101 - "STRING"
	reg [6:0] ones;
	reg [6:0] tens;
	reg[6:0] hundreds;
	reg [6:0] thousands;
	
	
always @(*)
begin		
	if (mode == 3'b111) begin
		case({in[3], in[2], in[1], in[0]})
			4'h0: ones = 7'b1000000;
			4'h1: ones = 7'b1111001;
			4'h2: ones = 7'b0100100;
			4'h3: ones = 7'b0110000;
			4'h4: ones = 7'b0011001;
			4'h5: ones = 7'b0010010;
			4'h6: ones = 7'b0000010;
			4'h7: ones = 7'b1111000;
			4'h8: ones = 7'b0000000;
			4'h9: ones = 7'b0010000;
			4'ha: ones = 7'b0001000;
			4'hb: ones = 7'b0000011;
			4'hc: ones = 7'b1000110;
			4'hd: ones = 7'b0100001;
			4'he: ones = 7'b0000110;
			4'hf: ones = 7'b0001110;
			default: ones = 7'b1111111;
		endcase
		case({in[7], in[6], in[5], in[4]})
			4'h0: tens = 7'b1000000;
			4'h1: tens = 7'b1111001;
			4'h2: tens = 7'b0100100;
			4'h3: tens = 7'b0110000;
			4'h4: tens = 7'b0011001;
			4'h5: tens = 7'b0010010;
			4'h6: tens = 7'b0000010;
			4'h7: tens = 7'b1111000;
			4'h8: tens = 7'b0000000;
			4'h9: tens = 7'b0010000;
			4'ha: tens = 7'b0001000;
			4'hb: tens = 7'b0000011;
			4'hc: tens = 7'b1000110;
			4'hd: tens = 7'b0100001;
			4'he: tens = 7'b0000110;
			4'hf: tens = 7'b0001110;
			default: tens = 7'b1111111;
	endcase
		case({in[11], in[10], in[9], in[8]})
			4'h0: hundreds = 7'b1000000;
			4'h1: hundreds = 7'b1111001;
			4'h2: hundreds = 7'b0100100;
			4'h3: hundreds = 7'b0110000;
			4'h4: hundreds = 7'b0011001;
			4'h5: hundreds = 7'b0010010;
			4'h6: hundreds = 7'b0000010;
			4'h7: hundreds = 7'b1111000;
			4'h8: hundreds = 7'b0000000;
			4'h9: hundreds = 7'b0010000;
			4'ha: hundreds = 7'b0001000;
			4'hb: hundreds = 7'b0000011;
			4'hc: hundreds = 7'b1000110;
			4'hd: hundreds = 7'b0100001;
			4'he: hundreds = 7'b0000110;
			4'hf: hundreds = 7'b0001110;
			default: hundreds = 7'b1111111;
		endcase
		case({in[15], in[14], in[13], in[12]})
			4'h0: thousands = 7'b1000000;
			4'h1: thousands = 7'b1111001;
			4'h2: thousands = 7'b0100100;
			4'h3: thousands = 7'b0110000;
			4'h4: thousands = 7'b0011001;
			4'h5: thousands = 7'b0010010;
			4'h6: thousands = 7'b0000010;
			4'h7: thousands = 7'b1111000;
			4'h8: thousands = 7'b0000000;
			4'h9: thousands = 7'b0010000;
			4'ha: thousands = 7'b0001000;
			4'hb: thousands = 7'b0000011;
			4'hc: thousands = 7'b1000110;
			4'hd: thousands = 7'b0100001;
			4'he: thousands = 7'b0000110;
			4'hf: thousands= 7'b0001110;
			default: thousands = 7'b1111111;
		endcase
		end
		else if (mode == 3'b101) begin
			thousands = 7'b1000110;
			hundreds = 7'b1000000;
			tens = 7'b0101011;
			ones = 7'b0001110;
		end	
		else begin
			ones = 7'b1111111;
			tens = 7'b1111111;
			hundreds = 7'b1111111;
			thousands = 7'b1111111;
		end
end
endmodule
