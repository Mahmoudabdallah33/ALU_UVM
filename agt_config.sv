

class agt_config extends uvm_object;
  `uvm_object_utils(agt_config)
   function new(string name = "agt_config");
      super.new(name);
   endfunction
   uvm_active_passive_enum active = UVM_ACTIVE;
   virtual my_interface vif;
   uvm_sequencer #(my_sequence_item) sqr;
endclass























