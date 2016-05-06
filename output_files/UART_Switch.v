module UART_Switch(
		S, 
		RPI_Tx,
		RPI_Rx,
		Xbee_Tx,
		Xbee_Rx,
		GPS_Tx,
		GPS_Rx
				);
	
	// All Tx's are inputs.....
	input [0:0] RPI_Tx, 	Xbee_Tx, GPS_Tx;
	// Connect these outputs to these pins....
	output [0:0] RPI_Rx, Xbee_Rx, GPS_Rx;
	input [0:0] S;
	
	assign  RPI_Rx = ( S & Xbee_Tx) | ( ~S & GPS_Tx);
	assign Xbee_Rx = ( S & RPI_Tx); // RPI_Tx or 0 based on S
	assign GPS_Rx = ( ~S & RPI_Tx); // RPI_Tx or 0 based on S
				

endmodule
