if [file exists "work"] {vdel -all}
vlib work
vlog -f dut.f
vlog -f tb.f
vopt top_test_uvm -o top_optimized +acc +cover=sbfec+memory_16x32(rtl).
vsim top_optimized -coverage +UVM_TESTNAME=reset_16_write_read_test
coverage save memory_tb.ucdb -onexit
run -all
quit -sim
vcover report -file memory_coverage_report.txt memory_tb.ucdb -zeros -details -annotate -all
#+UVM_CONFIG_DB_TRACE=inf1
