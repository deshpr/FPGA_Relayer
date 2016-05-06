	module Controller_Switch(Asd,// Aileron servo driver
								Esd, // Elevator servo driver
								Rsd, // Rudder servo driver
								Tsd, // Throttle servo driver
								Arx, // Aileron reciever
								Erx, // Elevator reciever
								Rrx, // Rudder reciever
								Trx, // Throttle reciever
								Tx,  // Tx line from Xbee
								XbGPS, // Xbee GPS switch line from RasPi.
								AUX_IN, // Flight controller / Reciever switch from DX6i
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

	initial begin
		FCRx_counter = 0;
		FCRx_switch = 1;
		FCRx_check = 1;
		FCRx_temp = 1;
		FCRx_temp_counter = 0;
		
		cc_counter = 0;
		cc_switch = 1;
		cc_check = 0;
		cc_temp = 0;☻
		cc_temp_counter = 0;
	end
	
	
	always@(Asd, Esd, Rsd, Tsd, Arx, Erx, Rrx, Trx, Tx, FCRx, FCRx_switch)
		if(FCRx_switch)begin
			A = Asd;
			E = Esd;
			R = Rsd;
			T = Tsd;
			pt_up_down = TiltSD;
			pt_left_right = PanSD;
		end else begin
			A = Arx;
			E = Erx;
			R = Rrx;
			T = Trx;
			pt_up_down = TiltSD;
			pt_left_right = PanSD;
		end
	always@(posedge CLOCK_50)
		if(FCRx) begin
			FCRx_counter = FCRx_counter + 1;
			FCRx_check = 1;
			led0 = 1'b1;
		end else begin
			
			if (FCRx_check) begin
				if (FCRx_counter < 75000) begin
					//FCRx_temp = 0;
					FCRx_switch = 0;
				end else begin
					//FCRx_temp = 1;
					FCRx_switch = 1;
				end
				FCRx_counter = 0;
				FCRx_check = 0;
			end
			/*
			if (FCRx_temp != FCRx_switch) begin
				FCRx_temp_counter = FCRx_temp_counter + 1;
				led0 = 1'b0;
				if (FCRx_temp_counter > 9000000) begin
					FCRx_switch = FCRx_temp;
					FCRx_temp_counter = 0;
				end
			end else begin
				FCRx_temp_counter = 0;
			end
			*/
		end
		
		// Cruise control
		// Do some stuff to transfer control to the pan_tilt
		// send out a high to a pin to tell the RPI to set throttle
		// and rudder. Transfer rudder and throttle from Rx to pan_tilt
	always@(posedge CLOCK_50)
		if(cc)begin
			cc_counter = cc_counter + 1;
			cc_check = 1;
		end else begin
			if (cc_check) begin
				if (cc_counter < 58000) begin
					cc_temp = 0;
				end else begin
					cc_temp = 1;
				end
				cc_counter = 0;
				cc_check = 0;
			end
			if (cc_temp != cc_switch) begin
				cc_temp_counter = cc_temp_counter + 1;
				if (cc_temp_counter > 5000000) begin
					cc_switch = cc_temp;
					cc_temp_counter = 0;
				end
			end else begin
				cc_temp_counter = 0;
			end
		end
endmodule 