//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Tzu-teng Weng
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: Decoder is the "control" in the figure; more information can be seen in textbook chapter 4
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	Branch_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o
	);
     
//I/O ports
input	[7-1:0]	instr_op_i;
//1 input
output			RegWrite_o;
output	[2-1:0]	ALU_op_o;
output			ALUSrc_o;
output			Branch_o;
output			MemRead_o;
output			MemWrite_o;
output			MemtoReg_o;
//7 outputs 
//Internal Signals
reg	[2-1:0]		ALU_op_o;
reg				ALUSrc_o;
reg				RegWrite_o;
reg				Branch_o;
reg				MemRead_o;
reg				MemWrite_o;
reg				MemtoReg_o;

//Parameter


//Main function
always@(*) begin
    case(instr_op_i)
      7'b0110011:begin  //R-format
      RegWrite_o=1;
      ALU_op_o= 2'b10;
      ALUSrc_o=0;
      Branch_o=0; 
      MemRead_o=0;
      MemWrite_o=0;
      MemtoReg_o=0;
      end
      7'b0000011:begin  //ld
      RegWrite_o=1;
      ALU_op_o= 2'b00;
      ALUSrc_o=1;
      Branch_o=0; 
      MemRead_o=1;
      MemWrite_o=0;
      MemtoReg_o=1;
      end
      7'b0100011:begin  //sd
      RegWrite_o=0;
      ALU_op_o= 2'b00;
      ALUSrc_o=1;
      Branch_o=0; 
      MemRead_o=0;
      MemWrite_o=1;
      MemtoReg_o=1'bx;  //dontcare
      end
      7'b1100011:begin  //beq
      RegWrite_o=0;
      ALU_op_o= 2'b01;
      ALUSrc_o=0;
      Branch_o=1; 
      MemRead_o=0;
      MemWrite_o=0;
      MemtoReg_o=1'bx;
      end
      //addi, slti                    
     7'b0010011:begin  //addi, slti  -->the difference between these two inst is funct3
      RegWrite_o=1;
      ALU_op_o= 2'b00;
      ALUSrc_o=1;
      Branch_o=0; 
      MemRead_o=0;
      MemWrite_o=0;
      MemtoReg_o=0;
      end
      default: begin
       RegWrite_o=1'bx;
      ALU_op_o= 2'bxx;
      ALUSrc_o=1'bx;
      Branch_o=1'bx; 
      MemRead_o=1'bx;
      MemWrite_o=1'bx;
      MemtoReg_o=1'bx;
      end
    endcase
end

endmodule





                    
                    