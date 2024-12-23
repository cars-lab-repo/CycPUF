(* dont_touch = "yes" *)
module mux2_to_1(
    input in0,
    input in1,
    input sel,
    output reg mux
    );
       
    always@(in0, in1, sel) begin
        if(sel)
             mux = in1;
            
        else 
             mux = in0;
    end
    
endmodule
