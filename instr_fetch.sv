import definitions::*;
module instr_fetch
	(input CLK
	,input [7:0] TARGET_IN
	,input [8:0] INSTR
	,input START
	,input [7:0] STARTADDRESS
	,output logic [4:0] OPCODE
	,output logic [1:0] REG1
	,output logic [1:0] REG2
	,output logic [7:0] CONST
	,output logic [7:0] TARGET_OUT
	);

always_ff @ (posedge CLK) 
  begin
	TARGET_OUT <= TARGET_IN;
	OPCODE <= INSTR[8:4];
	REG1 <= INSTR[3:2];
	REG2 <= INSTR[1:0];
	CONST <= INSTR[7:0];

  end
endmodule


