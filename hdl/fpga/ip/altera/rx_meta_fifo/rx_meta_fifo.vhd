-- megafunction wizard: %FIFO%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: dcfifo_mixed_widths 

-- ============================================================
-- File Name: rx_meta_fifo.vhd
-- Megafunction Name(s):
-- 			dcfifo_mixed_widths
--
-- Simulation Library Files(s):
-- 			
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 17.0.0 Build 595 04/25/2017 SJ Lite Edition
-- ************************************************************


--Copyright (C) 2017  Intel Corporation. All rights reserved.
--Your use of Intel Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Intel Program License 
--Subscription Agreement, the Intel Quartus Prime License Agreement,
--the Intel MegaCore Function License Agreement, or other 
--applicable license agreement, including, without limitation, 
--that your use is for the sole purpose of programming logic 
--devices manufactured by Intel and sold by Intel or its 
--authorized distributors.  Please refer to the applicable 
--agreement for further details.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY rx_meta_fifo IS
	PORT
	(
		aclr		: IN STD_LOGIC  := '0';
		data		: IN STD_LOGIC_VECTOR (127 DOWNTO 0);
		rdclk		: IN STD_LOGIC ;
		rdreq		: IN STD_LOGIC ;
		wrclk		: IN STD_LOGIC ;
		wrreq		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		rdempty		: OUT STD_LOGIC ;
		rdfull		: OUT STD_LOGIC ;
		rdusedw		: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		wrempty		: OUT STD_LOGIC ;
		wrfull		: OUT STD_LOGIC ;
		wrusedw		: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
	);
END rx_meta_fifo;


