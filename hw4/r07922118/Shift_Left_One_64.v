//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Description: lsb will be set to 0 and the msb will be cut off
//--------------------------------------------------------------------------------

module Shift_Left_One_64(
    data_i,
    data_o
    );

//I/O ports                    
input [64-1:0] data_i;
output [32-1:0] data_o;
//wire [64-1:0] data_o;


//shift left 1
assign data_o[31:1]= data_i[30:0] ;
assign data_o[0]= 1'b0 ;
  
endmodule
