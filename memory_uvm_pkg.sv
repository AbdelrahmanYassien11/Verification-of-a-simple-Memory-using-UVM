package a7a;

	import uvm_pkg::*;
	`include "uvm_macros.svh"


	`include "sequence_item.svh"
	`include "sequencer.svh"

	`include "base_sequence.svh"

	`include "reset_sequence.svh"
	`include "write_sequence.svh"
	`include "read_sequence.svh"
	
	`include "write_once_sequence.svh"
	`include "read_once_sequence.svh"
	`include "reset_write_read_sequence.svh"
	`include "reset_16_write_read_sequence.svh"

	`include "driver.svh"
	`include "command_monitor.svh"

	`include "agent.svh"
	`include "scoreboard.svh"
	`include "coverage.svh"

	`include "env.svh"

	`include "base_test.svh"
	`include "reset_test.svh"
	`include "reset_write_read_test.svh"
	`include "reset_16_write_read_test.svh"

	`include "read_test.svh"


endpackage : a7a