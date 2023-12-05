
class my_driver extends uvm_driver #(my_sequence_item);
  `uvm_component_utils(my_driver)
  function  new(string name = "my_driver",uvm_component parent);
           super.new(name,parent);
   endfunction

   
 // uvm_seq_item_pull_port #(my_sequence_item) seq_item_port;
  virtual my_interface vif;
  agt_config agt_cfg;
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      // seq_item_port = new("seq_item_port",this);
    if(! uvm_config_db#(agt_config)::get(this,"","agt_cfg",agt_cfg))
                      `uvm_fatal("NOVIF","failing to get agt_cfg");
        vif = agt_cfg.vif;
   endfunction
   virtual task run_phase(uvm_phase phase);
        `uvm_info("my_driver","hello from my_driver", UVM_LOW );
       forever begin
          my_sequence_item my_item;
          seq_item_port.get_next_item(my_item);           
          vif.transfer(my_item);
          seq_item_port.item_done();
       end
    endtask



endclass
















