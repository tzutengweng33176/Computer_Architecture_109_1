//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ProgramCounter(
    clk_i,
	nrst_i,
	pc_in_i,
	pc_out_o
	);
     
//I/O ports
input           clk_i;
input	        nrst_i;
input  [32-1:0] pc_in_i;
output [32-1:0] pc_out_o;
 
//Internal Signals
reg    [32-1:0] pc_out_o;
 
//Parameter

    
//Main function
always @(posedge clk_i) begin
    if(~nrst_i)
	    pc_out_o <= 0;
	else
	    pc_out_o <= pc_in_i;
end

endmodule



                    
                    