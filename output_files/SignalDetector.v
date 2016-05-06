module SignalDetector(
		   CLOCK_50,
			AUX_INPUT, 
			LED_OUTPUT);	
		
		input [0:0] CLOCK_50; // 50Mhz Clock Signal
		wire [25:0] CountValue; // The count value
		reg [0:0] Enabler; 
		input [0:0] AUX_INPUT;	// input from the signal generator, or AUX input
		wire [2:0] TEMP_COUNT; 
		output reg [0:0] LED_OUTPUT;	
		
		
		reg  back_to_mode_zero= 0;
		reg mode_to_operate = 0; //  0 for find count, 1 for checking for it.
		reg determine_count = 0;
		reg to_check = 0;
		reg count_so_far = 0;
		reg begin_determining = 0;
		
			reg  [25:0]count = 0;
	reg [3:0]times_to_check = 5;
	reg start_count = 0;
	reg input_is_off = 1;
	reg [4:0]test_count = 0;
		initial
	begin
		test_count = 0;
		Enabler = 0;
		determine_count = 0;
	end

	always @(posedge CLOCK_50)
	begin
		if(begin_determining  == 1)
		begin
			if(AUX_INPUT == 0)
			begin
				if(back_to_mode_zero == 1)
					begin
					determine_count = 0;
					begin_determining = 0;
					back_to_mode_zero = 0; // reset
					end
				else
				begin
	//C				DEBUG_OUTPUT = 0; //
					determine_count = 1;
					begin_determining = 0;
					count = 0;
					start_count = 0;
				end
			end
		end
		

		
	  if(determine_count == 0  && begin_determining == 0)
	  begin
			 
			 mode_to_operate = 0;
		//	DEBUG_OUTPUT3 = 1;
			// code to chose the mode.
			if(AUX_INPUT == 1  && start_count == 0)
			begin
				test_count = test_count + 1;
				if(test_count == 4)
					begin
						test_count = 0;
					end
//C			  DEBUG_OUTPUT = 1;
				start_count = 1;
			end
			if(start_count == 1  /*&& AUX_INPUT  == 1*/)
			begin
				count = count + 1;
				//start_count = 0;
			end
			if(count == 75000)
			begin
//C				DEBUG_OUTPUT = 0;
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
				start_count = 0;
				begin_determining = 1;
			end
	  end
	  else
	  begin
	     if(determine_count == 1)
		  begin
		  mode_to_operate = 1;
		 	if(AUX_INPUT == 1  && start_count == 0)
			begin
//C			DEBUG_OUTPUT2 = 1;
				start_count = 1;
			end
			if(start_count == 1)
			begin
				count = count + 1;
			end
			if(count == 75000)
			begin
			//DEBUG_OUTPUT3 = 1;
				count = 0;
				start_count = 0;
//C				DEBUG_OUTPUT = 0;
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
//							LED_OUTPUT[1] = 0;
						end
						else
						begin
							LED_OUTPUT[0] = 0;
//							LED_OUTPUT[1] = 1;
						end
//C						DEBUG_OUTPUT2 = 0;
						times_to_check = 5;
						begin_determining = 1; // Skip the remaining positive edge of AUX_INPUT.
					//	begin_determining = 0;
						count = 0;
						start_count = 0;
						back_to_mode_zero = 1; 
					//	determine_count = 0;
					end
				end
				else
				begin
					times_to_check = 5;
					back_to_mode_zero = 1; 
				//	determine_count = 0;
				//	begin_determining = 0;
					begin_determining = 1; // Skip the remaining positive edge of AUX_INPUT.
					count = 0;
					start_count = 0;
				end
			end
		 end
	  end
	end
	
endmodule