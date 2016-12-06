`timescale 1ns / 1ps

import definitions::*;


module Lab_3(
	input [8:0] codeInput,
	input clk
	);
	
	
	//wires for the IF portion of the processor
	wire [1:0] tempR1, tempR2_FLAG;
	wire [4:0] opF;
	wire [7:0] targetOut, constant, startAddress, T_IN;
	wire start;
	
	//have input parsed into if1.
	
	instr_fetch if1(
				.CLK(clk),
				.TARGET_IN(T_IN),
				.INSTR(codeInput),
				.START(start),
				.STARTADDRESS(startAddress),
				.OPCODE(opF),
				.REG1(tempR1),
				.REG2(tempR2_FLAG),
				.CONST(constant),
				.TARGET_OUT(targetOut)
				);
				
				
	//wires needed to connect the ALU to the processor unit.
	//data for 2 addressable regs and the out reg-inputs
	wire [7:0] IN1, IN2, INO;
	//output wires for ALU
	wire [7:0] overflow, data_out, target;
	wire [2:0] regtarget;
	wire overflowCheck, regwrite;
	//if overflow stops working look into this
	assign overflow = 8'b00000000;
	//pass the info along to the ALU
	ALU alu1(
				.OPCODE(opF),
				.FLAG_REG2(tempR2_FLAG),
				.REG1(tempR1),
				.IN1(IN1),
				.IN2(IN2),
				.INO(INO),
				//need to verify if PC is code input
				.PC(codeInput),
				.CLK(clk),
				.LONG(overflowCheck),
				.OVERFLOW(overflow),
				.DATA_OUT(data_out),
				.REGWRITE(regwrite),
				.REGTARGET(regtarget),
				.TARGET(target)
	);
	
	//wires and stuff for the reg_file
	wire [2:0] memdest, regdest; //inputs
	wire memwr, regwr; //inputs need initialization
	
	//control unit instantiation
	control_unit cuut(
					.OPCODE(opF),
					.mem_dest(memdest),
					.reg_dest(regdest),
					.mem_wr(memwr),
					.reg_wr(regwr)
					);
	//reg_file insntantiation
	reg_file rf1(
					.WRITE_DATA(data_out),
					.REG1(tempR1),
					.REG2(tempR2_FLAG),
					.MEM_DEST(memdest),
					.REG_DEST(regdest),
					.MEM_WR(memwr),
					.REG_WR(regwr),
					.CLK(clk),
					.DATA_1(IN1),
					.DATA_2(IN2),
					.DATA_O(INO)
	);

	
endmodule

//control unit module
module control_unit( 
	input [4:0] OPCODE,
	input [1:0] REG1,
	input [1:0] FLAG_REG2,
	output logic [2:0] mem_dest, reg_dest,
	output logic mem_wr, reg_wr
	);
	
op_mne op_mnemonic;
	
  always@(*) begin
	case(OPCODE)
	  kADD : 
			begin
				mem_dest =3'b000;
				reg_dest = 3'b000;
				mem_wr = 0;
				reg_wr = 1;		
			end
	  kSHF : 
	  		begin
				mem_dest = 3'b000;
				reg_dest = 3'b000;
				mem_wr = 0;
				reg_wr = 1;	
			end
	  kMOV :
			begin
				mem_dest = 3'b000;
				reg_dest = 3'b000;
				mem_wr = 0;
				reg_wr = 1;
			end
	  kFIL : 
			begin
				mem_dest = 3'b000;
				reg_dest = 3'b000;
				mem_wr = 0;
				reg_wr = 1;
			end
	  kCMP : 
			begin
				mem_dest = 3'b000;
				reg_dest = 3'b000;
				mem_wr = 0;
				reg_wr = 1;
			end
	  kAND :
			begin
				mem_dest = 3'b000;
				reg_dest = 3'b000;
				mem_wr = 0;
				reg_wr = 1;
			end
	  kNEG :
			begin
				mem_dest = 3'b000;
				reg_dest = 3'b000;
				mem_wr = 0;
				reg_wr = 1;
			end
	  kBRH : 
			begin
				mem_dest = 3'b000;
				reg_dest = 3'b000;
				mem_wr = 1;
				reg_wr = 0;
			end
	endcase
	 //calculate target address 
	 
    op_mnemonic = op_mne'(OPCODE);
	end

endmodule
