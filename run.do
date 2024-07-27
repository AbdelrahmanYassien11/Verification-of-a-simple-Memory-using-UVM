if [file exists "work"] {vdel -all}
vlib work
vlog -f dut.f
vlog -f tb.f
vopt top_test_uvm -o top_optimized +acc +cover=sbfec+memory_16x32(rtl).
vsim top_optimized -coverage +UVM_TESTNAME=reset_16_write_read_test
run 30
#+UVM_CONFIG_DB_TRACE=inf1
