interface inf (
    input logic clk
    );

import memory_pkg::*;
    
 logic en;
 logic rst;
 logic [3:0] addr;
 logic [31:0] data_in;
 logic [31:0] data_out;
 logic valid_out;




	task generic_reciever(input bit [3:0] iaddr, input bit [31:0] idata_in, input logic irst, input logic ien,
 					  		output logic [31:0] idata_out, output logic ivalid_out);
			if(irst === 1'b1) begin
				reset_memory();
			end
			else if(ien === 1'b1) begin
				write_memory(iaddr, idata_in, ivalid_out);
			end
			else if(ien === 1'b0) begin
				read_memory(iaddr, idata_out, ivalid_out);
			end
	endtask : generic_reciever


	task reset_memory();
 		rst = 1'b1;
 		@(negedge clk);
 		//-> command_monitor_h.scoreboard_sample;
 		@(negedge clk);
 		send_results();
 		rst = 1'b0;
 	endtask : reset_memory



 	task write_memory(input bit [3:0] iaddr, input bit [31:0] idata_in, output logic ivalid_out);
 		@(negedge clk);
 			en = 1'b1;
 			addr = iaddr;
 			data_in = idata_in;
 		@(negedge clk);
 			send_results();
 			ivalid_out = valid_out;
	 endtask : write_memory


 	task read_memory(input bit [3:0] iaddr, output logic [31:0] idata_out, output logic ivalid_out);
 		@(negedge clk);
  			en = 1'b0;
 			addr = iaddr;
 		@(negedge clk);
 			send_results();
 			idata_out = data_out;
 			ivalid_out = valid_out;
 	endtask : read_memory

   monitor command_monitor_h;

   /*always @(posedge clk) begin : read_write_monitor
   		wait(command_monitor_h.scoreboard_sample.triggered);
   			//#1ns;
   			$display("SCOREBOARD_clk_TIMEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE: %t",$time());
   			command_monitor_h.write_to_monitor(addr, data_in, rst, en, data_out, valid_out);
   end : read_write_monitor
*/

   function void send_results();
   		command_monitor_h.write_to_monitor(addr, data_in, rst, en, data_out, valid_out);
   endfunction : send_results

   /*********************************************************************ASYNCH RESET ***************************************************************/

/*   always @(posedge rst) begin : rst_monitor
      if (command_monitor_h != null) //guard against VCS time 0 negedge
      	#1ns;
      	$display("SCOREBOARD_rst_TIMEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE: %t",$time());
        command_monitor_h.write_to_monitor(addr, data_in, rst, en, data_out, valid_out);
   end : rst_monitor
*/  
  /***********************************************************************************************************************************************/

endinterface : inf


/*

 task write_read_memory(input bit [4:0] addr, input bit [31:0], output logic [31:0], output logic valid_out);
 	static int write_counter;
 	static int read_counter;
 	@(negedge clk);

 	if(rst === 1'b0) begin
 		em === 1'b1;
 		addr = iaddr;
 		data_in = idata_in;
 		ivalid_out = valid_out;
 		write_counter ++;
 	end
 	else if (en === 1'b0 && rst === 1'b0) begin
 		addr = iaddr;
 		idata_out = data_out;
 		ivalid_out = valid_out;
 		read_counter ++;
 	end
 	else
 		ivalid_out = valid_out;
 endtask : write_read_memory

*/