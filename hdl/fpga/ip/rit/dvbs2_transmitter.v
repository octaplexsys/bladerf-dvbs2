// Top Level DVBS2 Transmitter Block


module dvbs2_transmitter (clock_96MHz, clock_16MHz, clock_4MHz, reset, enable, bit_in, valid_in, output_clock, output_reset, sym_i_out, sym_q_out, valid_out, error);
   // Inputs and Outputs
   input         clock_96MHz;
	input         clock_16MHz;
	input         clock_4MHz;
	input         reset;
   input         enable;
   input         bit_in;
   input         valid_in;
	input			  output_clock;
	input 		  output_reset;
   output [15:0] sym_i_out;
   output [15:0] sym_q_out;
   output        valid_out;
   output        error;
	
   // Internal Signals
   wire        bbheader_bit_out;
   wire        bbheader_valid_out;
   wire        bbheader_error;
   wire        bbscrambler_bit_out;
   wire        bbscrambler_valid_out;
   wire        bchencoder_bit_out;
   wire        bchencoder_valid_out;
   wire        bchencoder_error;
   wire        ldpcencoder_bit_out;
   wire        ldpcencoder_valid_out;
   wire        ldpcencoder_error;
   wire        interleaver_bit_out;
   wire        interleaver_valid_out;
   wire [11:0] bitmapper_sym_i_out;
   wire [11:0] bitmapper_sym_q_out;
   wire        bitmapper_valid_out;
   wire [11:0] phyframer_sym_i_out;
   wire [11:0] phyframer_sym_q_out;
   wire        phyframer_valid_out;
   wire        phyframer_error;
	wire [31:0] output_sync_sym_i_out;
   wire [31:0] output_sync_sym_q_out;
   wire        output_sync_valid_out;
   wire        output_sync_error;
	wire			fifo_switch_performed;
	wire			fifo_wr_sel;
	wire			done_out;
	wire [31:0] filter_sym_i_out;
	wire [31:0] filter_sym_q_out;
	wire filter_i_valid;
	wire filter_q_valid;
	wire [11:0] fixed_sym_i_out;
	wire [11:0] fixed_sym_q_out;
	
   // Create output error based on individual block error signals
   assign error = bbheader_error | bchencoder_error | ldpcencoder_error | phyframer_error | output_sync_error;

   // Final data output
   assign sym_i_out = {{4{fixed_sym_i_out[11]}}, fixed_sym_i_out};
   assign sym_q_out = {{4{fixed_sym_q_out[11]}}, fixed_sym_q_out};
   assign valid_out = output_sync_valid_out;

   // Instantiate BBHeader
   dvbs2_bbheader bbheader (
      .clock     (clock_16MHz),
      .reset     (reset),
      .enable    (enable),
      .bit_in    (bit_in),
      .valid_in  (valid_in),
      .bit_out   (bbheader_bit_out),
      .valid_out (bbheader_valid_out),
      .error     (bbheader_error)
   );

   // Instantiate BBScrambler
   dvbs2_bbscrambler bbscrambler (
      .clock     (clock_16MHz),
      .reset     (reset),
      .enable    (enable),
      .bit_in    (bbheader_bit_out),
      .valid_in  (bbheader_valid_out),
      .bit_out   (bbscrambler_bit_out),
      .valid_out (bbscrambler_valid_out)
   );

   // Instantiate BCH Encoder
   dvbs2_bchencoder bchencoder (
      .clock     (clock_16MHz),
      .reset     (reset),
      .enable    (enable),
      .bit_in    (bbscrambler_bit_out),
      .valid_in  (bbscrambler_valid_out),
      .bit_out   (bchencoder_bit_out),
      .valid_out (bchencoder_valid_out),
      .error     (bchencoder_error)
   );

   // Instantiate LDPC Encoder
   dvbs2_ldpcencoder ldpcencoder (
      .clock_16MHz (clock_16MHz),
      .clock_96MHz (clock_96MHz),
      .reset       (reset),
      .enable      (enable),
      .bit_in      (bchencoder_bit_out),
      .valid_in    (bchencoder_valid_out),
      .bit_out     (ldpcencoder_bit_out),
      .valid_out   (ldpcencoder_valid_out),
      .error       (ldpcencoder_error)
   );

   // Instantiate Bit Interleaveroutput_sync_sym_i_out
   dvbs2_interleaver interleaver (
      .clock     (clock_16MHz),
      .reset     (reset),
      .enable    (enable),
      .bit_in    (ldpcencoder_bit_out),
      .valid_in  (ldpcencoder_valid_out),
      .bit_out   (interleaver_bit_out),
      .valid_out (interleaver_valid_out)
   );

   // Instantiate Bit Mapper
   dvbs2_bitmapper_q11 bitmapper (
      .clock_in  (clock_16MHz),
      .reset     (reset),
      .enable    (enable),
      .bit_in    (interleaver_bit_out),
      .clock_out (clock_4MHz),
      .valid_in  (interleaver_valid_out),
      .sym_i     (bitmapper_sym_i_out),
      .sym_q     (bitmapper_sym_q_out),
      .valid_out (bitmapper_valid_out)
   );

   // Instantiate the Physical Layer Framer & Scrambler
   dvbs2_phyframer_q11 phyframer (
      .clock_in  (clock_4MHz),
      .reset     (reset),
      .enable    (enable),
      .sym_i_in  (bitmapper_sym_i_out),
      .sym_q_in  (bitmapper_sym_q_out),
      .valid_in  (bitmapper_valid_out),
		.clock_out (clock_16MHz),
		.fifo_switch_performed (fifo_switch_performed),
      .sym_i_out (phyframer_sym_i_out),
      .sym_q_out (phyframer_sym_q_out),
      .valid_out (phyframer_valid_out),
      .error     (phyframer_error),
		.done_out  	(done_out),
		.fifo_wr_sel (fifo_wr_sel)
   );
		
	// Output sync block - inserts dummy PLFRAMES
	dvbs2_output_sync output_sync (	
		.clock_in (clock_16MHz),
      .reset (reset),
		.enable (enable),
      .sym_i_in (phyframer_sym_i_out),
      .sym_q_in (phyframer_sym_q_out),
      .valid_in (phyframer_valid_out),
		.output_clock (output_clock),
		.output_reset (output_reset),
		.done_out  	(done_out),
		.fifo_wr_sel (fifo_wr_sel),
		.sym_i_out (output_sync_sym_i_out),
		.sym_q_out (output_sync_sym_q_out),
		.valid_out (output_sync_valid_out),
		.error (output_sync_error),
		.fifo_switch_performed (fifo_switch_performed)
	);
	
