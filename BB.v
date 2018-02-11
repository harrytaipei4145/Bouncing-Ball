`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:19:48 01/09/2016 
// Design Name: 
// Module Name:    BB 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module BB(output vsync,output hsync,input rst,output reg blue,output reg red,output reg green,input clk,input kclk,input kdata
    );

reg [21:0]key_reg;
reg [15:0]col,row;
reg [7:0]key_data;
wire ball;
wire wall;
reg c_state,n_state,clk_new;
reg signed [15:0]way;
reg [50:0]count,count1,x_count,y_count,state_count,time_x,time_y,c1,c2;
wire visible,check;
reg random_x,random_y,random_state;
reg [5:0]state;
reg clk_x,clk_y;
reg signed[15:0]x,y;
reg [15:0]speed;
assign hsync=~((col>=919) & (col<1039));
assign vsync=~((row>=659) & (row<665));
assign wall=((col>=164) & (col<864) & (row>=23) & (row<623));
assign visible=((col>=189) & (col<839) & (row>=48) & (row<598));
assign check=key_reg[1]^key_reg[2]^key_reg[3]^key_reg[4]^key_reg[5]^key_reg[6]^key_reg[7]^key_reg[8]^key_reg[9];
assign ball=((col-x)*(col-x)+(row-y)*(row-y)<=625);

always @(posedge clk or posedge rst)begin
if(rst)
speed<=300;
else if(ball==1&&wall==1)
speed<=speed/2;
else
speed<=speed;
end





always @(posedge clk or posedge rst)begin
if(rst)
col<=0;
else if(col==1039)
col<=0;
else
col<=col+1;
end

always @(posedge clk or posedge rst)begin
if(rst)
row<=0;
else if(col==1039)
row<=row+1;
else if(row==665)
row<=0;
else
row<=row;
end


always @(posedge clk or posedge rst)begin
if(rst)begin
blue<=0;
green<=0;
red<=0;
end
else if(ball)begin
blue<=0;
green<=0;
red<=1;
end
else if(visible && !ball)begin
blue<=1;
green<=0;
red<=0;
end
else if(wall && !visible)begin
blue<=1;
green<=1;
red<=1;
end
else
begin
blue<=0;
green<=0;
red<=0;
end
end


always @(posedge clk or posedge rst)begin
if(rst)begin
c_state<=0;
n_state<=0;
end
else
begin
c_state<=n_state;
n_state<=kclk;
end	
end


always @(posedge clk or posedge rst)begin
if(rst)
key_reg<=22'b0000000000000000000000;
else if(count==100000)
key_reg<=22'b0000000000000000000000;
else
begin
case({c_state,n_state})
2'b10:
key_reg<={kdata,key_reg[21:1]};
default:
key_reg<=key_reg;
endcase
end
end


always @(posedge clk or posedge rst)begin
if(rst)
key_data<=0;

else if(check==1)begin
if(key_reg[19:12]==8'h74)
key_data<=8'h74;
else if(key_reg[19:12]==8'h6B)
key_data<=8'h6B;
else
key_data<=key_reg[19:12];
end

else
key_data<=key_reg[19:12];
end




always@(posedge clk or posedge rst)
begin
	if(rst)
	state<=0;
	else if(key_data==8'h74)
		begin
			if(state==23)
				state<=0;
			else 
				state<=state+1;
		end
		
	else if(key_data==8'h6B)
		begin
			if(state==0)
				state<=23;
			else 
				state<=state-1;
		end
	else if(ball==1 && wall==1)
		if(x==214)
		begin
		case(state)
		7:state<=5;
		8:state<=4;
		9:state<=3;
		10:state<=2;
		11:state<=1;
		12:state<=0;
		13:state<=23;
		14:state<=22;
		15:state<=21;
		16:state<=20;
		17:state<=19;
		endcase
		end
		
		else if(x==813)
		begin
		case(state)
		0:state<=12;
		1:state<=11;
		2:state<=10;
		3:state<=9;
		4:state<=8;
		5:state<=7;
		19:state<=17;
		20:state<=16;
		21:state<=15;
		22:state<=14;
		23:state<=13;
		default:
		sta
		endcase
		end
		
		else if(y==73)
		begin
		case(state)
		1:state<=23;
		2:state<=22;
		3:state<=21;
		4:state<=20;
		5:state<=19;
		6:state<=18;
		7:state<=17;
		8:state<=16;
		9:state<=15;
		10:state<=14;
		11:state<=13;
		endcase
		end
		
		else 
		begin
		case(state)
		13:state<=11;
		14:state<=10;
		15:state<=9;
		16:state<=8;
		17:state<=7;
		18:state<=6;
		19:state<=5;
		20:state<=4;
		21:state<=3;
		22:state<=2;
		23:state<=1;
		endcase
		end
		
	else 
		state<=state;
	
		
		
end



always@(posedge clk or posedge rst)
begin
	if(rst)
begin
time_x<=50000000/300*1;
time_y<=50000000/300*1;

end
else
begin
	case(state)
	0:
		begin
			time_x<=50000000/300*1;
			time_y<=50000000/300*1;
		end
	1:
		begin
			time_x<=50000000/300*966/1000;
			time_y<=50000000/300*259/1000;
		end
		
	2:
		begin
			time_x<=50000000/300*866/1000;
			time_y<=50000000/300*500/1000;
		end
	3:
		begin
			time_x<=50000000/300*707/1000;
			time_y<=50000000/300*707/1000;
		end
	4:
		begin
			time_x<=50000000/300*500/1000;
			time_y<=50000000/300*866/1000;
		end
	5:
		begin
			time_x<=50000000/300*259/1000;
			time_y<=50000000/300*966/1000;
		end
	6:
		begin
			time_x<=50000000/300*1;
			time_y<=50000000/300*1;
		end
	7:
		begin
			time_x<=50000000/300*259/1000;
			time_y<=50000000/300*966/1000;
		end
	8:
		begin
			time_x<=50000000/300*500/1000;
			time_y<=50000000/300*866/1000;
		end
	9:
		begin
			time_x<=50000000/300*707/1000;
			time_y<=50000000/300*707/1000;
		end
	10:
		begin
			time_x<=50000000/300*866/1000;
			time_y<=50000000/300*500/1000;
		end
	11:
		begin
			time_x<=50000000/300*966/1000;
			time_y<=50000000/300*259/1000;
		end
	12:
		begin
			time_x<=50000000/300*1;
			time_y<=50000000/300*1;
		end
	13:
		begin
			time_x<=50000000/300*966/1000;
			time_y<=50000000/300*259/1000;
		end
	14:
		begin
			time_x<=50000000/300*866/1000;
			time_y<=50000000/300*500/1000;
		end
	15:
		begin
			time_x<=50000000/300*707/1000;
			time_y<=50000000/300*707/1000;
		end
	16:
		begin
			time_x<=50000000/300*500/1000;
			time_y<=50000000/300*866/1000;
		end
	17:
		begin
			time_x<=50000000/300*259/1000;
			time_y<=50000000/300*966/1000;
		end
	18:
		begin
			time_x<=50000000/300*1;
			time_y<=50000000/300*1;
		end
	19:
		begin
			time_x<=50000000/300*259/1000;
			time_y<=50000000/300*966/1000;
		end
	20:
		begin
			time_x<=50000000/300*500/1000;
			time_y<=50000000/300*866/1000;
		end
	21:
		begin
			time_x<=50000000/300*707/1000;
			time_y<=50000000/300*707/1000;
		end
	22:
		begin
			time_x<=50000000/300*866/1000;
			time_y<=50000000/300*500/1000;
		end
	23:
		begin
			time_x<=50000000/300*966/1000;
			time_y<=50000000/300*259/1000;
		end
	default:
	begin
		time_x<=time_x;
			time_y<=time_y;
		end
	endcase
	end
	
end

always @(posedge clk or posedge rst)
begin
	if(rst)
		begin
			clk_x<=0;
			c1<=0;
		end
	else if(c1==time_x/2)
		begin
			c1<=c1+1;
			clk_x<=0;
		end
	else if(c1==time_x)
		begin
			clk_x<=1;
			c1<=0;
		end
	
	else
		begin
			clk_x<=clk_x;
			c1<=c1+1;
		end
end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			begin
				clk_y<=0;
				c2<=0;
			end
		
		else if(c2==time_y/2)
			begin
				c2<=c2+1;
				clk_y<=0;
			end
		
		else if(c2==time_y)
			begin
				clk_y<=1;
				c2<=0;
			end
		
		else
			begin
				clk_y<=clk_y;
				c2<=c2+1;
			end
		end
	
	
	
	
always @(posedge clk_x or posedge rst)
begin
if(rst)
x<=215;
	else if ((state>=0 && state<=5) || (state>=19 && state<=23) )
		x<=x+1;
	
	else if(state==6 || state ==18)
		x<=x;
	else 
		x<=x-1;

end


always @(posedge clk_y or posedge rst)
begin
if(rst)
y<=73;
else	if (state>=1 && state<=11)
		y<=y-1;
	
	else if(state==0 || state ==12)
		y<=y;
	else 
		y<=y+1;

end

always @(posedge clk or posedge rst)begin
if(rst)
count<=0;
else if(key_reg!=22'b0000000000000000000000 && count<100000)
count<=count+1;
else if(count==100000)
count<=0;
else
count<=count;
end

always @(posedge clk or posedge rst)begin
if(rst)begin
clk_new<=0;
count1<=0;
end
else if(count1==25000)begin
count1<=count1+1;
clk_new<=0;
end
else if(count1==50000)begin
clk_new<=1;
count1<=0;
end 
else
begin
clk_new<=clk_new;
count1<=count1+1;
end
end






endmodule
