module counters(
    input clk0,
    input clk1,
    input reset,
    output reg [3:0] count0,
    output reg [3:0] count1
    );
    
    always@(posedge clk0, posedge reset) begin
        if(reset || (&count0))
			count0 <= 4'b0000;

		else
            count0 <= count0 + 1'b1;
    end

    always@(posedge clk1, posedge reset) begin
		if(reset || (&count1))
			count1 <= 4'b0000;	

		else
			count1 <= count1 + 1'b1;
    end

endmodule
