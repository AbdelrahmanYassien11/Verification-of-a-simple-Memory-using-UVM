 class coverage extends uvm_subscriber #(sequence_item);
 	`uvm_component_utils(coverage);
 	
 	//typedef uvm_subscriber #(my_first_sequence_item) this_type; //chipverify tlm_analysis_port, also to be used in the X_imp classes to be instantiated there
 			
 	//uvm_analysis_imp(my_first_sequence_item, my_first_subscriber); //giving the type of packet & the uvm_subscriber data type so he can instatntiate there
 	
 	virtual inf my_vif;

 	logic en;
 	logic rst;
	logic [3:0] addr;
 	logic [31:0] data_in;
 	logic [31:0] data_out;
 	logic valid_out;

 	covergroup addr_cov;
 		addr_df: coverpoint addr iff (!rst) {
 			bins addr_0 = {0};
 			bins addr_1 = {1};
 			bins addr_2 = {2};
 			bins addr_3 = {3};
 			bins addr_4 = {4};
 			bins addr_5 = {5};
 			bins addr_6 = {6};
 			bins addr_7 = {7};
 			bins addr_8 = {8};
 			bins addr_9 = {9};
 			bins addr_10 = {10};
 			bins addr_11 = {11};
 			bins addr_12 = {12};
 			bins addr_13 = {13};
 			bins addr_14 = {14};
 			bins addr_15 = {15};
 		}
 	endgroup : addr_cov


 	covergroup valid_out_cov;
 		valid_out_df: coverpoint valid_out iff(!rst) {
 			bins valid_out_off = {0};
 			bins valid_out_on  = {1};
 		}

 		valid_out_dt: coverpoint valid_out iff(!rst) {
 			bins valid_out_off_on = (0 => 1);
 			bins valid_out_on_off = (1 => 0);
 		}
 	endgroup : valid_out_cov


 	covergroup enable_cov;
 		en_df: coverpoint en iff(!rst) {
 			bins en_off = {0};
 			bins en_on  = {1};
 		}

 		en_dt: coverpoint en iff(!rst) {
 			bins en_off_on = (0 => 1);
 			bins en_on_off = (1 => 0);
 		}
 	endgroup : enable_cov

 	covergroup reset_cov;
 		rst_df: coverpoint rst {
 			bins rst_off = {0};
 			bins rst_on  = {1};
 		}

 		rst_dt: coverpoint rst {
 			bins rst_off_on = (0 => 1);
 			bins rst_on_off = (1 => 0);
 		}
 	endgroup : reset_cov


 	function void write (sequence_item t); //t is the packet
 		en = t.en;
 		rst = t.rst;
 		addr = t.addr;
 		valid_out = t.valid_out;

 		valid_out_cov.sample();
 		addr_cov.sample();
 		enable_cov.sample();
 		reset_cov.sample();

 		`uvm_info ("COVERAGE", {"SAMPLE: ",t.convert2string}, UVM_HIGH)

 	endfunction
 			
 	function new(string name, uvm_component parent);
 	 	super.new(name, parent);
 	 	valid_out_cov = new();
		addr_cov = new();
		enable_cov = new();
		reset_cov = new();
 	endfunction

 	function void build_phase(uvm_phase phase);
 		super.build_phase(phase);
 		$display("coverage build_phase");
 		if(!uvm_config_db#(virtual inf)::get(this,"","my_vif",my_vif)) begin //to fix the get warning of having no container to return to
			`uvm_fatal(get_full_name(),"Error");
		end
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		$display("coverage run_phase");
	endtask : run_phase
 endclass