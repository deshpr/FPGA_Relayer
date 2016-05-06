module UART_Switch(
	S, 
	RPI_Rx,
	RPI_Tx,
	Xbee_Rx,
	Xbee_Tx,
	GPS_Rx,
	GPS_Tx
);


	input [0:0] S, RPI_Tx, Xbee_Tx, GPS_Tx;
	// Connect these outputs to these pins......
	output [0:0] RPI_Rx, Xbee_Rx, GPS_Rx;
	
	assign RPI_Rx  = (S & Xbee_Tx) | (~S & GPS_Tx);
	assign Xbee_Rx = (S & RPI_Tx);
	assign GPS_Rx = (S & GPS_Tx);

endmodule