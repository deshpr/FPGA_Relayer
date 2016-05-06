
module Part5 (CLOCK_50, 
					LED, 
					AUTONOMOUS, 
					CRUISE_CONTROL,
					DEBUG_OUTPUT, AUX_OUTPUT, AUX_OUTPUT_TWO,
					Clock_Pulse, DEBUG_OUTPUT2, DEBUG_OUTPUT3,
					DEBUG_OUTPUT4,
					DEBUG_OUTPUT_A,  DEBUG_OUTPUT_A2, DEBUG_OUTPUT_A3, DEBUG_OUTPUT_A4,
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
				 SD_Rudder_Output,
				 Rx_Rudder_Output,
				 RPI_Req_CRUISE,
				 RPI_Ack_CRUISE,
				 RPI_Req_AUTONOMOUS,
				 RPI_Ack_AUTONOMOUS,
				 OUTPUT_SHOW,
				 SELECT, 
				 RPI_Rx,
				 RPI_Tx,
				 Xbee_Rx,
				 Xbee_Tx,
				 GPS_Rx,
				 GPS_Tx		 
				);
				
	input SD_Rudder, 
			SD_Elevator,
			SD_Aileron,
			SD_Throttle,
			SD_Pan, 
			SD_Tilt,
			Rx_Rudder,
			Rx_Elevator,
			Rx_Aileron,
			Rx_Throttle,
			RPI_Ack_CRUISE,
			RPI_Ack_AUTONOMOUS;
			
	output Rudder,
			Elevator,
			Aileron,
			Throttle,
			Pan,
			Tilt,
			RPI_Req_CRUISE,
			RPI_Req_AUTONOMOUS,
			OUTPUT_SHOW;
			
	// For debugging
	output SD_Rudder_Output;
	output Rx_Rudder_Output;
  
				
/*  Define the Inputs */
	input  [0:0] CLOCK_50;
	//output [0:0] SIGNAL_CHANGE;
	input  [0:0] AUTONOMOUS;
	input [0:0] CRUISE_CONTROL;
	output [0:0] DEBUG_OUTPUT_A;
	output [0:0] DEBUG_OUTPUT_A2;
	output [0:0] DEBUG_OUTPUT_A3;
	output [0:0] DEBUG_OUTPUT_A4;
	output [0:0] AUX_OUTPUT;
	output [0:0] AUX_OUTPUT_TWO;
	output [0:0] DEBUG_OUTPUT2;
	output [6:0] LED;
	output [0:0] DEBUG_OUTPUT;
	output [0:0] DEBUG_OUTPUT3;
	output [0:0] DEBUG_OUTPUT4;
	wire   [2:0] S;
	output [0:0] Clock_Pulse;

	
	input SELECT, RPI_Tx, Xbee_Tx, GPS_Tx;
	output RPI_Rx, Xbee_Rx, GPS_Rx;
	
	assign OUTPUT_SHOW = 1;

	// Notify Raspberry Pi regarding whether a certain mode is ON or OFF.
	// Set up mode of operation based on Acknowledgement from Raspberry Pi.
	// Implement XNOR. Only if both are equal is the result true and we set
	// the appropriate mode. 
	wire CRUISE_CONTROL_MODE = (RPI_Req_CRUISE ~^ RPI_Ack_CRUISE) & RPI_Req_CRUISE;
	wire AUTONOMOUS_MODE = (RPI_Req_AUTONOMOUS ~^ RPI_Ack_AUTONOMOUS) & RPI_Req_AUTONOMOUS;
	
	assign LED[2] = RPI_Ack_AUTONOMOUS;
	assign LED[3] = RPI_Ack_CRUISE;
	assign LED[4] = (RPI_Req_AUTONOMOUS ~^ RPI_Ack_AUTONOMOUS);
	assign LED[5] = (RPI_Req_CRUISE ~^ RPI_Ack_CRUISE);
	assign Clock_Pulse = CLOCK_50;
	assign AUX_OUTPUT = AUTONOMOUS;
	assign AUX_OUTPUT_TWO = CRUISE_CONTROL;
	assign SD_Rudder_Output = AUTONOMOUS;
	assign Rx_Rudder_Output = CRUISE_CONTROL;
	
	//  Try not to make everything sequential, helps
	//  reduce the delay. 
	//  Implement logic expressions. 
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
			DEBUG_OUTPUT, LED[0], DEBUG_OUTPUT2, DEBUG_OUTPUT3,
				DEBUG_OUTPUT4);
				
		/*	
	SignalDetector signal_detector_cruise_control (CLOCK_50, CRUISE_CONTROL, 
			DEBUG_OUTPUT, LED[1], DEBUG_OUTPUT2,DEBUG_OUTPUT3,
				DEBUG_OUTPUT4);	
	 */
		
	SignalDetector signal_detector_cruise_control (CLOCK_50, CRUISE_CONTROL, 
			DEBUG_OUTPUT_A, LED[1], DEBUG_OUTPUT_A2,DEBUG_OUTPUT_A3,
				DEBUG_OUTPUT_A4);		
	
	
   UART_Switch switch_Xbee_Gps (S, RPI_Tx,RPI_Rx, Xbee_Tx, Xbee_Rx, GPS_Tx, GPS_Rx);
	
	
	assign RPI_Req_AUTONOMOUS =LED[0];
	assign RPI_Req_CRUISE = LED[1];
			
endmodule