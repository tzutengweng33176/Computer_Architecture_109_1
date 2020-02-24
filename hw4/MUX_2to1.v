//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Tzu-teng Weng
//----------------------------------------------
//Date:  2019-12-19      
//----------------------------------------------
//Description:  select data1 as output if select_i==1 else select data0 as output
//--------------------------------------------------------------------------------
     
module MUX_2to1(
               data0_i,
               data1_i,
               select_i,
               data_o
               );

parameter size = 0;			   
			
//I/O ports               
input   [size-1:0] data0_i;          
input   [size-1:0] data1_i;
input              select_i;
output  [size-1:0] data_o; 

//Internal Signals
wire     [size-1:0] data_o;  //Register is illegal in left-hand side of continuous assignment
//about continuous assignment, see: http://web.mit.edu/6.111/www/f2017/handouts/L03_4.pdf for more details
//Main function
assign data_o= (select_i)?data1_i:data0_i;

endmodule      
          
          