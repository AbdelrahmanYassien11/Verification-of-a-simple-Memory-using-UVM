class agent extends uvm_agent;
 	`uvm_component_utils(agent);
 	sequencer sequencer_h;
  	driver driver_h;
  	monitor monitor_h;

  	uvm_analysis_port #(sequence_item) tlm_analysis_port;

  	virtual inf my_vif;

  	function new (string name = "agent", uvm_component parent);
   		super.new(name, parent);
  	endfunction


  	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		sequencer_h = sequencer::type_id::create("sequencer_h",this);
		driver_h = driver::type_id::create("driver_h",this);
		monitor_h = monitor::type_id::create("monitor_h", this);

		if(!uvm_config_db#(virtual inf)::get(this,"","my_vif",my_vif)) begin //to fix the get warning of having no container to return to
			`uvm_fatal(get_full_name(),"Error");
		end

		uvm_config_db#(virtual inf)::set(this,"driver_h", "my_vif", my_vif);
		uvm_config_db#(virtual inf)::set(this,"monitor_h", "my_vif", my_vif);

 		tlm_analysis_port = new("tlm_analysis_port", this);

		$display("my_agent build phase");
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		monitor_h.tlm_analysis_port.connect(tlm_analysis_port);
		driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
		$display("my_agent connect phase");
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		//tlm_analysis_port.get_connected_to(list);
		//tlm_analysis_port.get_provided_to(list);
		$display("my_monitor end_of_elaboration_phase");
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		$display("my_agent run phase");
	endtask


 endclass