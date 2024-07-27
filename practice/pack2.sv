
 package pack2;

class packet extends uvm_object;
	`uvm_component_utils(packet);

	function void new(string name = "packet1");
		super.new(name);
	endfunction 

	function void print(string l);
		$display(l);
	endfunction

endclass


class componenetA extends uvm_component;
	`uvm_component_utils(componenetA);

	uvm_get_peak_port #(packet1) tlm_get_peak_port; 

	function void new(string name = "compA", uvm_component parent);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase);
		super.build_phase(phase);
		packet::type_id::create("packet1",this);
		tlm_get_peek_port = new(tlm_get_peek_port, this);
	endfunction

	function void run_phase();
		phase.raise_objection(this);
			tlm_get_peak_port.get(packet1);
		phase.drop_objection(this);
	endfunction

endclass


class componenetB extends uvm_component;
	`uvm_component_utils(componenetA);
	
	typedef componentB this_type;

	uvm_get_peak_imp #(packet1, this_type) tlm_get_peak_imp;
	

	function void new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction


	function void build_phase(uvm_phase);
		super.build_phase(phase);
		tlm_get_peak_imp
		packet::type_id::create("packet1",this);
	endfunction

	function void run_phase();		
		virtual task get_peak(packet1 t);
			$display(t);
		endtask
	endfunction
	
endclass

endpackage 