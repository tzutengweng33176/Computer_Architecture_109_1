`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    Data_Memory 
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
module Data_Memory
(
	clk_i,
	addr_i,
	data_i,
	MemRead_i,
	MemWrite_i,
	data_o
);

// Interface
input				clk_i;
input	[64-1:0]		addr_i;
input	[64-1:0]		data_i;
input				MemRead_i;
input				MemWrite_i;
output	[64-1:0] 		data_o;

// Signals
reg		[64-1:0]		data_o;

// Memory
reg		[7:0]		Mem 			[0:255];	// address: 0x00~0x80
integer				i;

// For Testbench to debug
wire	[31:0]		memory			[0:31];
assign  memory[0] = {Mem[7], Mem[6], Mem[5], Mem[4], Mem[3], Mem[2], Mem[1], Mem[0]};
assign  memory[1] = {Mem[15], Mem[14], Mem[13], Mem[12], Mem[11], Mem[10], Mem[9], Mem[8]};
assign  memory[2] = {Mem[23], Mem[22], Mem[21], Mem[20], Mem[19], Mem[18], Mem[17], Mem[16]};
assign  memory[3] = {Mem[31], Mem[30], Mem[29], Mem[28], Mem[27], Mem[26], Mem[25], Mem[24]};
assign  memory[4] = {Mem[39], Mem[38], Mem[37], Mem[36], Mem[35], Mem[34], Mem[33], Mem[32]};
assign  memory[5] = {Mem[47], Mem[46], Mem[45], Mem[44], Mem[43], Mem[42], Mem[41], Mem[40]};
assign  memory[6] = {Mem[55], Mem[54], Mem[53], Mem[52], Mem[51], Mem[50], Mem[49], Mem[48]};
assign  memory[7] = {Mem[63], Mem[62], Mem[61], Mem[60], Mem[59], Mem[58], Mem[57], Mem[56]};
assign  memory[8] = {Mem[71], Mem[70], Mem[69], Mem[68], Mem[67], Mem[66], Mem[65], Mem[64]};
assign  memory[9] = {Mem[79], Mem[78], Mem[77], Mem[76], Mem[75], Mem[74], Mem[73], Mem[72]};
assign  memory[10] = {Mem[87], Mem[86], Mem[85], Mem[84], Mem[83], Mem[82], Mem[81], Mem[80]};
assign  memory[11] = {Mem[95], Mem[94], Mem[93], Mem[92], Mem[91], Mem[90], Mem[89], Mem[88]};
assign  memory[12] = {Mem[103], Mem[102], Mem[101], Mem[100], Mem[99], Mem[98], Mem[97], Mem[96]};
assign  memory[13] = {Mem[111], Mem[110], Mem[109], Mem[108], Mem[107], Mem[106], Mem[105], Mem[104]};
assign  memory[14] = {Mem[119], Mem[118], Mem[117], Mem[116], Mem[115], Mem[114], Mem[113], Mem[112]};
assign  memory[15] = {Mem[127], Mem[126], Mem[125], Mem[124], Mem[123], Mem[122], Mem[121], Mem[120]};
assign  memory[16] = {Mem[135], Mem[134], Mem[133], Mem[132], Mem[131], Mem[130], Mem[129], Mem[128]};
assign  memory[17] = {Mem[143], Mem[142], Mem[141], Mem[140], Mem[139], Mem[138], Mem[137], Mem[136]};
assign  memory[18] = {Mem[151], Mem[150], Mem[149], Mem[148], Mem[147], Mem[146], Mem[145], Mem[144]};
assign  memory[19] = {Mem[159], Mem[158], Mem[157], Mem[156], Mem[155], Mem[154], Mem[153], Mem[152]};
assign  memory[20] = {Mem[167], Mem[166], Mem[165], Mem[164], Mem[163], Mem[162], Mem[161], Mem[160]};
assign  memory[21] = {Mem[175], Mem[174], Mem[173], Mem[172], Mem[171], Mem[170], Mem[169], Mem[168]};
assign  memory[22] = {Mem[183], Mem[182], Mem[181], Mem[180], Mem[179], Mem[178], Mem[177], Mem[176]};
assign  memory[23] = {Mem[191], Mem[190], Mem[189], Mem[188], Mem[187], Mem[186], Mem[185], Mem[184]};
assign  memory[24] = {Mem[199], Mem[198], Mem[197], Mem[196], Mem[195], Mem[194], Mem[193], Mem[192]};
assign  memory[25] = {Mem[207], Mem[206], Mem[205], Mem[204], Mem[203], Mem[202], Mem[201], Mem[200]};
assign  memory[26] = {Mem[215], Mem[214], Mem[213], Mem[212], Mem[211], Mem[210], Mem[209], Mem[208]};
assign  memory[27] = {Mem[223], Mem[222], Mem[221], Mem[220], Mem[219], Mem[218], Mem[217], Mem[216]};
assign  memory[28] = {Mem[231], Mem[230], Mem[229], Mem[228], Mem[227], Mem[226], Mem[225], Mem[224]};
assign  memory[29] = {Mem[239], Mem[238], Mem[237], Mem[236], Mem[235], Mem[234], Mem[233], Mem[232]};
assign  memory[30] = {Mem[247], Mem[246], Mem[245], Mem[244], Mem[243], Mem[242], Mem[241], Mem[240]};
assign  memory[31] = {Mem[255], Mem[254], Mem[253], Mem[252], Mem[251], Mem[250], Mem[249], Mem[248]};

initial begin
	for(i=0; i<256; i=i+1)
		Mem[i] = 8'b0;

end 

always@(posedge clk_i) begin
    if(MemWrite_i) begin
		Mem[addr_i+7] <= data_i[63:56];
		Mem[addr_i+6] <= data_i[55:48];
		Mem[addr_i+5] <= data_i[47:40];
		Mem[addr_i+4] <= data_i[39:32];
		Mem[addr_i+3] <= data_i[31:24];
		Mem[addr_i+2] <= data_i[23:16];
		Mem[addr_i+1] <= data_i[15:8];
		Mem[addr_i]   <= data_i[7:0];
	end
end

always@(addr_i or MemRead_i) begin
	if(MemRead_i)
		data_o = {Mem[addr_i+7], Mem[addr_i+6], Mem[addr_i+5], Mem[addr_i+4], Mem[addr_i+3], Mem[addr_i+2], Mem[addr_i+1], Mem[addr_i]};
end

endmodule

