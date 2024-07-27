
class sequence_item extends uvm_sequence_item;
 	`uvm_object_utils(sequence_item);

 	function new(string name = "sequence_item");
 		super.new(name);
 	endfunction

    logic en;
    logic rst;

    randc logic [3:0] addr;
    rand logic [31:0] data_in;
    
    logic [31:0] data_out;
    logic valid_out;

    constraint addr_limit_c { addr<16; }
    constraint addr_value_c { addr dist {[0:15]:= 10}; }




    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
      sequence_item tested;
      bit               same;
      
      if (rhs==null) `uvm_fatal(get_type_name(), 
                                "Tried to do comparison to a null pointer");
      
      if (!$cast(tested,rhs))
        same = 0;
      else
        same = super.do_compare(rhs, comparer) && 
               (tested.addr == addr) &&
               (tested.data_in == data_in) &&
               (tested.data_out == data_out) &&
               (tested.valid_out == valid_out);
      return same;
    endfunction : do_compare




    function void do_copy(uvm_object rhs);
      sequence_item to_be_copied;

      assert(rhs != null) else
        $fatal(1,"Tried to copy null transaction");

      assert($cast(to_be_copied,rhs)) else
        $fatal(1,"Faied cast in do_copy");

      super.do_copy(rhs);	// give all the variables to the parent class, so it can be used by to_be_copied
      en = to_be_copied.en;
      rst = to_be_copied.rst;
      addr = to_be_copied.addr;
      data_in = to_be_copied.data_in;
      data_out = to_be_copied.data_out;
      valid_out = to_be_copied.valid_out;
    endfunction : do_copy




    function string convert2string();
      string            s;

      s = $sformatf(" time: %t  addr: %0d  data_in: %0d   data_out: %0d 	valid_out: %0d  rst: %0d  en:%0d",
                    $time, addr, data_in, data_out, valid_out, rst, en);
      return s;
    endfunction : convert2string





    function sequence_item clone_me();
    	sequence_item clone;
    	uvm_object tmp;

    	tmp = this.clone;
    	$cast(clone, tmp);
    	return clone;
    endfunction : clone_me



 endclass