

class my_agent extends uvm_agent;
   `uvm_component_utils(my_agent)
   function new(string name = "my_agent",uvm_component parent);
     super.new(name,parent);
   endfunction
   my_monitor mon;
   my_driver drv;
   my_sequencer sqr;
   agt_config agt_cfg;
   uvm_analysis_port #(my_sequence_item) dut_in_tx_port;
   uvm_analysis_port #(my_sequence_item) dut_out_tx_port;
   virtual function void build_phase(uvm_phase phase);
         `uvm_info("my_agent","hello from my_agent", UVM_LOW );
        if(!uvm_config_db#(agt_config)::get(this,"","agt_cfg",agt_cfg))
               `uvm_fatal("NO_AGT_CFG","the getting of agt_cfg is failed");
        
        if(agt_cfg.active == UVM_ACTIVE) begin
                drv = my_driver::type_id::create("drv",this);
                sqr = new("sqr",this);
        end
        agt_cfg.sqr = sqr;
        mon=my_monitor::type_id::create("mon",this);
        dut_in_tx_port=new("dut_in_tx_port",this);
         dut_out_tx_port=new("dut_out_tx_port",this);
   endfunction
   virtual function void connect_phase(uvm_phase phase);
          mon.dut_in_tx_port.connect(this.dut_in_tx_port);
          mon.dut_out_tx_port.connect(this.dut_out_tx_port);
          if(agt_cfg.active == UVM_ACTIVE)
               drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction
endclass

















