module ALU(input clk,rst_n,global_enable,enable_a,enable_b,irq_clear,[1:0]op_a,[1:0]op_b,[7:0]in_a,[7:0]in_b,
                     output reg irq,reg [7:0]out);


reg [7 : 0] out_temp;
reg          irq_temp; 
always @(posedge clk or negedge rst_n) begin
   if (~ rst_n) begin 
             out <= 7'h0;
             irq <= 1'b0;
                  end
    else begin
         if (~ global_enable ) begin
                                    out <= out;
                                    irq <= irq;
                               end
          else                 begin
                                 out <= out_temp;
                                 irq <= irq_temp;
                               end

    end// else of rst_n
   

end // always @ clk




always@(*)begin

if( enable_a )begin
           case(op_a)
                 2'b00 : begin  
                                  out_temp = in_a & in_b;
                                if (out_temp == 8'hff || in_b == 8'h00)
                                      irq_temp = 1'b1;
                                else irq_temp = 1'b0;
                            
                         end
                 2'b01 : begin  
                                  out_temp = ~(in_a & in_b);
                                if (out_temp == 8'h00 || in_b == 8'h03 || in_a == 8'hff)
                                      irq_temp = 1'b1;
                                else irq_temp = 1'b0;
                            
                         end
                 2'b10 : begin  
                                  out_temp = in_a | in_b;
                                if (out_temp == 8'hf8 )
                                      irq_temp = 1'b1;
                                else irq_temp = 1'b0;
                            
                         end
                 2'b11 : begin  
                                  out_temp = in_a ^ in_b;
                                if (out_temp == 8'h83 )
                                      irq_temp = 1'b1;
                                else irq_temp = 1'b0;
                            
                        end
           endcase// case (opa)
 end//if en_a






 else if ( enable_b) begin
           case(op_b)
                 2'b00 : begin 
                             out_temp = in_a ~^ in_b;

                                if (out_temp == 8'hf1 )
                                      irq_temp = 1'b1;
                                else irq_temp = 1'b0;

                            end

                  2'b01 : begin 
                             out_temp = in_a & in_b;

                               if (out_temp == 8'hf4 || in_b == 8'h03)
                                      irq_temp = 1'b1;
                                else irq_temp = 1'b0;
                             end
                  2'b10 : begin 
                             out_temp = ~(in_a | in_b);

                               if (out_temp == 8'hf5 || in_a == 8'hf5)
                                      irq_temp = 1'b1;
                                else irq_temp = 1'b0;
                            end

                  2'b11 : begin 
                             out_temp = in_a | in_b;

                               if (out_temp == 8'hff)
                                      irq_temp = 1'b1;
                                else irq_temp = 1'b0;
                            end                           


           endcase


      end//else if en_b


end//always@*















endmodule
