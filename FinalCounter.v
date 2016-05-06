module FinalCounter (CLOCK_50,AUX_INPUT, DEBUG_OUTPUT, 
			LED_OUTPUT, ON_MODE, START, SysClock_Enabler, Clear);	
			
		input [0:0] CLOCK_50;

		wire [25:0] CountValue;
		reg [0:0] Enabler;
		output reg [0:0] ON_MODE;
		input [0:0] AUX_INPUT;	// input from the signal generator, or AUX input
		output reg Clear;
		output[0:0] START;
		wire [2:0] TEMP_COUNT; 
		output reg [0:0] DEBUG_OUTPUT;
		output [3:0] LED_OUTPUT;		
		output reg [0:0] SysClock_Enabler;
		
		reg checker_count = 0;
		reg start_checker_count = 0;
		reg determine_count = 0;
		reg count_one = 50500;
		reg count_two = 95000;
		reg to_check = 0;
		reg trials = 20;
		reg count_so_far = 0;
		
		initial
	begin
		Clear = 0;
		checker_count = 0;
		Enabler = 0;
		SysClock_Enabler = 0;
		//START  = 0;
		DEBUG_OUTPUT = 0;
		ON_MODE = 0;
		determine_count = 0;
	//	OFF_MODE = 0;
	end
	


	always @(AUX_INPUT)
	begin
	   if(AUX_INPUT)
		begin
			SysClock_Enabler = 1; // start counting
			DEBUG_OUTPUT = 0;
		end
		else
		begin
		count_so_far = CountValue;
		if(determine_count == 0)
		begin
			if(CountValue >= count_one - 1000)
			begin
					to_check = count_one;				
					DEBUG_OUTPUT = 1;
			end
			else if(CountValue  == 95000)
			begin
					to_check = count_two;
					DEBUG_OUTPUT = 1;
			end
//			else
//			begin
				// counted to something garbage....
				// stay in the same mode, do nothing.
//			end
		end
		else
		begin
			if(CountValue == to_check)
			begin
				to_check = to_check - 1;
				if(to_check <= 0)
				begin
					// set the desired mode.
					if(to_check == count_one)
						ON_MODE = 0;
					else if(to_check == count_two)
 						begin
						ON_MODE = 1;
						end
					to_check = 21;
				end
			end
			else
			begin
				// garbage count...
				// reset....
				to_check = 21;
				determine_count = 0;
			end
		end
		// Clear the count..
	//	SysClock_Enabler = 0;
	//	Clear = 1;
		end
	end
/*
	always @(negedge AUX_INPUT)
	begin
	end
	
/*
   always @(AUX_INPUT)
	begin
		if(AUX_INPUT)
		begin
			// start counting.
			SysClock_Enabler = 1;
		end
	end

	always @(posedge CLOCK_50)
	begin
		// check if count is complete.
		if(CountValue == 75000) // the intermediate value.
		begin
			if(AUX_INPUT)
			begin
				// this means it is the 1.9m/s one.
				Clear =  1;
			end
		end
	end
	*/ 
	PWMCounter altera_counter (SysClock_Enabler,CLOCK_50, Clear, CountValue);
	
endmodule