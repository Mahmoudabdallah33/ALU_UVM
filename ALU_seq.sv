class my_sequence extends uvm_sequence #(my_sequence_item);
   `uvm_object_utils(my_sequence)
     function  new(string name = "my_sequence");
       super.new(name);
       if(!this.randomize()) `uvm_fatal("NO_SEQ_RAND","the randomization of no. ofo item in sequence is failed");
    endfunction
    rand bit [15:0] block_size;
    my_sequence_item my_item;
    virtual task body();
       `uvm_info("my_sequence","hello from my_sequence", UVM_LOW );
          
      repeat(1000) begin
            
            my_item = my_sequence_item::type_id::create("my_item");
            start_item(my_item);
            if(!my_item.randomize()) `uvm_fatal("NO_ITEM","the randomization of item is failed");
           finish_item(my_item);
         end
    endtask


endclass
