////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//               Application Assignment Problem 5 Module 3 Course 2           //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
//
// 
// @file AAC2M3H1.v
// @brief Application Assignment 2-007 4-bit full adder
// @version: 1.0 
// Date of current revision:  @date 2019-07-01  
// Target FPGA: [Intel Altera MAX10] 
// Tools used: [Quartus Prime 16.1 or Sigasi] for editing and/or synthesis 
//             [Modeltech ModelSIM 10.4a Student Edition] for simulation 
//             [Quartus Prime 16.1]  for place and route if applied
//             
//  Functional Description:  This file contains the Verilog which describes the 
//               FPGA implementation of 4-bit adder with carry. The inputs are 2 
//               3-bit vectors A and B, and a scalar carry in Cin.  Outputs are
//               Sum and Cout.  
//
//  Hierarchy:  There is only one level in this simple design.
//        
//  Designed by:  @author [your name] 
//                [Organization]
//                [email] 
//
//      Copyright (c) 2019 by Tim Scherr
//
// Redistribution, modification or use of this software in source or binary
// forms is permitted as long as the files maintain this copyright. Users are
// permitted to modify this and use it to learn about the field of HDl code.
// Tim Scherr and the University of Colorado are not liable for any misuse
// of this material.
//////////////////////////////////////////////////////////////////////////////
// 
  	                                            		

module FullAdd( A,B,Cin,Sum,Cout);                	
    input  A, B; 			
    input Cin; 			
    output Sum;
    output Cout;

    wire S1, C1, C2;

    assign S1 = A ^ B;
    assign Sum = S1 ^ Cin;
    assign C1 = A & B;
    assign C2 = S1 & Cin;
    assign Cout = C1 | C2;

endmodule // FullAdd

module FullAdd4( A,B,Cin,Sum,Cout);                	
    input [3:0] A, B;
    input Cin; 			
    output [3:0] Sum;
    output Cout;

// student code here

    wire C1, C2, C3;
    
    FullAdd FA0 (
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin),
        .Sum(Sum[0]),
        .Cout(C1)
    );
    
    FullAdd FA1 (
        .A(A[1]),
        .B(B[1]),
        .Cin(C1),
        .Sum(Sum[1]),
        .Cout(C2)
    );
    
    FullAdd FA2 (
        .A(A[2]),
        .B(B[2]),
        .Cin(C2),
        .Sum(Sum[2]),
        .Cout(C3)
    );
    
    FullAdd FA3 (
        .A(A[3]),
        .B(B[3]),
        .Cin(C3),
        .Sum(Sum[3]),
        .Cout(Cout)
    );


endmodule // Majority  
