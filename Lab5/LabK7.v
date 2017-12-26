module labK;
reg a, b, c, flag1 ,flag2 ,flag3;
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
		#1 $display("a=%1d b=%1d c=%1d z=%1d",  a, b,c, z);
    $finish;
end
endmodule