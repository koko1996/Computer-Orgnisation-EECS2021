module Labl;
wire [31 : 0] z;
wire cout;
reg  [31 : 0] a ,b;
reg  ctrl;
reg signed [31:0] expect; 

yArith my_arith(z, cout, a, b, ctrl); 

initial 
begin
	repeat (10) 
	begin 
		a = $random;  
		b = $random;  
		ctrl = $random%2;
		
		#1;   
		if ( (ctrl ===0 && z ===  a + b )  || ( ctrl===1 &&  z === a- b))
			$display("PASS: a=%b b=%b ctrl=%b z=%b cout=%b ", a, b, ctrl, z, cout);
		else
			$display("FAIL: a=%b b=%b ctrl=%b z=%b cout=%b ", a, b, ctrl, z, cout);
	
	end 


$finish;
end


endmodule
				