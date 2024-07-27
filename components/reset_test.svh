class reset_test extends base_test;
 	`uvm_component_utils(reset_test);
 	
 	virtual inf my_vif;

 	reset_sequence reset_sequence_h;

 

	function new(string name = "reset_test", uvm_component parent);
 	 	super.new(name, parent);
 	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		reset_sequence_h = reset_sequence::type_id::create("reset_sequence_h");

		if(!uvm_config_db#(virtual inf)::get(this,"","my_vif",my_vif)) begin //to fix the get warning of having no container to return to
			`uvm_fatal(get_full_name(),"Error");
		end

		uvm_config_db#(virtual inf)::set(this,"env_h", "my_vif", my_vif);

		$display("my_test build phase");
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		$display("my_test connect phase");
	endfunction

	task run_phase(uvm_phase phase);

		super.run_phase(phase);
		phase.raise_objection(this);
		reset_sequence_h.start(sequencer_h);
		phase.drop_objection(this);
		$display("my_test run phase");

	endtask

 endclass