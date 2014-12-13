module vga_out(clk, rst,VGA_R, VGA_G, VGA_B,VGA_HS, VGA_VS,VGA_CLK,VGA_SYNC, VGA_BLANK,in1,in2);

input clk,rst;
input [15:0] in1;
input [15:0] in2;
reg [15:0] height1;
reg [15:0] height2;

output [7:0] VGA_R, VGA_G, VGA_B;
output VGA_BLANK, VGA_SYNC, VGA_CLK, VGA_HS, VGA_VS;
reg [31:0] pc, lc;

reg [7:0] VGA_R, VGA_G, VGA_B;
reg  VGA_HS, VGA_VS, h_blank, v_blank;


wire VGA_BLANK, VGA_SYNC;
// influences green only, may not be needed
assign VGA_SYNC = 0;

assign VGA_BLANK = h_blank || v_blank;
assign VGA_CLK = clk;

//output [7:0]r,g,b;
reg [7:0]r,g,b;

//assign in1=256;


always @(posedge clk or negedge rst)
if (rst==1'b0)begin
	height1=40;
	height2=40;
	end
else begin
	if (in1>in2)begin
		height1<=40;
		height2<=600-560*in2/in1;
		end
	if (in2>in1) begin	
		height2<=40;
		height1<=600-560*in1/in2;
		end
	if(in1==in2) begin 
		height2<=40;
		height1<=40;
		end 
	if (in1==0 &&in2==0)begin
		height1<=600;
		height2<=600;
	end
	end

// left 250-----1040
// top 40---624
parameter
		sqpclx=250,sqpcrx=1040,sqlctx=600, sqlcbx=610;
parameter
		sqpcly=250,sqpcry=260,sqlcty=40, sqlcby=610;
parameter
		sqpcl1=400,sqpcr1=500, sqlcb1=600;
parameter
		sqpcl2=800,sqpcr2=900, sqlcb2=600;
parameter
		sqpclg1=250,sqpcrg1=1040,sqlctg1=544, sqlcbg1=545;
parameter
		sqpclg2=250,sqpcrg2=1040,sqlctg2=488, sqlcbg2=489;
parameter
		sqpclg3=250,sqpcrg3=1040,sqlctg3=432, sqlcbg3=433;
parameter
		sqpclg4=250,sqpcrg4=1040,sqlctg4=376, sqlcbg4=377;
parameter
		sqpclg5=250,sqpcrg5=1040,sqlctg5=320, sqlcbg5=321;
parameter
		sqpclg6=250,sqpcrg6=1040,sqlctg6=264, sqlcbg6=265;
parameter
		sqpclg7=250,sqpcrg7=1040,sqlctg7=208, sqlcbg7=209;
parameter
		sqpclg8=250,sqpcrg8=1040,sqlctg8=152, sqlcbg8=153;
parameter
		sqpclg9=250,sqpcrg9=1040,sqlctg9=96, sqlcbg9=97;


		
		
always@(posedge clk or negedge rst)
begin
	if (rst==1'b0)
		begin
		r<=8'hff;
		g<=8'hff;
		b<=8'hff;
		end
		else
		begin 
			if((pc>=sqpclx && pc<=sqpcrx)&&(lc>=sqlctx && lc <=sqlcbx))//x 
			begin
				r<=8'h0;
				g<=8'hff;
				b<=8'h0;
			end
			else if ((pc>=sqpcly && pc<=sqpcry)&&(lc>=sqlcty && lc <=sqlcby))//y
			begin
				r<=8'h0;
				g<=8'hff;
				b<=8'h0;
			end
			else if ((pc>=sqpcl1 && pc<=sqpcr1)&&(lc>=height1 && lc <=sqlcb1))//1
			begin
				r<=8'hff;
				g<=8'h0;
				b<=8'h0;
			end
			else if ((pc>=sqpcl2 && pc<=sqpcr2)&&(lc>=height2 && lc <=sqlcb2))//2
			begin
				r<=8'h0;
				g<=8'h0;
				b<=8'hff;
			end
			else if ((pc>=sqpclg1 && pc<=sqpcrg1)&&(lc>=sqlctg1 && lc <=sqlcbg1))
			begin
				r<=8'h0;
				g<=8'h0;
				b<=8'h0;
			end
			else if ((pc>=sqpclg2 && pc<=sqpcrg2)&&(lc>=sqlctg2 && lc <=sqlcbg2))
			begin
				r<=8'h0;
				g<=8'h0;
				b<=8'h0;
			end
			else if ((pc>=sqpclg3 && pc<=sqpcrg3)&&(lc>=sqlctg3 && lc <=sqlcbg3))
			begin
				r<=8'h0;
				g<=8'h0;
				b<=8'h0;
			end
			else if ((pc>=sqpclg4 && pc<=sqpcrg4)&&(lc>=sqlctg4 && lc <=sqlcbg4))
			begin
				r<=8'h0;
				g<=8'h0;
				b<=8'h0;
			end
			else if ((pc>=sqpclg5 && pc<=sqpcrg5)&&(lc>=sqlctg5 && lc <=sqlcbg5))
			begin
				r<=8'h0;
				g<=8'h0;
				b<=8'h0;
			end
			else if ((pc>=sqpclg6 && pc<=sqpcrg6)&&(lc>=sqlctg6 && lc <=sqlcbg6))
			begin
				r<=8'h0;
				g<=8'h0;
				b<=8'h0;
			end
			else if ((pc>=sqpclg7 && pc<=sqpcrg7)&&(lc>=sqlctg7 && lc <=sqlcbg7))
			begin
				r<=8'h0;
				g<=8'h0;
				b<=8'h0;
			end
			else if ((pc>=sqpclg8 && pc<=sqpcrg8)&&(lc>=sqlctg8 && lc <=sqlcbg8))
			begin
				r<=8'h0;
				g<=8'h0;
				b<=8'h0;
			end
			else if ((pc>=sqpclg9 && pc<=sqpcrg9)&&(lc>=sqlctg9 && lc <=sqlcbg9))
			begin
				r<=8'h0;
				g<=8'h0;
				b<=8'h0;
			end
			else
			begin 
				r<=8'hff;
				g<=8'hff;
				b<=8'hff;
			end
		end
		
end


parameter hpixeltotal = 1056;
parameter hpixelwith =     800;
parameter hsynctime = 80;
parameter hfpte = 240;
parameter hbpts = 1040;

parameter vpixeltotal = 625;
parameter vpixelwith =  600;
parameter vsynctime = 3;
parameter vfpte = 24;
parameter vbpts =  624;

// pixel counter and line counter
always@(posedge clk or negedge rst)
begin
	if (rst==1'b0)
		begin
		pc<=32'd0;
		lc<=32'd0;
		end
		else
		if (pc>hpixeltotal)
			begin
				pc<=32'd0;
				if (lc>vpixeltotal)
					lc<=32'd0;
				else
					lc<= lc+1;
			end
		else
			pc<= pc+1;


end

//horizontal outputs
always@(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
		begin 
		VGA_HS<=1'b0;
		h_blank<=1'b1;
	
		end
	else
	
	begin
	
	
	//HSYNC
	if (pc<hsynctime)
		VGA_HS<=1'b0;
	else
		VGA_HS<=1'b1;
	
	//Back porch and Front porch
	if ((pc>=hsynctime && pc<hfpte)|| (pc>=hbpts))
		h_blank<=1'b0;
	else
		h_blank<=1'b1;
	
	// horizontal visible area
	if (pc>=hfpte && pc<hbpts)
		begin
		//read frame buffer
		VGA_R<=r;
		VGA_G<=g;
		VGA_B<=b;
		end
	else
		begin
		//dont read frame buffer
		//included to remove infered latch
		VGA_R<=8'h00;
		VGA_G<=8'h00;
		VGA_B<=8'h00;
		end
	end// end else rst
end//always



// vertical outputs
always@(posedge clk or negedge rst)
begin 
	if (rst ==1'b0)
		begin
		VGA_VS<=1'b0;
		v_blank <= 1'b0;
		end
	else
	
	begin
	
	//vsync
	if (lc<vsynctime)
		VGA_VS<=1'b0;
	else
		VGA_VS <= 1'b1;
	
	// Back porch or front porch
	if ((lc >=vsynctime && lc<vfpte)|| lc>=vbpts)
		v_blank<=1'b1;
	else
		v_blank <= 1'b0;
	
	//vertical visible area
		// nothing else needs to be done
		//lc >= 32'd29 && lc< 32'd629
		
	end// end rst else

end
endmodule