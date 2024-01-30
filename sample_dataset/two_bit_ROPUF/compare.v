module compare(
    input [1:0] clk,
    input reset,
    input [3:0] count0,
    input [3:0] count1,
    output reg comp
    );

    always@(posedge clk, posedge reset) begin
        if(reset)
            comp <= 1'b0;
            
        else begin
            if(count0 > count1)
                comp <= 1'b1;
                
            else
                comp <= 1'b0;
        end
    end

endmodule
