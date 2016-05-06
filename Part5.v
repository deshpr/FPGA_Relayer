
module Part5 (CLOCK_50, 
					LED, 
					AUTONOMOUS, 
					CRUISE_CONTROL,
					SD_Rudder,  
					SD_Elevator, 
					SD_Aileron,
					SD_Throttle, 
					SD_Pan,  
					SD_Tilt, 
					Rx_Rudder, 
					Rx_Elevator, 
					Rx_Aileron, 
					Rx_Throttle, 
					Rudder, 
					Elevator, 
					Aileron, 
					Throttle, 
					Pan, 
					Tilt, 
					 RPI_Req_CRUISE,
					 RPI_Ack_CRUISE,
					 RPI_Req_AUTONOMOUS,
					 RPI_Ack_AUTONOMOUS,
					 SELECT, 
					 RPI_Rx,
					 RPI_Tx,
					 Xbee_Rx,
					 Xbee_Tx,
					 GPS_Rx,
					 GPS_Tx		 
				);
				
	input SD_Rudder, // Servo Driver Rudder
			SD_Elevator, // Servo Driver Eelevator
			SD_Aileron,  // Servo Driver Aileron
			SD_Throttle, // Servo Driver Throttle
			SD_Pan, // Servo Driver Pan
			SD_Tilt, // Servo Driver Tilt
			Rx_Rudder, // Receiver Rudder
			Rx_Elevator, // Receiver Elevator
			Rx_Aileron, // Receiver Aileron
			Rx_Throttle, // Receover Throttle
			RPI_Ack_CRUISE,
			RPI_Ack_AUTONOMOUS;
			
	output Rudder, //  Rudder Output
			Elevator, // Elevator Output
			Aileron, // Aileron Output
			Throttle, //  Throttle Output
			Pan, // Pan Output
			Tilt, // Tilt Output
			RPI_Req_CRUISE, // Request for Cruise Control to Raspberry PI
			RPI_Req_AUTONOMOUS; //  Request for Autonomous Mode  to Raspberry PI
		
			


	input  [0:0] CLOCK_50; // 50 MHx Clock Signal 
	input  [0:0] AUTONOMOUS; // Autonomous signal input from receiver
	input [0:0] CRUISE_CONTROL; // Cruise Control signal input from the receiver
	output [6:0] LED; // LED's to output current mode (helps with debugging)
 


	
	input SELECT, // The Select input for switching between Xbee and GPS for UART communication.
			RPI_Tx,  // Tx pin from Raspberry PI
			Xbee_Tx,  // Tx pin from the Xbee
			GPS_Tx;   // Tx pin from the GPS 
	output RPI_Rx,	// Rx pin of the Raspberry PI 
			Xbee_Rx,  // Rx pin of the Xbee
			GPS_Rx;  // Rx of GPS
	

	// Registers to indicate what the current mode of operation  is.
	reg CRUISE_CONTROL_MODE;
	reg AUTONOMOUS_MODE;
	
	// Switch modes only when PI has acknowledged such a change.
	
	always @(posedge CLOCK_50)
	begin
		if(RPI_Req_CRUISE ~^ RPI_Ack_CRUISE)
		begin
			CRUISE_CONTROL_MODE = RPI_Ack_CRUISE;
		end
		if(RPI_Req_AUTONOMOUS ~^ RPI_Ack_AUTONOMOUS)
		begin
			AUTONOMOUS_MODE = RPI_Ack_AUTONOMOUS;
		end
	end

	// Display output onto LED's for debugging.
	assign LED[2] = RPI_Ack_AUTONOMOUS;
	assign LED[3] = RPI_Ack_CRUISE;
	assign LED[4] = (RPI_Req_AUTONOMOUS ~^ RPI_Ack_AUTONOMOUS);
	assign LED[5] = (RPI_Req_CRUISE ~^ RPI_Ack_CRUISE);
	assign Clock_Pulse = CLOCK_50;

	assign SD_Rudder_Output = AUTONOMOUS;
	assign Rx_Rudder_Output = CRUISE_CONTROL;
	
	//  Try not to make everything sequential, helps
	//  reduce the delay. 
	//  Implement logic expressions. 
	// Logic Expressions derived from truth table.	
	assign Rudder = (~AUTONOMOUS_MODE & ~CRUISE_CONTROL_MODE & Rx_Rudder) 
							| (SD_Rudder & (AUTONOMOUS_MODE|CRUISE_CONTROL_MODE));
							
	// Elevator and Aileron have the same expression.
	assign Aileron = (~AUTONOMOUS_MODE & Rx_Aileron) | (AUTONOMOUS_MODE & SD_Aileron);
	
	assign Elevator = (~AUTONOMOUS_MODE & Rx_Aileron) | (AUTONOMOUS_MODE & SD_Aileron);
	assign Throttle = (~AUTONOMOUS_MODE & ~CRUISE_CONTROL_MODE & Rx_Throttle)
								 | (~AUTONOMOUS_MODE & CRUISE_CONTROL_MODE & SD_Throttle)
								  | (AUTONOMOUS_MODE & SD_Throttle);
	
	// Pan and Tilt have the same expression.
	assign Pan = (CRUISE_CONTROL_MODE & Rx_Rudder) | (~CRUISE_CONTROL_MODE & SD_Pan);
	assign Tilt =  (CRUISE_CONTROL_MODE & Rx_Rudder) | (~CRUISE_CONTROL_MODE & SD_Pan);
	
	SignalDetector signal_detector_autonomous_control (CLOCK_50, AUTONOMOUS, 
			LED[0]);
				
		/*	
	SignalDetector signal_detector_cruise_control (CLOCK_50, CRUISE_CONTROL, 
			DEBUG_OUTPUT, LED[1], DEBUG_OUTPUT2,DEBUG_OUTPUT3,
				DEBUG_OUTPUT4);	
				WORK
	 */
		
	SignalDetector signal_detector_cruise_control (CLOCK_50, CRUISE_CONTROL, 
		LED[1]);		
	
	
   UART_Switch switch_Xbee_Gps (SELECT, RPI_Tx,RPI_Rx, Xbee_Tx, Xbee_Rx, GPS_Tx, GPS_Rx);
	
	assign RPI_Req_AUTONOMOUS =LED[0];
	assign RPI_Req_CRUISE = LED[1];
			
endmodule