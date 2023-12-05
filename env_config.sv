
class env_config extends uvm_object;
  `uvm_object_utils(env_config)
   function new(string name = "env_config");
      super.new(name);
   endfunction
   bit has_coverage ;
   bit has_scoreboard;
   agt_config agt_cfg;
endclass




