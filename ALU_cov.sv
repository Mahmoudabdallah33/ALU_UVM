
`uvm_analysis_imp_decl(_out)
class my_coverage_collector extends uvm_subscriber #(my_sequence_item);
  `uvm_component_utils(my_coverage_collector)
   my_sequence_item tx_in;
   my_sequence_item tx_out;

   covergroup cover_input;
     global_enable : coverpoint tx_in.global_enable {
                   bins hi = {1'b1}; 
                    bins lo = {1'b0}; 
                   }
     enable_a : coverpoint tx_in.enable_a {
                   bins hi = {1'b1}; 
                    bins lo = {1'b0}; 
                   }
      enable_b : coverpoint tx_in.enable_b {
                   bins hi = {1'b1}; 
                    bins lo = {1'b0}; 
                   }
     irq_clear : coverpoint tx_in.irq_clear {
                   bins hi = {1'b1}; 
                    bins lo = {1'b0}; 
                   }
      op_a : coverpoint tx_in.op_a {
                   bins AND = {2'b00}; 
                   bins NAND = {2'b01}; 
                   bins OR = {2'b10}; 
                   bins XOR = {2'b11}; 
                   }
      op_b : coverpoint tx_in.op_b {
                   bins XNOR = {2'b00}; 
                   bins AND = {2'b01}; 
                   bins NOR = {2'b10}; 
                   bins OR = {2'b11}; 
                   }
      in_a : coverpoint tx_in.in_a;
      in_b : coverpoint tx_in.in_b;
     
      GL_X_A : cross global_enable , enable_a {
                 bins GL_HI_and_en_a_hi = binsof(global_enable.hi) && binsof(enable_a.hi);
                 
                           }
      GL_X_B : cross global_enable , enable_b {
                 bins GL_HI_and_en_b_hi = binsof(global_enable.hi) && binsof(enable_b.hi);
                 
                           }
//       opa_X_inb : cross op_a, in_b{
//              illegal_bins ill_AND_in =binsof(op_a.AND) && ( binsof(in_b) intersect {8'h00} ) ;
//              illegal_bins ill_NAND_in =binsof(op_a.NAND) intersect {8'hff} && ( binsof(in_b) intersect {8'h03} );
//              
//               }

   endgroup
   covergroup cover_output;
            out : coverpoint tx_out.out {
                      bins a_AND_OUT_IRQ = {8'hff};
                      bins a_NAND_OUT_IRQ = {8'h00};
                      bins a_OR_OUT_IRQ = {8'hf8};
                      bins a_XOR_OUT_IRQ = {8'h83};
                      bins b_XNOR_OUT_IRQ = {8'hf1};
                      bins b_AND_OUT_IRQ = {8'hf4};
                      bins b_NOR_OUT_IRQ = {8'hf5};
                      bins b_OR_OUT_IRQ = {8'hff};
                      bins another_out = default;
                           }
              irq : coverpoint tx_out.iqr {
                      bins hi = {1'b1};
                      ignore_bins lo = {1'b0};
                                          }
              out_X_irq : cross out, irq  {
                           bins a_AND_irq = binsof(irq.hi) && binsof(out.a_AND_OUT_IRQ)  ;
                            bins a_NAND_irq = binsof(irq.hi) && binsof(out.a_NAND_OUT_IRQ);
                           bins a_OR_irq = binsof(irq.hi) && binsof(out.a_OR_OUT_IRQ);
                           bins a_XOR_irq = binsof(irq.hi) && binsof(out.a_XOR_OUT_IRQ);
                           bins b_XNOR_irq = binsof(irq.hi) && binsof(out.b_XNOR_OUT_IRQ);
                           bins b_AND_irq = binsof(irq.hi) && binsof(out.b_AND_OUT_IRQ);
                           bins b_NOR_irq = binsof(irq.hi) && binsof(out.b_NOR_OUT_IRQ);
                           bins b_OR_irq = binsof(irq.hi) && binsof(out.b_OR_OUT_IRQ);
                          //bins other = default;
                                    }
    endgroup



//uvm_analysis_imp #(my_sequence_item) dut_in_tx_export;
  uvm_analysis_imp_out #(my_sequence_item , my_coverage_collector ) dut_out_tx_export;



  function  new(string name = "my_coverage_collector",uvm_component parent);
          super.new(name,parent);
          dut_out_tx_export =new("dut_out_tx_export",this);
          cover_output = new();
          cover_input = new();
  endfunction
  
      
      
  


virtual function void write_out (my_sequence_item tx_item);
  tx_out = my_sequence_item::type_id::create("tx_out");
  if(! $cast(tx_out,tx_item)) `uvm_fatal("NO_CAST","the objects not compatable");
    tx_out.copy(tx_item);
   
  
  cover_output.sample();
endfunction


 virtual function void write (my_sequence_item t);
  tx_in = my_sequence_item::type_id::create("tx_in");
  if(! $cast(tx_in,t)) `uvm_fatal("NO_CAST","the objects not compatable");
    tx_in.copy(t);
   
  cover_input.sample();
  
endfunction









endclass







