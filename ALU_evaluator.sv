
class my_evaluator extends uvm_component;
   `uvm_component_utils(my_evaluator)
    function  new(string name = "my_evaluator",uvm_component parent);
           super.new(name,parent);
    endfunction
    static int match;
    static int mismatch;
    uvm_analysis_export #(my_sequence_item) actual_export;
    uvm_analysis_export #(my_sequence_item) expected_export;
    uvm_tlm_analysis_fifo #(my_sequence_item) actual_fifo;
    uvm_tlm_analysis_fifo #(my_sequence_item)  expected_fifo;
    virtual function void build_phase(uvm_phase phase);
        `uvm_info("evaluator","hello from evaluator", UVM_LOW );
        actual_export = new("actual_export",this);
        expected_export = new("expected_export",this);
        actual_fifo = new("actual_fifo",this);
        expected_fifo = new("expected_fifo",this);
    endfunction
    virtual function void connect_phase(uvm_phase phase);
             actual_export.connect(actual_fifo.analysis_export);
             expected_export.connect(expected_fifo.analysis_export);
    endfunction
     virtual task run_phase(uvm_phase phase);
       
     my_sequence_item expected_tx;
     my_sequence_item actual_tx;
     forever begin
           $display("  ------------------------------------------------------------------- \n");
          $display("  time at evaluator =  %0t \n",$time);
         expected_fifo.get(expected_tx);
                                    $display("  ---------------------------------------------expected item ---------------------- \n");
                                    $display("expected item at evaluator task as string: "); 
                                    expected_tx.do_convert2string();
 
         actual_fifo.get(actual_tx);
            $display("  ---------------------------------actual item---------------------------------- \n");
                                  $display("actual item at evaluator task as string: "); 
                                   actual_tx.do_convert2string();
            $display("  ------------------------------------------------------------------- \n");
         if(actual_tx.compare(expected_tx))
                  match++;
         else begin
               mismatch++;
               `uvm_error("MisMatchERR","miss macth is done");
         end
       end //forever
    endtask
     virtual function void report_phase(uvm_phase phase);
           `uvm_info("evaluator", $sformatf(" matched = %0d,mismatched = %0d",match,mismatch), UVM_LOW );
     endfunction
endclass










