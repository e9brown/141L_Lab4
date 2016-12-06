// A register file with asynchronous read and synchronous write
module reg_file
                (input [7:0] WRITE_DATA,
		input [2:0] REG1,
		input [2:0] REG2,
	   input [2:0] MEM_DEST,
		input [2:0] REG_DEST,
		input MEM_WR,
		input REG_WR,
		input CLK,
		output logic [7:0] DATA_1,
		output logic [7:0] DATA_2,
		output logic [7:0] DATA_O
		);	
	logic [7:0] REG_A; //000
 	logic [7:0] REG_B; //010
	logic [7:0] REG_X; //100
	logic [7:0] REG_Y; //110
	logic [7:0] REG_OUT; //001, unused currently
	logic [7:0] REG_COUNTER; //101, unused currently

              
always@(*)
  begin
      if (MEM_WR) begin
	     //do nothing for this until we have a memory system
      end
      if (REG_WR) begin
	      case(REG_DEST)
		      3'b000 : REG_A = WRITE_DATA;
		      3'b010 : REG_B = WRITE_DATA;
		      3'b100 : REG_X = WRITE_DATA;
		      3'b110 : REG_Y = WRITE_DATA;
		      3'b001 : REG_OUT = WRITE_DATA;
		      3'b101 : REG_COUNTER = WRITE_DATA;
	      endcase
      end
		//write out reg to the out register
		DATA_O = REG_OUT;
      case (REG1)
	      3'b000 : DATA_1 = REG_A;
              3'b010 : DATA_1 = REG_B;
     	      3'b100 : DATA_1 = REG_X;
      	      3'b110 : DATA_1 = REG_Y;
      	      3'b001 : DATA_1 = REG1;
	      3'b101 : DATA_1 = REG1; 
	      default: DATA_1 = 8'b00000000;
      endcase
      case (REG2)
	     3'b000 : DATA_2 = REG_A;
             3'b010 :DATA_2 = REG_B;
             3'b100 :DATA_2 = REG_X;
             3'b110 :DATA_2 = REG_Y;
             3'b001 :DATA_2 = REG_OUT;
             3'b101 :DATA_2 = REG_COUNTER;
	     default :DATA_2 = 8'b00000000;
      endcase
  end
endmodule


