

class my_sequence_item extends uvm_sequence_item;
    `uvm_object_utils (my_sequence_item)
    function  new(string name = "my_sequence_item");
       super.new(name);
    endfunction

    rand bit rst_n;
    rand bit global_enable;
    rand bit enable_a;
    rand bit enable_b;
    rand bit irq_clear;
    randc bit [1:0] op_a;
    randc bit [1:0] op_b;
    rand bit [7:0] in_a;
    rand bit [7:0] in_b;
    bit [7:0] out;
    bit iqr;


    constraint one {enable_a != enable_b;}
    constraint rst_1 {rst_n == 1'b1;}
    
    constraint input_a {in_a dist {8'hff := 20 , 8'h00 := 20 , 8'hf4 := 20 , 8'h0a := 20 , [1:9] :/ 20 , [11 : 243] :/ 20 , [245 : 255] :/ 20 };} 
    constraint input_b {in_b dist {8'hf4 := 20 , 8'hff := 20 , 8'hf8 := 20 , 8'h83 := 20 , 8'hf1 := 20 , 8'h0a := 20 , 8'h00 := 20 , [1:9] :/ 20 , [11 : 130] :/ 20 , [132: 241] :/ 20 , [243 : 247] :/ 20  , [249 : 255] :/ 20};}
    constraint opcode_a {op_a  dist { 0 := 50 , [1:3] :/ 50  };  }
    constraint opcode_b {op_b  dist { 0 := 50 , [1:3] :/ 50  };  }  
    constraint AND_A {
                          if((enable_a == 1)&& (op_a == 2'b00))
                                    in_b != 8'b00000000 ;             
                     }
 //-------------------------------------------------------------------------------
    constraint NAND_A_1 {
                          if((enable_a == 1)&& (op_a == 2'b01)) 
                                    in_b != 8'h03; 
                        }
//----------------------------------------------------------------------------------
    constraint NAND_A_2 {
                          if((enable_a == 1)&& (op_a == 2'b01))                                     
                                    in_a !=  8'hff ;           
                        }
//---------------------------------------------------------------------------------
     constraint AND_B {
                          if((enable_b == 1)&& (op_b == 2'b01))
                                    in_b != 8'h03 ;             
                      }
//-----------------------------------------------------------------------------------

     constraint NOR_B {
                          if((enable_b == 1)&& (op_b == 2'b10))
                                    in_a != 8'hf5 ;             
                      }


    virtual function void do_copy(uvm_object rhs);
      my_sequence_item item_rhs;
      if(!$cast(item_rhs, rhs) )begin `uvm_fatal("NOTCAST","the source type is not comptable with dest. type"); end
        //super.do_copy(rhs);
        rst_n        = item_rhs.rst_n;
       global_enable =  item_rhs. global_enable;
        enable_a     =  item_rhs.enable_a;
        enable_b      =  item_rhs.enable_b;
        irq_clear    =  item_rhs.irq_clear;
        op_a         =  item_rhs.op_a;
        op_b         =  item_rhs.op_b;
        in_a         =  item_rhs.in_a;         
        in_b         =  item_rhs.in_b;
        out          =  item_rhs.out;
        iqr          =  item_rhs.iqr;
     endfunction //do_copy
     virtual function bit do_compare(uvm_object rhs,uvm_comparer comparer);
      my_sequence_item item_rhs;
      if(!$cast(item_rhs, rhs)) `uvm_fatal("NOTCAST","the source type is not comptable with dest. type");
        //super.do_copy(rhs);
      return (  // (super.do_compare(rhs,comparer)) &&
                (global_enable  ===  item_rhs. global_enable) &&
                (enable_a   ===  item_rhs.enable_a)   &&
               (enable_b     ===  item_rhs.enable_b)   &&
               (irq_clear   ===  item_rhs.irq_clear)  &&
               (op_a        ===  item_rhs.op_a)       &&
               ( op_b       ===  item_rhs.op_b)       &&
               (in_a        ===  item_rhs.in_a)       &&         
              (in_b         ===  item_rhs.in_b)       &&
              (out          ===  item_rhs.out)        &&
               (iqr         ===  item_rhs.iqr)       &&
                (rst_n === item_rhs.rst_n )    );
     endfunction //do_compare
      virtual function void do_convert2string();
   
    
    
    $display( " rst_n     : %0d  \n",  rst_n);
    $display( " global_enable     : %0d  \n",  global_enable);
    $display(" enable_a     : %0d  \n", enable_a);
     $display( " enable_b     : %0d  \n",  enable_b);
     $display( " op_a     : %0d  \n",  op_a);
     $display( " op_b     : %0d  \n",  op_b);
     $display( " in_a     : %0d  \n",  in_a);
     $display( " in_b     : %0d  \n",  in_b);
    $display( " out       : %0d \n",  out);
    $display(" iqr      : %0d  \n",  iqr);

    
  endfunction: do_convert2string

endclass

