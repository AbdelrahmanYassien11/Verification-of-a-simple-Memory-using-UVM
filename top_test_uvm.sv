//`include "memory_interface.sv"
module top_test_uvm();
	import uvm_pkg::*;
	import a7a::*;


	bit clk;
    always begin
    	#5 clk = ~clk;
    end

	inf inf1(clk);
	
	memory_16x32 mem1(
		.clk(clk),
		.en(inf1.en),
		.rst(inf1.rst),
		.addr(inf1.addr),
		.data_in(inf1.data_in),
		.data_out(inf1.data_out),
		.valid_out(inf1.valid_out)
		);


initial begin
	//virtual inf vif; vif = inf1; the next line does this
	uvm_config_db#(virtual interface inf)::set(null,"uvm_test_top", "my_vif", inf1);
	run_test();
end 
endmodule