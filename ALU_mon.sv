
class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)
     function  new(string name = "my_monitor", uvm_component parent);
         super.new(name,parent);
      endfunction
      virtual my_interface vif;
      agt_config agt_cfg;
      uvm_analysis_port #(my_sequence_item) dut_in_tx_port;
      uvm_analysis_port #(my_sequence_item) dut_out_tx_port;
      my_sequence_item tx_n;
      virtual function void build_phase(uvm_phase phase);
             
              dut_in_tx_port=new("dut_in_tx_port",this);
              dut_out_tx_port=new("dut_out_tx_port",this);
              if(!uvm_config_db#(agt_config)::get(this,"","agt_cfg",agt_cfg))
                   `uvm_fatal("NO_AGT_CFG","failing to get agt_cfg");
                vif = agt_cfg.vif;
      endfunction
      virtual task  run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("my_monitor","hello from my_monitor", UVM_LOW );
           tx_n  =  my_sequence_item::type_id::create("tx_n");
           fork
              get_input(tx_n);
              get_output(tx_n);
           join

       endtask
       virtual task get_input(my_sequence_item tx_n);
           
         forever begin 
                  
                    `uvm_info("my_monitor","Get an input", UVM_LOW );
                  vif.get_an_input(tx_n);                   
                    dut_in_tx_port.write(tx_n);
//                             $display("monitored item at input task as string: ");
//                    tx_n.do_convert2string();
             end
       endtask
       virtual task get_output(my_sequence_item tx_n);           
         forever begin 
                 
                    `uvm_info("my_monitor","Get an output", UVM_LOW );
                  vif.get_an_output(tx_n);
                  dut_out_tx_port.write(tx_n);
                 end
       endtask
endclass














