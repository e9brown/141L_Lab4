// Create Date:    18:04:22 10/27/2011 
// Design Name: 
// Module Name:    ALU 
// Project Name: 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
import definitions::*;
module ALU(
  input [4:0] OPCODE,
  //contains 2-bit code for reg identification-reg2 is also flag
  input [1:0] FLAG_REG2, REG1,
  input [7:0] IN1, IN2, INO,
  input [8:0] PC,
  input CLK,
  output logic LONG,
  output logic [7:0] OVERFLOW = 2'b00000000,
  output logic [7:0] DATA_OUT,
  output logic REGWRITE,
  output logic [2:0] REGTARGET,
  output logic [7:0] TARGET,
  output logic [8:0] PCOUT
    );
	 
  op_mne op_mnemonic;
	
  always@(*) begin
  //deafualt values for the case statements
  LONG = 0;
  OVERFLOW = OVERFLOW;
  DATA_OUT = 8'b00000000;
  REGWRITE = 1'b0;
  REGTARGET = 3'b000;
  TARGET = 8'b00000000;
	case(OPCODE)
	  kADD : 
			begin
				LONG = IN1[7];
				DATA_OUT = IN1+IN2;
				//XOR to find if overflow occured
				if(LONG^DATA_OUT[7]) begin
					//overflow has occured, add it
					OVERFLOW = OVERFLOW + 1'b1;
				end
				REGTARGET[1:0] = REG1;
				REGTARGET[2] = 0;
				//program counter increments by one
				PCOUT = PC + 1;
			end
	  kSHF : 
	  		begin
				if(FLAG_REG2 == kZER) begin
					DATA_OUT = IN1 << 1;
					REGTARGET[1:0] = REG1;
					REGTARGET[2] = 0;
				end
				if(FLAG_REG2 == kONS) begin
					DATA_OUT = IN1 >> 4;
					REGTARGET[1:0] = REG1;
					REGTARGET[2] = 0;
				end
				if(FLAG_REG2 == kONE) begin
					DATA_OUT = IN1 << 4;
					REGTARGET[1:0] = REG1;
					REGTARGET[2] = 0;
				end
				if(FLAG_REG2 == kSEV) begin
					DATA_OUT = IN1 >> 1;
					REGTARGET[1:0] = REG1;
					REGTARGET[2] = 0;
				end
				PCOUT = PC + 1;
		end
	  kMOV :
			begin
				DATA_OUT = IN1;
				REGTARGET[1:0] = FLAG_REG2;
				REGTARGET[2] = 0;
				PCOUT = PC + 1;
			end
	  kFIL : 
		begin
				if(FLAG_REG2 == kZER) begin
					DATA_OUT = 8'b00000000;
					REGTARGET[1:0] = REG1;
					REGTARGET[2] = 0;
				end
				if(FLAG_REG2 == kONS) begin
					DATA_OUT = 8'b11111111;
					REGTARGET[1:0] = REG1;
					REGTARGET[2] = 0;
				end
				if(FLAG_REG2 == kONE) begin
					DATA_OUT = 8'b00000001;
					REGTARGET[1:0] = REG1;
					REGTARGET[2] = 0;
				end
				if(FLAG_REG2 == kSEV) begin
					DATA_OUT = 8'b00000111;
					REGTARGET[1:0] = REG1;
					REGTARGET[2] = 0;
				end
				PCOUT = PC + 1;
		end
	  kCMP : 
	   begin
				if(IN1 < IN2)begin
					DATA_OUT = 8'b11111111;
					REGTARGET = 3'b100; //out register id.
				end
				if(IN1 == IN2) begin
					DATA_OUT = 8'b00000000;
					REGTARGET = 3'b100; //out register id.
				end
				if(IN1 > IN2) begin
					DATA_OUT = 8'b00000001;
					REGTARGET = 3'b100; //out register id.
				end
				PCOUT = PC + 1;
		end
	  kAND :
			begin
				DATA_OUT = IN1 & IN2;
				REGTARGET = 3'b100; //out reg id
				PCOUT = PC + 1;
			end
	  kNEG :
			begin
				DATA_OUT = ~IN1+1'b1;
				REGTARGET[1:0] = FLAG_REG2;
				REGTARGET[2] = 0;
				PCOUT = PC + 1;
			end
	  kBRH : 
			begin
				//branch equal(if out is 0)
				if(FLAG_REG2 == kZER) begin
					if(INO==8'b00000000) begin
						DATA_OUT = 8'b00000001;
						//take the branch/target
						//TARGET = IN1 + PC[7:0];
						PCOUT = IN1 + PC[8:0];
					end
				end
				//branch less than
				if((FLAG_REG2 == kONS)) begin
					TARGET = IN1 + PC[7:0];
					DATA_OUT = 8'b00000001;
					if(!(INO >= 0)) begin
						DATA_OUT = 8'b00000001;
						//take the branch/target
						//TARGET = IN1 + PC[7:0];
						PCOUT = IN1 + PC[8:0];
					end
				end
				//branch greater than
				if(FLAG_REG2 == kONE) begin
					if(INO>8'b00000000) begin
						DATA_OUT = 8'b00000001;
						//take the branch/target
						//TARGET = IN1 + PC[7:0];
						PCOUT = IN1 + PC[8:0];
					end
				end
				//branch not equal
				if(FLAG_REG2 == kSEV) begin
					if(INO!=8'b00000000) begin
						DATA_OUT = 8'b00000001;
						//take the branch/target
						//TARGET = IN1 + PC[7:0];
						PCOUT = IN1 + PC[8:0];
					end
				end
		end
	kJUM:
		begin
			if(FLAG_REG2 == kONE) begin
				//IN1 needs to be reg 1 here.
				PCOUT = IN1;
			end
		end
	endcase
	 //calculate target address 
	 
    op_mnemonic = op_mne'(OPCODE);
  end
endmodule