//	reg [31:0] output_sync_sym_i_out_mff2;
//	reg [31:0] output_sync_sym_i_out_mff1;
//	reg [31:0] output_sync_sym_q_out_mff2;
//	reg [31:0] output_sync_sym_q_out_mff1;
//	
//	always @(posedge clock_96MHz) begin
//		if (reset) begin
//			output_sync_sym_i_out_mff2 <= 32'b0;
//			output_sync_sym_i_out_mff1 <= 32'b0;
//			output_sync_sym_q_out_mff2 <= 32'b0;
//			output_sync_sym_q_out_mff1 <= 32'b0;
//		end
//		else begin
//			output_sync_sym_i_out_mff2 <= output_sync_sym_i_out_mff1;
//			output_sync_sym_i_out_mff1 <= output_sync_sym_i_out;
//			output_sync_sym_q_out_mff2 <= output_sync_sym_q_out_mff1;
//			output_sync_sym_q_out_mff1 <= output_sync_sym_q_out;
//		end
//	end
	
	fp_to_fixed i_fp_to_fixed (
		.clock (output_clock),
		.dataa (output_sync_sym_i_out),
		.result (fixed_sym_i_out)
	);
	
	fp_to_fixed q_fp_to_fixed (
		.clock (output_clock),
		.dataa (output_sync_sym_q_out),
		.result (fixed_sym_q_out)
	);
//	
//	reg [11:0] fixed_sym_i_out_mff1
//	reg [11:0] fixed_sym_q_out_mff1
//	reg [11:0] fixed_sym_i_out_reg;
//	reg [11:0] fixed_sym_q_out_reg;
//	reg found_second;
//	
//	always @(posedge output_clock) begin
//		if (output_reset) begin
//			fixed_sym_i_out_mff1 <= 12'b0;
//			fixed_sym_q_out_mff1 <= 12'b0;
//			fixed_sym_i_out_reg <= 12'b0;
//			fixed_sym_q_out_reg <= 12'b0;
//			
//			found_second <= 1'b0;
//		end
//		else begin
//			if ((output_sync_valid_out == 1'b1) & (found_second == 1'b0)) begin
//				fixed_sym_i_out_reg <= fixed_sym_i_out_mff1;
//				fixed_sym_q_out_reg <= fixed_sym_q_out_mff1;
//				found_second <= 1'b1;
//			end
//			else begin
//				found_second <= 1'b0;
//			end
//			
//			fixed_sym_i_out_mff1 <= fixed_sym_i_out;
//			fixed_sym_q_out_mff1 <= fixed_sym_q_out;
//		end
//	end
//	
//	// Filter the i symbols
//	dvb_filter i_filter (
//		.clk              (output_clock),             
//		.reset_n          (output_reset),
//		.ast_sink_data    (output_sync_sym_i_out),
//		.ast_sink_valid   (output_sync_valid_out),
//		.ast_source_data  (filter_sym_i_out),
//		.ast_source_valid (filter_i_valid),
//		.ast_sink_error (0)
//	);
//	
//	// Filter the q symbols
//	dvb_filter q_filter (
//		.clk              (output_clock),             
//		.reset_n          (output_reset),
//		.ast_sink_data    (output_sync_sym_q_out),
//		.ast_sink_valid   (output_sync_valid_out),
//		.ast_source_data  (filter_sym_q_out),
//		.ast_source_valid (filter_q_valid),
//		.ast_sink_error (0)
//	);
	
endmodule // dvbs2_transmitter
