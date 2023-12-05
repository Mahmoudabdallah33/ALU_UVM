
class my_test extends uvm_test;
  `uvm_component_utils(my_test)
   function  new(string name,uvm_component parent = null);
         super.new(name,parent);
   endfunction
   env_config env_cfg;
   agt_config agt_cfg;
   my_env env;
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env=my_env::type_id::create("env",this);
      env_cfg = env_config::type_id::create("env_cfg");
      agt_cfg = agt_config::type_id::create("agt_cfg");
      env_cfg.has_coverage=1;
      env_cfg.has_scoreboard=1;
     if(!uvm_config_db#(virtual my_interface)::get(null,"my_test","vif",agt_cfg.vif))  `uvm_fatal("NO_IF","there is no interface");
       agt_cfg.active = UVM_ACTIVE;
       env_cfg.agt_cfg = this.agt_cfg;
     uvm_config_db#(env_config)::set(null,"my_env","env_cfg",env_cfg);
   endfunction
   virtual task run_phase(uvm_phase phase);
     my_virtual_sequence vseq = my_virtual_sequence::type_id::create("vseq");
     phase.raise_objection(this);
     vseq.start(agt_cfg.sqr);
     phase.drop_objection(this); 
     phase.phase_done.set_drain_time(this,100);
    endtask
endclass 
