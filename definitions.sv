//This file defines the parameters used in the alu
package definitions;
    
// Instruction map
	 //basic alu consts
    const logic [4:0]kADD  = 5'b01110;
    const logic [4:0]kSHF  = 5'b00011;
    const logic [4:0]kMOV  = 5'b01111;
	 const logic [4:0]kFIL  = 5'b00100;
	 const logic [4:0]kCMP  = 5'b01101;
	 const logic [4:0]kAND  = 5'b01100;
	 const logic [4:0]kNEG  = 5'b01010;
	 const logic [4:0]kBRH  = 5'b00111;
	 const logic [4:0]kJUM  = 5'b01000;
	 //flag const
	 const logic [1:0]kZER  = 2'b00;
	 const logic [1:0]kONS  = 2'b11;
	 const logic [1:0]kONE  = 2'b01;
	 const logic [1:0]kSEV  = 2'b10;
    
    
    typedef enum logic[3:0] {
        ADDU    = 4'h0, 
        SHF     = 4'h1, 
        MOV     = 4'h2,
		  FIL		 = 4'h3,
		  CMP		 = 4'h4,
		  AND		 = 4'h5,
		  NEG		 = 4'h6,
		  BRH		 = 4'h7,
		  JUM		 = 4'h8,
		  ZER		 = 4'h9,
		  ONS		 = 4'hA,
		  ONE		 = 4'hB,
		  SEV		 = 4'hC
		  
    } op_mne;
    
endpackage // defintions
