

class my_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(my_scoreboard)
          function  new(string name = "my_scoreboard",uvm_component parent);
                super.new(name,parent);
          endfunction
          my_predictor predictor;
          my_evaluator evaluator;
          uvm_analysis_export #(my_sequence_item) dut_in_tx_export;
          uvm_analysis_export #(my_sequence_item) dut_out_tx_export;
	  virtual function void build_phase(uvm_phase phase);
		predictor=my_predictor::type_id::create("predictor",this);
		evaluator=my_evaluator::type_id::create("evaluator",this);
		dut_in_tx_export=new("dut_in_tx_export",this);
		dut_out_tx_export=new("dut_out_tx_export",this);	
	  endfunction
	  virtual function void connect_phase(uvm_phase phase);
		dut_in_tx_export.connect(predictor.analysis_export);
		dut_out_tx_export.connect(evaluator.actual_export);
                predictor.expected_port.connect(evaluator.expected_export);
          endfunction
endclass
















