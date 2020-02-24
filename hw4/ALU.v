//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o,
        cout,
        overflow
	);
     
//I/O ports
input  [64-1:0]  src1_i;
input  [64-1:0]	 src2_i;
input  [4-1:0]   ctrl_i; //ALUCtrl_o

output [64-1:0]	 result_o;
output           zero_o;
output          cout; //carry out
output          overflow;

//cout and overflow ports won't be used in this assignment
//Internal signals
wire    [64-1:0]  result_o;
wire             zero_o;

//Parameter


//Main function
reg [1:0] oper;
wire [63:0] carry;
reg a_in;
reg b_in;
reg less_sig;
wire			set;
wire			equal;

assign carry[0] = (ctrl_i==4'b0110)? 1: (ctrl_i==4'b0111)? 1: 0; //sub slt: cin =1
assign zero_o = (result_o == 0) ? 1 : 0; 
//assign overflow = carry[31] ^ cout;
assign equal = (src1_i == src2_i) ? 1 : 0;
assign overflow = ( (ctrl_i==4'b0000) & src1_i[63] & src2_i[63] & ~result_o[63]) ? 1 
					  :( (ctrl_i==4'b0000) & ~src1_i[63] & ~src2_i[63] & result_o[63]) ? 1 
					  :( (ctrl_i==4'b0110) & src1_i[63] & ~src2_i[63] & ~(result_o[63])) ? 1 
					  :( (ctrl_i==4'b0110) & ~src1_i[63] & src2_i[63] & result_o[63]) ? 1 
					  : 0;


always@(*) //begin and end act like curly braces in C++
begin //means {
	 begin
		less_sig <= 1'b0;
		
		case(ctrl_i)
			4'b0000:begin//And
					a_in  	<= 0;
					b_in 	 	<= 0;
					oper  	<= 2'b00;//and
					end
			4'b0001:begin//Or
					a_in  	<= 0;
					b_in 	 	<= 0;
					oper  	<= 2'b01;//or
					end
			4'b0010:begin//Add
					a_in  	<= 0;
					b_in 	 	<= 0;
					oper  	<= 2'b10;//add
					end
			4'b0110:begin//Sub
					a_in  	<= 0;
					b_in 	 	<= 1;
					oper  	<= 2'b10;//add
					end
			4'b1100:begin//Nor
					a_in  	<= 1;
					b_in 	 	<= 1;
					oper  	<= 2'b00;//and
					end
			4'b1101:begin//Nand
					a_in  	<= 1;
					b_in 	 	<= 1;
					oper  	<= 2'b01;//or
					end
			4'b0111:begin//SetLessThan
					a_in  	<= 0;
					b_in 	 	<= 1;
					oper  	<= 2'b11;//less
					end
			default: ;
		endcase
	end
end //means }

alu_top alu0(.src1(src1_i[0]), .src2(src2_i[0]), .less(set), .A_invert(a_in), .B_invert(b_in),
				  .cin(carry[0]), .operation(oper), .result(result_o[0]), .cout(carry[1]));
genvar i;
generate
for(i=1; i<63; i=i+1)begin
alu_top alu(.src1(src1_i[i]), .src2(src2_i[i]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
				  .cin(carry[i]), .operation(oper), .result(result_o[i]), .cout(carry[i+1]));
end //alu0-62, 63bits
endgenerate

alu_last alu63( .src1(src1_i[63]), .src2(src2_i[63]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
					.cin(carry[63]), .operation(oper), .result(result_o[63]), .cout(cout),
					.set(set), .equal(equal) );

endmodule





                    
                    