ARCHITECTURE SYN OF rx_meta_fifo IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC ;
	SIGNAL sub_wire2	: STD_LOGIC ;
	SIGNAL sub_wire3	: STD_LOGIC_VECTOR (6 DOWNTO 0);
	SIGNAL sub_wire4	: STD_LOGIC ;
	SIGNAL sub_wire5	: STD_LOGIC ;
	SIGNAL sub_wire6	: STD_LOGIC_VECTOR (4 DOWNTO 0);



	COMPONENT dcfifo_mixed_widths
	GENERIC (
		intended_device_family		: STRING;
		lpm_numwords		: NATURAL;
		lpm_showahead		: STRING;
		lpm_type		: STRING;
		lpm_width		: NATURAL;
		lpm_widthu		: NATURAL;
		lpm_widthu_r		: NATURAL;
		lpm_width_r		: NATURAL;
		overflow_checking		: STRING;
		rdsync_delaypipe		: NATURAL;
		read_aclr_synch		: STRING;
		underflow_checking		: STRING;
		use_eab		: STRING;
		write_aclr_synch		: STRING;
		wrsync_delaypipe		: NATURAL
	);
	PORT (
			aclr	: IN STD_LOGIC ;
			data	: IN STD_LOGIC_VECTOR (127 DOWNTO 0);
			rdclk	: IN STD_LOGIC ;
			rdreq	: IN STD_LOGIC ;
			wrclk	: IN STD_LOGIC ;
			wrreq	: IN STD_LOGIC ;
			q	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			rdempty	: OUT STD_LOGIC ;
			rdfull	: OUT STD_LOGIC ;
			rdusedw	: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
			wrempty	: OUT STD_LOGIC ;
			wrfull	: OUT STD_LOGIC ;
			wrusedw	: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	q    <= sub_wire0(31 DOWNTO 0);
	rdempty    <= sub_wire1;
	rdfull    <= sub_wire2;
	rdusedw    <= sub_wire3(6 DOWNTO 0);
	wrempty    <= sub_wire4;
	wrfull    <= sub_wire5;
	wrusedw    <= sub_wire6(4 DOWNTO 0);

	dcfifo_mixed_widths_component : dcfifo_mixed_widths
	GENERIC MAP (
		intended_device_family => "Cyclone IV E",
		lpm_numwords => 32,
		lpm_showahead => "ON",
		lpm_type => "dcfifo_mixed_widths",
		lpm_width => 128,
		lpm_widthu => 5,
		lpm_widthu_r => 7,
		lpm_width_r => 32,
		overflow_checking => "OFF",
		rdsync_delaypipe => 5,
		read_aclr_synch => "ON",
		underflow_checking => "OFF",
		use_eab => "ON",
		write_aclr_synch => "ON",
		wrsync_delaypipe => 5
	)
	PORT MAP (
		aclr => aclr,
		data => data,
		rdclk => rdclk,
		rdreq => rdreq,
		wrclk => wrclk,
		wrreq => wrreq,
		q => sub_wire0,
		rdempty => sub_wire1,
		rdfull => sub_wire2,
		rdusedw => sub_wire3,
		wrempty => sub_wire4,
		wrfull => sub_wire5,
		wrusedw => sub_wire6
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: AlmostEmpty NUMERIC "0"
-- Retrieval info: PRIVATE: AlmostEmptyThr NUMERIC "-1"
-- Retrieval info: PRIVATE: AlmostFull NUMERIC "0"
-- Retrieval info: PRIVATE: AlmostFullThr NUMERIC "-1"
-- Retrieval info: PRIVATE: CLOCKS_ARE_SYNCHRONIZED NUMERIC "0"
-- Retrieval info: PRIVATE: Clock NUMERIC "4"
-- Retrieval info: PRIVATE: Depth NUMERIC "32"
-- Retrieval info: PRIVATE: Empty NUMERIC "1"
-- Retrieval info: PRIVATE: Full NUMERIC "1"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
-- Retrieval info: PRIVATE: LE_BasedFIFO NUMERIC "0"
-- Retrieval info: PRIVATE: LegacyRREQ NUMERIC "0"
-- Retrieval info: PRIVATE: MAX_DEPTH_BY_9 NUMERIC "0"
-- Retrieval info: PRIVATE: OVERFLOW_CHECKING NUMERIC "1"
-- Retrieval info: PRIVATE: Optimize NUMERIC "2"
-- Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: UNDERFLOW_CHECKING NUMERIC "1"
-- Retrieval info: PRIVATE: UsedW NUMERIC "1"
-- Retrieval info: PRIVATE: Width NUMERIC "128"
-- Retrieval info: PRIVATE: dc_aclr NUMERIC "1"
-- Retrieval info: PRIVATE: diff_widths NUMERIC "1"
-- Retrieval info: PRIVATE: msb_usedw NUMERIC "0"
-- Retrieval info: PRIVATE: output_width NUMERIC "32"
-- Retrieval info: PRIVATE: rsEmpty NUMERIC "1"
-- Retrieval info: PRIVATE: rsFull NUMERIC "1"
-- Retrieval info: PRIVATE: rsUsedW NUMERIC "1"
-- Retrieval info: PRIVATE: sc_aclr NUMERIC "0"
-- Retrieval info: PRIVATE: sc_sclr NUMERIC "0"
-- Retrieval info: PRIVATE: wsEmpty NUMERIC "1"
-- Retrieval info: PRIVATE: wsFull NUMERIC "1"
-- Retrieval info: PRIVATE: wsUsedW NUMERIC "1"
-- Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
-- Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
-- Retrieval info: CONSTANT: LPM_NUMWORDS NUMERIC "32"
-- Retrieval info: CONSTANT: LPM_SHOWAHEAD STRING "ON"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "dcfifo_mixed_widths"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "128"
-- Retrieval info: CONSTANT: LPM_WIDTHU NUMERIC "5"
-- Retrieval info: CONSTANT: LPM_WIDTHU_R NUMERIC "7"
-- Retrieval info: CONSTANT: LPM_WIDTH_R NUMERIC "32"
-- Retrieval info: CONSTANT: OVERFLOW_CHECKING STRING "OFF"
-- Retrieval info: CONSTANT: RDSYNC_DELAYPIPE NUMERIC "5"
-- Retrieval info: CONSTANT: READ_ACLR_SYNCH STRING "ON"
-- Retrieval info: CONSTANT: UNDERFLOW_CHECKING STRING "OFF"
-- Retrieval info: CONSTANT: USE_EAB STRING "ON"
-- Retrieval info: CONSTANT: WRITE_ACLR_SYNCH STRING "ON"
-- Retrieval info: CONSTANT: WRSYNC_DELAYPIPE NUMERIC "5"
-- Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT GND "aclr"
-- Retrieval info: USED_PORT: data 0 0 128 0 INPUT NODEFVAL "data[127..0]"
-- Retrieval info: USED_PORT: q 0 0 32 0 OUTPUT NODEFVAL "q[31..0]"
-- Retrieval info: USED_PORT: rdclk 0 0 0 0 INPUT NODEFVAL "rdclk"
-- Retrieval info: USED_PORT: rdempty 0 0 0 0 OUTPUT NODEFVAL "rdempty"
-- Retrieval info: USED_PORT: rdfull 0 0 0 0 OUTPUT NODEFVAL "rdfull"
-- Retrieval info: USED_PORT: rdreq 0 0 0 0 INPUT NODEFVAL "rdreq"
-- Retrieval info: USED_PORT: rdusedw 0 0 7 0 OUTPUT NODEFVAL "rdusedw[6..0]"
-- Retrieval info: USED_PORT: wrclk 0 0 0 0 INPUT NODEFVAL "wrclk"
-- Retrieval info: USED_PORT: wrempty 0 0 0 0 OUTPUT NODEFVAL "wrempty"
-- Retrieval info: USED_PORT: wrfull 0 0 0 0 OUTPUT NODEFVAL "wrfull"
-- Retrieval info: USED_PORT: wrreq 0 0 0 0 INPUT NODEFVAL "wrreq"
-- Retrieval info: USED_PORT: wrusedw 0 0 5 0 OUTPUT NODEFVAL "wrusedw[4..0]"
-- Retrieval info: CONNECT: @aclr 0 0 0 0 aclr 0 0 0 0
-- Retrieval info: CONNECT: @data 0 0 128 0 data 0 0 128 0
-- Retrieval info: CONNECT: @rdclk 0 0 0 0 rdclk 0 0 0 0
-- Retrieval info: CONNECT: @rdreq 0 0 0 0 rdreq 0 0 0 0
-- Retrieval info: CONNECT: @wrclk 0 0 0 0 wrclk 0 0 0 0
-- Retrieval info: CONNECT: @wrreq 0 0 0 0 wrreq 0 0 0 0
-- Retrieval info: CONNECT: q 0 0 32 0 @q 0 0 32 0
-- Retrieval info: CONNECT: rdempty 0 0 0 0 @rdempty 0 0 0 0
-- Retrieval info: CONNECT: rdfull 0 0 0 0 @rdfull 0 0 0 0
-- Retrieval info: CONNECT: rdusedw 0 0 7 0 @rdusedw 0 0 7 0
-- Retrieval info: CONNECT: wrempty 0 0 0 0 @wrempty 0 0 0 0
-- Retrieval info: CONNECT: wrfull 0 0 0 0 @wrfull 0 0 0 0
-- Retrieval info: CONNECT: wrusedw 0 0 5 0 @wrusedw 0 0 5 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL rx_meta_fifo.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rx_meta_fifo.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rx_meta_fifo.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rx_meta_fifo.bsf FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rx_meta_fifo_inst.vhd TRUE
