	module Part5(Asd,// Aileron servo driver
								Esd, // Elevator servo driver
								Rsd, // Rudder servo driver
								Tsd, // Throttle servo driver
								Arx, // Aileron reciever
								Erx, // Elevator reciever
								Rrx, // Rudder reciever
								Trx, // Throttle reciever
								Tx,  // Tx line from Xbee
								XbGPS, // Xbee GPS switch line from RasPi.
								AUX_INPUT, // Flight controller / Reciever switch from DX6i
								A, // Aileron output to servo
								E, // Elevator output to servo
								R, // Rudder output to servo
								T, // Throuttle output to speed controller
								Rx, // Rx line from Xbee
								led0, //LED for debugging
								CLOCK_50, // CloCK_
								pt_up_down, // Pan/Tilt Up/Down
								pt_left_right,// Pan/Tilt Left/Right
								PanSD, //Pan control from Servo Driver
								TiltSD, // Tilt control from servo driver
								cc_request, // Cruise control request to RasPi
								cc); // Cruise Control switch from DX6i
  
	input [0:0] AUX_INPUT;							
	input Asd, Esd, Rsd, Tsd, Arx, Erx, Rrx, Trx, Tx, PanSD, TiltSD, XbGPS, FCRx, CLOCK_50, cc;
	output A, E, R, T, Rx, pt_up_down, pt_left_right, cc_request, led0;
	reg A, E, R, T, Rx;
	reg led0;
	integer FCRx_counter;
	reg FCRx_check, FCRx_temp, FCRx_switch;
	reg cc_check, cc_temp, cc_switch;
	reg pt_up_down, pt_left_right;
	reg cc_request;
	wire the_a;
	
	integer FCRx_temp_counter;
	integer cc_counter;
	integer cc_temp_counter;

	assign Clock_Pulse = CLOCK_50;
	assign AUX_OUTPUT = AUX_ONE;
	
	
	
	always @(posedge CLOCK_50)
	begin
		// Route all controls based on mode. 
		
	end
	
	
	FinishedCompleteCounter my_Counter (CLOCK_50, AUX_ONE, 
			DEBUG_OUTPUT, LED[0], ON_MODE, START, Sys_Enabler, Clear, DEBUG_OUTPUT2, DEBUG_OUTPUT3,
				DEBUG_OUTPUT4, SIGNAL_CHANGE);
   
	FinishedCompleteCounter my_Counter (CLOCK_50, AUX_ONE, 
			DEBUG_OUTPUT, LED, ON_MODE, START, Sys_Enabler, Clear, DEBUG_OUTPUT2, DEBUG_OUTPUT3,
				DEBUG_OUTPUT4, SIGNAL_CHANGE);
	
	
	
endmodule 