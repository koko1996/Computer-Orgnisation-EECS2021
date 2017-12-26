module labL;
reg signed[31:0] a;
reg signed [31:0] b;
reg cin;
wire  cout;  
wire signed [31:0] z;
reg signed [31:0] expect; 
reg ok; 

yAdder my_adder(z, cout, a, b, cin); 
initial 
begin
	repeat (10) 
	begin 
		a = $random;  
		b = $random;  
		cin = 0;
		expect = a + b + cin;
		#1;   
		if ( z === expect )
			$display("PASS: a=%b b=%b cin=%b z=%b cout=%b ", a, b, cin, z, cout);
		else
			$display("FAIL: a=%b b=%b cin=%b z=%b cout=%b ", a, b, cin, z, cout);
	
	end 


$finish;
end


endmodule
				