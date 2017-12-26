module labL;
reg [31:0] a0;
reg [31:0] a1;
reg [31:0] a2;
reg [31:0] a3;
reg [1:0] c;  
wire [31:0] z;

yMux4to1 #(.SIZE(32)) my_mux(z, a0, a1, a2, a3, c);

initial 
begin
	repeat (10) 
	begin 
		a0 = $random;  
		a1 = $random;  
		a2 = $random;  
		a3 = $random;  
		c = $random % 4; 
		#1;   
		if ( (z===a0 && c===0) || (z===a1 && c===1) || (z===a2 && c===2) || (z===a3 && c===3) )
			$display("PASS: a0=%b a1=%b a2=%b a3=%b z=%b ", a0, a1, a2, a3, z);
		else
			$display("FAIL: a0=%b a1=%b a2=%b a3=%b z=%b ", a0, a1, a2, a3, z);
	
	end 


$finish;
end


endmodule
				