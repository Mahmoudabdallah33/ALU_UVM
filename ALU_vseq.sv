
class my_virtual_sequence extends uvm_sequence ;
        `uvm_object_utils(my_virtual_sequence)
        function new(string name = "my_virtual_sequence");
                  super.new(name);
        endfunction
        my_sequence seq_1;
        virtual task body();
             seq_1 = my_sequence::type_id::create("seq_1");
                seq_1.start(get_sequencer(),this);
        endtask
endclass






















