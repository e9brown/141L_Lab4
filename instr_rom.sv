`timescale 1ns / 1ps

module InstrROM(
    input [7:0] InstrAddress,
    output logic[9:0] InstrOut);
	 
 // Instructions have [4bit opcode][3bit rs or rt][3bit rt, immediate, or branch target]
	 
	 always_comb 
		case (InstrAddress)
// opcode = 0 lhw, rs = 0, rt = 1
		0 : InstrOut = 9'b100000001;  // load from address at reg 0 to reg 1  
// opcode = 1 addi, rs/rt = 1, immediate = 1
     
		1 : InstrOut = 9'b000000010;  // addi reg 1 and 1
// replace instruction 1 with the following to produce an infinite loop (shows branch working)
//1 : InstOut = 10'b0001001000;  // addi reg 1 and 0
		
// opcode = 2 shw, rs = 0, rt = 1
		2 : InstrOut = 9'b100000010;  // sw reg 1 to address in reg 0
		
// opcode = 3 beqz, rs = 1, target = 1
      3 : InstrOut = 9'b000000011;  // beqz reg1 to absolute address 1
		
// opcode = 15 halt
		4 : InstrOut = 9'b001000100;  //
		
		5 : InstrOut = 9'b100000000;
		
		6 : InstrOut = 9'b011011100;
		
		7 : InstrOut = 9'b100001001;
		
		8 : InstrOut = 9'b001110001;
		
		9 : InstrOut = 9'b100000001;
		
		10 : InstrOut = 9'b011000011;
		
		11 : InstrOut = 9'b100000010;
		
		12 : InstrOut = 9'b001110011;
		
		13 : InstrOut = 9'b011100110;
		
		14 : InstrOut = 9'b000111000;
		
		15 : InstrOut = 9'b000111110;
		
		16 : InstrOut = 9'b111110101;
		
		17 : InstrOut = 9'b001110011;
		
		18 : InstrOut = 9'b011110110;
		
		19 : InstrOut = 9'b100000011;
		
		20 : InstrOut = 9'b000000011;
		
		21 : InstrOut = 9'b001000100;
		
		22 : InstrOut = 9'b100000000;
		
		23 : InstrOut = 9'b011011100;
		
		24 : InstrOut = 9'b100001001;
		
		25 : InstrOut = 9'b001110001;
		
		26 : InstrOut = 9'b100000001;
		
		27 : InstrOut = 9'b011000011;
		
		28 : InstrOut = 9'b100000010;
		
		29 : InstrOut = 9'b001110011;
		
		30 : InstrOut = 9'b011100110;
		
		31 : InstrOut = 9'b000111000;
		
		32 : InstrOut = 9'b000111101;
		
		33 : InstrOut = 9'b111110101;
		
		34 : InstrOut = 9'b001110011;
		
		35 : InstrOut = 9'b101100101;
		
		36 : InstrOut = 9'b000010100;
		
		37 : InstrOut = 9'b000100100;
		
		38 : InstrOut = 9'b101100100;
		
		39 : InstrOut = 9'b000010100;
		
		40 : InstrOut = 9'b010000000;
		
		default : InstrOut = 9'b000000000;
    endcase

endmodule
