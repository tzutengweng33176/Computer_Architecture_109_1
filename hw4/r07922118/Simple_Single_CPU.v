//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
        nrst_i
		);
		
//I/O port
input			clk_i;
input			nrst_i;  // negative reset  //what do you mean by negative reset?

//Internal Signals
//PC
wire [32-1:0] pc_in, pc_out;
wire [32-1:0] pc_add_4; //output of adder 1
wire [32-1:0] pc_branch; //output of adder 2
wire [32-1:0] pc_shift_left_1; //output of shift left 1, input of adder2(should it be 64 bits????) 
wire [32-1:0] instr; //32-bit instruction, read from instrunction memory

// decoder
wire [2-1:0] ALU_Op;
wire Branch; 
wire MemtoReg;
wire MemRead, MemWrite, ALUSrc, RegWrite; 

//Register File
wire [64-1:0] read_data_1;
wire [64-1:0] read_data_2;
wire [64-1:0] write_data;



//sign extend
wire [64-1:0] constant; //output of ImmGen, input of MUX_ALU and Sift Left 1

//ALU
wire [64-1:0] ALU_result;
wire ALU_zero;
//MUX ALU
wire [64-1:0] Mux_ALU; //or ALU src2, input of ALU and output of MUX ALU

//ALU control
wire [4-1:0] ALUCtrl;


//Data memory
wire [64-1:0] read_data_from_DM;


//MUX PC source select
wire Mux_PC_source_select;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .nrst_i (nrst_i),     
	    .pc_in_i(pc_in) ,   
	    .pc_out_o(pc_out) 
	    );

// adder for program counter
Adder Adder1(
        .src1_i(pc_out),     
	    .src2_i(32'd4), //add 4     
	    .sum_o(pc_add_4)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_out),  
	    .instr_o(instr)    
	    );
		
Reg_File Registers(
        .clk_i(clk_i),      
	    .nrst_i(nrst_i) ,     
        .RSaddr_i(instr[19:15]) ,  //read register 1
        .RTaddr_i(instr[24:20]) ,  //read register 2 
        .RDaddr_i(instr[11:7]) ,  //rd 
        .RDdata_i(write_data)  ,  //write data  
        .RegWrite_i (RegWrite),  //from control
        .RSdata_o(read_data_1) ,   //input to ALU src1 
        .RTdata_o( read_data_2)   //input to ALU src2  
        );
	
Decoder Decoder(
        .instr_op_i(instr[6:0]), 
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o( ALU_Op),   
	    .ALUSrc_o(ALUSrc),      
		.Branch_o(Branch),
		.MemRead_o(MemRead),
		.MemWrite_o(MemWrite),
		.MemtoReg_o(MemtoReg)
	    );

ALU_Ctrl AC(
        .funct3_i(instr[14:12]),
		.funct7_i(instr[31:25]),		
        .ALUOp_i(ALU_Op),   
        .ALUCtrl_o(ALUCtrl) 
        );
	
Imm_Gen IG(
    .instr_i(instr),
    .signed_extend_o(constant)
    );

MUX_2to1 #(.size(64)) Mux_ALUSrc(
        .data0_i(read_data_2),
        .data1_i(constant),
        .select_i(ALUSrc),
        .data_o(Mux_ALU)
        );	

wire cout, overflow;  //actually will not be used
		
ALU ALU(
        .src1_i(read_data_1),
	    .src2_i(Mux_ALU),
	    .ctrl_i(ALUCtrl),
	    .result_o(ALU_result),
		.zero_o(ALU_zero),
             .cout(cout),
             .overflow(overflow) 
   	    );
	
Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(ALU_result),
	.data_i(read_data_2),
	.MemRead_i(MemRead),
	.MemWrite_i(MemWrite),
	.data_o(read_data_from_DM)
	);
	
Adder Adder2(
        .src1_i(pc_out),     
	    .src2_i(pc_shift_left_1),     
	    .sum_o(pc_branch)      
	    );
		
Shift_Left_One_64 Shifter(
        .data_i(constant),
        .data_o(pc_shift_left_1)
        ); 		

assign Mux_PC_source_select= Branch&ALU_zero;
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pc_add_4),
        .data1_i(pc_branch),
        .select_i(Mux_PC_source_select),
        .data_o(pc_in)
        );	

MUX_2to1 #(.size(64)) Mux_Write_Back(
        .data0_i(ALU_result),
        .data1_i(read_data_from_DM),
        .select_i(MemtoReg),
        .data_o(write_data)
        );	

endmodule
		  


