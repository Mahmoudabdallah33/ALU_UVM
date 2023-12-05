
class my_predictor extends uvm_subscriber #(my_sequence_item);
   `uvm_component_utils(my_predictor)
   function  new(string name = "my_predictor",uvm_component parent);
     super.new(name,parent);
   endfunction
   // han a built in analysis export
 string s; 
   uvm_analysis_port #(my_sequence_item) expected_port;
   static logic [7:0] reg_out;
   static logic reg_irq;
   virtual function void build_phase(uvm_phase phase);
         expected_port = new("expected_port",this);
   endfunction
 virtual  function  void write (my_sequence_item t);
             my_sequence_item expected_item;
             if(!$cast(expected_item,t)) `uvm_fatal("WRONG_OBJECT","the object type is not compatible ");
                    expected_item.copy(t);
       if (~expected_item.rst_n) begin
                           expected_item.out = 8'h00;
                           expected_item.iqr = 1'b0; 
                               end
        else begin 
                  if(expected_item.global_enable) begin
                          if(expected_item.enable_a)begin
                        case(expected_item.op_a)
                         2'b00 : begin
                                       if(expected_item.irq_clear == 1'b1 ) expected_item.iqr = 1'b0;
                                      expected_item.out = expected_item.in_a & expected_item.in_b;
                                       if(expected_item.out == 8'hff) expected_item.iqr = 1'b1;
                                       else      expected_item.iqr = 1'b0;
                                       
                                   end//and
                         2'b01 : begin
					if(expected_item.irq_clear == 1'b1 ) expected_item.iqr = 1'b0;
                                      expected_item.out = ~(expected_item.in_a & expected_item.in_b);
                                       if(expected_item.out == 8'h00  || expected_item.in_b == 8'h03 || expected_item.in_a == 8'hff) expected_item.iqr = 1'b1;
                                       else      expected_item.iqr = 1'b0;
                                   end//and
                         2'b10 : begin
					if(expected_item.irq_clear == 1'b1 ) expected_item.iqr = 1'b0;
                                      expected_item.out = expected_item.in_a | expected_item.in_b;
                                       if(expected_item.out == 8'hf8) expected_item.iqr = 1'b1;
                                       else      expected_item.iqr = 1'b0;
                                   end//and
                         2'b11 : begin
					if(expected_item.irq_clear == 1'b1 ) expected_item.iqr = 1'b0;
                                      expected_item.out = expected_item.in_a ^ expected_item.in_b;
                                       if(expected_item.out == 8'h83) expected_item.iqr = 1'b1;
                                       else      expected_item.iqr = 1'b0;
                                   end//and
                        endcase //op_a

                end //enable_a
                            if(expected_item.enable_b)begin
                        case(expected_item.op_b)
                         2'b00 : begin
					if(expected_item.irq_clear == 1'b1 ) expected_item.iqr = 1'b0;
                                      expected_item.out = expected_item.in_a ~^ expected_item.in_b;
                                       if(expected_item.out == 8'hf1) expected_item.iqr = 1'b1;
                                       else      expected_item.iqr = 1'b0;
                                   end//
                         2'b01 : begin
					if(expected_item.irq_clear == 1'b1 ) expected_item.iqr = 1'b0;
                                      expected_item.out = expected_item.in_a & expected_item.in_b;
                                       if(expected_item.out == 8'hf4 || expected_item.in_b == 8'h03 ) expected_item.iqr = 1'b1;
                                       else      expected_item.iqr = 1'b0;
                                   end//
                         2'b10 : begin
					if(expected_item.irq_clear == 1'b1 ) expected_item.iqr = 1'b0;
                                      expected_item.out = ~( expected_item.in_a | expected_item.in_b);
                                       if(expected_item.out == 8'hf5) expected_item.iqr = 1'b1;
                                       else      expected_item.iqr = 1'b0;
                                   end//
                         2'b11 : begin
					if(expected_item.irq_clear == 1'b1 ) expected_item.iqr = 1'b0;
                                      expected_item.out = expected_item.in_a | expected_item.in_b;
                                       if(expected_item.out == 8'hff) expected_item.iqr = 1'b1;
                                       else      expected_item.iqr = 1'b0;
                                   end//
                        endcase //op_b

                end //enable_b
            
        end //global_enable
        else begin
           expected_item.out = reg_out;
           expected_item.iqr = reg_irq;

          end // else global
     end // else rst_n
          $display("  *********************************************************** \n");
        $display(" at predictor expected item as string: ");        
        expected_item.do_convert2string();
$display("  *********************************************************** \n");
        expected_port.write(expected_item);
        
   endfunction   




endclass










