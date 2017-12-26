module labK;
reg a, b, c, flag1 ,flag2 ,flag3,expect;
wire notOutput, lowerInput,orUpperInput,orlowerInput, z;

not my_not(notOutput, c);
and ACmy_and(z1, a, lowerInput);
assign lowerInput = notOutput;
and BCmy_and(z2, c, b);
assign orUpperInput = z1;
assign orlowerInput = z2;
or	fin_or(z,orUpperInput,orlowerInput);

initial
begin
	flag1 = $value$plusargs("a=%b", a);
	flag2 = $value$plusargs("b=%b", b);
	flag3 = $value$plusargs("c=%b", c);
	if( flag1===0 || flag2===0 || flag3===0 )
		$display("Forgot to enter");
	else
	begin 	
//		expect = (a &~b) | (b & c);
		#1; // wait for z
		if ( (c === 0 && a===z) ||  (c === 1 && b===z)  )
			$display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z);
		else
			$display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z);
	end
    $finish;
end
endmodule