
class monitor extends uvm_monitor;
  	`uvm_component_utils(monitor);

  	virtual inf my_vif;

  	//event scoreboard_sample;

  	uvm_analysis_port #(sequence_item) tlm_analysis_port;


  	function new (string name = "monitor", uvm_component parent);
    	super.new(name,parent);
  	endfunction
			
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(virtual inf)::get(this,"", "my_vif", my_vif)) begin
			`uvm_fatal(get_full_name(),"Error");
		end

		tlm_analysis_port = new("tlm_analysis_port", this);

		$display("my_monitor build phase");
	endfunction


	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		my_vif.command_monitor_h = this;
		$display("my_monitor connect phase");
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		//tlm_analysis_port.get_connected_to();
		//tlm_analysis_port.get_provided_to();
		$display("my_monitor end_of_elaboration_phase");
	endfunction



	function void write_to_monitor (input bit [3:0] iaddr, input bit [31:0] idata_in, input logic irst, input logic ien,
 					  input logic [31:0] idata_out, input logic ivalid_out);

		sequence_item seq_item;
		//`uvm_info ("COMMAND MONITOR", {"WRITE_ITEM: ", seq_item.convert2string()}, UVM_LOW)

		seq_item = new();

			seq_item.addr 		= iaddr;
			seq_item.data_in 	= idata_in;
			seq_item.en 		= ien;
			seq_item.rst 		= irst;
			seq_item.data_out 	= idata_out;
			seq_item.valid_out 	= ivalid_out;
			tlm_analysis_port.write(seq_item);

	endfunction : write_to_monitor

	/*
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			@(posedge my_vif.clk)
			if(my_vif.valid_out == 1'b0)begin
				seq_item.data_in <= my_vif.data_in;
				seq_item.en <= my_vif.en;
				seq_item.addr <= my_vif.addr;
				#1step tlm_analysis_port.write(seq_item);
			end
			else if(my_vif.valid_out == 1'b1)begin
				seq_item.data_out <= my_vif.data_out;
				seq_item.en <= my_vif.en;
				seq_item.addr <= my_vif.addr;
				#1step $display("monitor data = %p" ,seq_item.data_out); 
				tlm_analysis_port.write(seq_item);
			end
		end

		$display("my_monitor run phase");
	endtask
	*/
endclass