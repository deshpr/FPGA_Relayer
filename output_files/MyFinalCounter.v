module MyFinalCounter (CLOCK_50,AUX_INPUT, DEBUG_OUTPUT, 
			LED_OUTPUT, ON_MODE, START, SysClock_Enabler, Clear, DEBUG_OUTPUT2,
				DEBUG_OUTPUT3);	
		
		input [0:0] CLOCK_50;
		wire [25:0] CountValue;
		reg [0:0] Enabler;
		output reg [0:0] ON_MODE;
		input [0:0] AUX_INPUT;	// input from the signal generator, or AUX input
		output reg Clear;
		output[0:0] START;
		wire [2:0] TEMP_COUNT; 
		output reg [0:0] DEBUG_OUTPUT;
		output reg [3:0] LED_OUTPUT;		
		output reg [0:0] SysClock_Enabler;
		output reg [0:0] DEBUG_OUTPUT2;
		output reg [0:0] DEBUG_OUTPUT3;
		
		reg checker_count = 0;
		reg start_checker_count = 0;
		reg determine_count = 0;
		reg count_one = 50500;
		reg count_two = 95000;
		reg to_check = 0;
		reg trials = 20;
		reg count_so_far = 0;
		reg begin_determining = 0;
		
			reg  [25:0]count = 0;
	reg [3:0]times_to_check = 5;
	reg start_count = 0;
	reg input_is_off = 1;
		initial
	begin
		Clear = 1;
		checker_count = 0;
		Enabler = 0;
		SysClock_Enabler = 0;
		//START  = 0;
		DEBUG_OUTPUT = 0;
		DEBUG_OUTPUT2 = 0;
		DEBUG_OUTPUT3 = 0;
		ON_MODE = 0;
		determine_count = 0;
		LED_OUTPUT[0] = 0;
		LED_OUTPUT[1] = 0;
	//	OFF_MODE = 0;
	end

	
	
	always @(posedge CLOCK_50)
	begin
		if(begin_determining  == 1)
		begin
			if(AUX_INPUT == 0)
			begin
			   DEBUG_OUTPUT = 0; // 
		//		determine_count = 1;
				DEBUG_OUTPUT3 = 1;
		//		begin_determining = 0;			
		//		determine_count = 0;
		//		begin_determining = 0;
			end
		end
	
	  if(determine_count == 0  && begin_determining == 0)
	  begin
			// code to chose the mode.
			if(AUX_INPUT == 1  && start_count == 0)
			begin
				start_count = 1;
			end
			if(start_count == 1)
			begin
				count = count + 1;
				//start_count = 0;
			end
			if(count == 75000)
			begin
				start_count = 0;
				DEBUG_OUTPUT = 1;
				// Now figure out what to check at that point.
				if(AUX_INPUT == 1)
				begin
					to_check = 1;
				end
				else
				begin
					to_check = 0;
				end
				count = 0; // reset.
				determine_count = 0;
				begin_determining = 1;
			end
	  end
	  /*
	  else
	  
	  begin
	     if(determine_count == 1 && AUX_INPUT == 1)
		  begin
		  DEBUG_OUTPUT2 = 1;
		 	if(AUX_INPUT == 1  && start_count == 0)
			begin
			//	DEBUG_OUTPUT = 1;
				start_count = 1;
			end
			if(start_count == 1)
			begin
				count = count + 1;
			//	start_count = 0;
			end
			if(count == 75000)
			begin
				DEBUG_OUTPUT3 = 1;
				count = 0;
				start_count = 0;
				DEBUG_OUTPUT = 0;
				if(AUX_INPUT == to_check) // what we expected...
				begin
					// Again, we need to  skip the remaining positive edges of the AUX_INPUT.
					begin_determining = 1;
					determine_count = 0;
					times_to_check = times_to_check - 1;
					if(times_to_check == 0)
					begin
						// We have arrived at a  mode. Display this as an output.
				//		DEBUG_OUTPUT = 1;
						if(to_check == 1)
						begin
							LED_OUTPUT[0] = 1;
							LED_OUTPUT[1] = 0;
						end
						else
						begin
							LED_OUTPUT[0] = 0;
							LED_OUTPUT[1] = 1;
						end
						DEBUG_OUTPUT2 = 0;
						times_to_check = 5;
						begin_determining = 0;
						count = 0;
						start_count = 0;
						determine_count = 0;
					end
				end
				else
				begin
					times_to_check = 2;
					determine_count = 0;
					begin_determining = 0;
					count = 0;
					start_count = 0;
				end
			end
		 end
	  end
	  */
	end

	
	
	/*
	
	always @(posedge CLOCK_50)
	begin
	   if(start_count == 1)
		begin
			count = count + 1;
		end
		if(count == 75000)
			begin
				determine_count = 1;
				DEBUG_OUTPUT = 1; 
				start_count = 0;
				count = 0;
			end

		if(AUX_INPUT == 1 && input_is_off == 1)//  the input was turned  off...
			begin
				input_is_off = 0;
				start_count = 1;
				DEBUG_OUTPUT = 0;
				count = count + 1; 
		end
	   if(AUX_INPUT == 1 &&  start_count == 0)
		 input_is_off = 0;
	/*		if(AUX_INPUT)
		begin
			
			count = count + 1;
//			DEBUG_OUTPUT = 1;
		end
		begin
			count = 0;
//			DEBUG_OUTPUT = 0;
		end
		
		DEBUG_OUTPUT = AUX_INPUT;
		
	end
	
	/*always @(posedge CLOCK_50)
	begin
	count = count + 1;
	
//	if(AUX_INPUT) // start counting....
//			begin
		//		DEBUG_OUTPUT = 1;
	//			Clear = 0;
	//		end
	if(count == 26'd1050000)
		begin
			DEBUG_OUTPUT = 0;//  finish counting....
//			Clear = 1;
			count = 26'd0;
		end
	else
	begin
		DEBUG_OUTPUT = 1K;
	end
	end
			
/*	
	always @(posedge CLOCK_50)
	begin
		

		if(CountValue == 1049999) //  the length of the wave
		begin
			DEBUG_OUTPUT = ~DEBUG_OUTPUT;
//			Clear = 1;
		end
	end
	
	
	/*
	always @(CountValue)
	begin
		if(determine_count
		if(CountValue  == 75000)
		begin
			determine_count = 1; // start to check for this count to confirm.
			if(AUX_INPUT)
			begin
				// this is mode 1.
				to_check = count_one;
			end
			else
			begin
	
				to_check  = count_two;
			end
		end
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
			if(CountValue == 75000) // check if input is zero or a one.
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
//	AlterCounter my_counter(CLOCK_50, Clear, CountValue);
//	AlteraInputCounter my_counter (CLOCK_50, Clear, CountValue);
//	PWMCounter altera_counter (SysClock_Enabler,CLOCK_50, 0, CountValue);
	
endmodule