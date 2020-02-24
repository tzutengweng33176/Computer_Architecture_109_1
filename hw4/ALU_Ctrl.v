//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:   Tzu-teng Weng   
//----------------------------------------------
//Date:  2019/12/19      
//----------------------------------------------
//Description: See CA_RISC_V p.336(Figure 4.12)
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct3_i,
          funct7_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [3-1:0] funct3_i;   //inst[14:12]
input      [7-1:0] funct7_i; //inst[31:25]
input      [2-1:0] ALUOp_i; //from decoder.v

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter

//Select exact operation
always@(*) begin
   case(ALUOp_i) //2 bits input
    2'b00: case(funct3_i)
           3'b011: ALUCtrl_o=4'b0010;//ld, sd
           3'b000: ALUCtrl_o=4'b0010; //addi
           3'b010: ALUCtrl_o=4'b0111;//slti    
           endcase 

           //ld, sd, addi, slti
    2'b01: ALUCtrl_o=4'b0110;//beq 
    2'b10: //R-type 
         case(funct7_i)
         7'b0000000: //add, and, or, slt
                   case(funct3_i)
                   3'b000: ALUCtrl_o =4'b0010;  //add 
                   3'b111: ALUCtrl_o =4'b0000;//and 
                   3'b110: ALUCtrl_o =4'b0001;//or
                   3'b010: ALUCtrl_o=4'b0111;//slt   
                   endcase     
         7'b0100000: 
                   case(funct3_i) //sub  
                   3'b000: ALUCtrl_o= 4'b0110;  //sub                  
                   endcase
         endcase    
    default: ALUCtrl_o= 4'bxxxx;
//2'b11: 
   //deal with R-format, ld, sd first; later deal with I-format
   endcase
end
endmodule     





                    
                    