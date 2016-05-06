// megafunction wizard: %LPM_COUNTER%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: LPM_COUNTER 

// ============================================================
// File Name: AlteraInputCounter.v
// Megafunction Name(s):
// 			LPM_COUNTER
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 13.0.1 Build 232 06/12/2013 SP 1 SJ Web Edition
// ************************************************************


//Copyright (C) 1991-2013 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module AlteraInputCounter (
	clock,
	sclr,
	q);

	input	  clock;
	input	  sclr;
	output	[20:0]  q;

	wire [20:0] sub_wire0;
	wire [20:0] q = sub_wire0[20:0];

	lpm_counter	LPM_COUNTER_component (
				.clock (clock),
				.sclr (sclr),
				.q (sub_wire0),
				.aclr (1'b0),
				.aload (1'b0),
				.aset (1'b0),
				.cin (1'b1),
				.clk_en (1'b1),
				.cnt_en (1'b1),
				.cout (),
				.data ({21{1'b0}}),
				.eq (),
				.sload (1'b0),
				.sset (1'b0),
				.updown (1'b1));
	defparam
		LPM_COUNTER_component.lpm_direction = "UP",
		LPM_COUNTER_component.lpm_modulus = 1050000,
		LPM_COUNTER_component.lpm_port_updown = "PORT_UNUSED",
		LPM_COUNTER_component.lpm_type = "LPM_COUNTER",
		LPM_COUNTER_component.lpm_width = 21;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ACLR NUMERIC "0"
// Retrieval info: PRIVATE: ALOAD NUMERIC "0"
// Retrieval info: PRIVATE: ASET NUMERIC "0"
// Retrieval info: PRIVATE: ASET_ALL1 NUMERIC "1"
// Retrieval info: PRIVATE: CLK_EN NUMERIC "0"
// Retrieval info: PRIVATE: CNT_EN NUMERIC "0"
// Retrieval info: PRIVATE: CarryIn NUMERIC "0"
// Retrieval info: PRIVATE: CarryOut NUMERIC "0"
// Retrieval info: PRIVATE: Direction NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: PRIVATE: ModulusCounter NUMERIC "1"
// Retrieval info: PRIVATE: ModulusValue NUMERIC "1050000"
// Retrieval info: PRIVATE: SCLR NUMERIC "1"
// Retrieval info: PRIVATE: SLOAD NUMERIC "0"
// Retrieval info: PRIVATE: SSET NUMERIC "0"
// Retrieval info: PRIVATE: SSET_ALL1 NUMERIC "1"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: nBit NUMERIC "21"
// Retrieval info: PRIVATE: new_diagram STRING "1"
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: CONSTANT: LPM_DIRECTION STRING "UP"
// Retrieval info: CONSTANT: LPM_MODULUS NUMERIC "1050000"
// Retrieval info: CONSTANT: LPM_PORT_UPDOWN STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_COUNTER"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "21"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: USED_PORT: q 0 0 21 0 OUTPUT NODEFVAL "q[20..0]"
// Retrieval info: USED_PORT: sclr 0 0 0 0 INPUT NODEFVAL "sclr"
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @sclr 0 0 0 0 sclr 0 0 0 0
// Retrieval info: CONNECT: q 0 0 21 0 @q 0 0 21 0
// Retrieval info: GEN_FILE: TYPE_NORMAL AlteraInputCounter.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL AlteraInputCounter.inc TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL AlteraInputCounter.cmp TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL AlteraInputCounter.bsf TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL AlteraInputCounter_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL AlteraInputCounter_bb.v TRUE
// Retrieval info: LIB_FILE: lpm
