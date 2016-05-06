/*

module MyCounter (CLOCK_50,AUX_INPUT, DEBUG_OUTPUT, 
			LED_OUTPUT, ON_MODE, START, SysClock_Enabler, Clear);	
		input [0:0] CLOCK_50;

		wire [25:0] CountValue;
		reg [0:0] Enabler;
		output reg [0:0] ON_MODE;
		input [0:0] AUX_INPUT;w
		output reg Clear;
		output[0:0] START;
		wire [2:0] TEMP_COUNT; 
		output reg [0:0] DEBUG_OUTPUT;
		output [3:0] LED_OUTPUT;		
		output reg [0:0] SysClock_Enabler;
//		MyFrequencyDivider my_Divider (CLOCK_50, Enabler);
//		ClockCycleCounter  myClockCycleCounter (CLOCK_50, CycleCount);
		
initial
	begin
		Clear = 0;
		Enabler = 0;
		//START  = 0;
		DEBUG_OUTPUT = 0;
		ON_MODE = 0;
	//	OFF_MODE = 0;
	end	
	
	always @(AUX_INPUT)	// When AUX_INPUT changes. 
		begin
			if(AUX_INPUT)	// Rising edge.
			begin
				SysClock_Enabler = 1;
//				START = 1;
//				LED_OUTPUT[1] = 1;
//				LED_OUTPUT[2]   = 0;
			end
			else				// Falling edge.
			begin
				SysClock_Enabler = 0;	
	//			START = 0;
//				LED_OUTPUT[1] = 0;
//				LED_OUTPUT[2] = 1;
			end
	end	
	
	// Dc = 9.04761, 5.1
	// Freq: 47.610947 Hz
		// Check for 95,000 and 50,500
	// Freq: 1 Hz
		// Check for 95,000 and 50,500
	
	always @(posedge CLOCK_50)
	begin	
		// We have stopped counting.
	//	if(CountValue == )
		if(SysClock_Enabler == 0)
		begin
			if(CountValue  == 50499)
				begin
					ON_MODE = 0;
					//Clear = 1;// Clear the count, because  when we start counting again,
								// we want to reach the value of 50,500 or 95000. If we do not clear	
								// counter will keep counting up, reaching 50 million!
				end
			else if(CountValue == 94500)	// If cycle count is 950,000
			 begin
				DEBUG_OUTPUT = ~DEBUG_OUTPUT; 
				Clear = 1;
				ON_MODE = 1;
			 end		
		end
		else
		begin
			Clear = 0;	// Don't reset the counter.
		end
	end
//		 	LED_OUTPUT[1] = 1;
//			LED_OUTPUT[2]   = 0;
		//	DEBUG_OUTPUT = 1;
	//		LED_OUTPUT[0] = 1;
	//		Clear = 1;
//		end
	//	else
	//	 begin
	
	//		Enabler = 0;
	//	 LED_OUTPUT[1] = 0;
	//		LED_OUTPUT[2] = 1;
		//	DEBUG_OUTPUT = 0;
		
    	//   LED_OUTPUT[0]= 0;
		//   Clear = 0;
//		end
//	end
	assign START = 0;
//		Altera_Counter altera_counter (Enabler, CLOCK_50, 0, CountValue);
	PWMCounter altera_counter (SysClock_Enabler,CLOCK_50, Clear, CountValue);
//	Altera_Counter second_counter ( CLOCK_50,Enabler, 0, TEMP_COUNT);
//	assign LED_OUTPUT[0] = TEMP_COUNT[0];
//	assign LED_OUTPUT[1] = TEMP_COUNT[1];
//	assign LED_OUTPUT[2] = TEMP_COUNT[2];
	//	BCD7seg (CountValue, HEX0);
endmodule

*/