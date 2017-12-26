module labL;
reg [31:0] a;
reg [31:0] b;
reg c;
wire [31:0] z;
integer i,j,k;

yMux #(.SIZE(32)) my_mux(z,a,b,c);

initial 
begin
	repeat (500) 
	begin 
		a = $random;  
		b = $random;  
		c = $random % 2; 
		#1;   
		if ( (z===a && c===0) || (z===b && c===1) )begin
			//$display("PASS: a=%b b=%b c=%b z=%b ", a, b, c, z);
			end
		else
			$display("FAIL: a=%b b=%b c=%b z=%b ", a, b, c, z);
	
	end 


$finish;
end


endmodule
				