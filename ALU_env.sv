
class my_env extends uvm_env;
  `uvm_component_utils(my_env)
  function  new(string name = "my_env",uvm_component parent);
    super.new(name,parent);
  endfunction
  my_agent agt;
  my_scoreboard scb;
  my_coverage_collector cov;
  env_config env_cfg;
  virtual function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(env_config)::get(null,"my_env","env_cfg",env_cfg)) `uvm_fatal("NO_ENV_CFG","the getting of env_cfg is failed");
    uvm_config_db#(agt_config)::set(this,"agt*","agt_cfg",env_cfg.agt_cfg);
	 agt=my_agent::type_id::create("agt",this);
         if(env_cfg.has_coverage)
              cov=my_coverage_collector::type_id::create("cov",this);
         if(env_cfg.has_scoreboard)
              scb=my_scoreboard::type_id::create("scb",this);
  endfunction
  virtual function void connect_phase(uvm_phase phase);
     if(env_cfg.has_scoreboard) begin
        agt.dut_in_tx_port.connect(scb.dut_in_tx_export);
        agt.dut_out_tx_port.connect(scb.dut_out_tx_export);
     end
     if(env_cfg.has_coverage) begin
        agt.dut_in_tx_port.connect(cov.analysis_export);
        agt.dut_out_tx_port.connect(cov.dut_out_tx_export);
     end
  endfunction
endclass
















