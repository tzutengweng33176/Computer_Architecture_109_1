`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    
// Design Name:
// Module Name:    alu
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

module alu( //use alu_top.v to contruct the 32-bit alu
            rst_n,         // negative reset            (input)
            src1,          // 32 bits source 1          (input)
            src2,          // 32 bits source 2          (input)
            ALU_control,   // 4 bits ALU control input  (input)
            result,        // 32 bits result            (output)
            zero,          // 1 bit when the output is 0, zero must be set (output)
            cout,          // 1 bit carry out           (output)
            overflow       // 1 bit overflow            (output)
            );


endmodule
