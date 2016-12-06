`timescale 1ns / 1ps

module Lab_3_testchench;

	//input for the processor
	reg [8:0] codeinput;
	reg clk;
	
	//instantiate the unit under testing
	Lab_3 uut(
			.codeInput(codeinput),
			.clk(clk)
		);
		
	//begin testing
	initial begin
		//initilize inputs
		codeinput = 9'b000000000;
		clk = 0;
		
		#100;
		
		$stop;
	end
	
	//clock singals
	always begin
		clk= ~clk;
		#10;
	end
endmodule
