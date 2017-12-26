module labK;
reg a, b, c;
wire notOutput, lowerInput,orUpperInput,orlowerInput, tmp, z;

not my_not(notOutput, c);
and ACmy_and(z1, a, lowerInput);
assign lowerInput = notOutput;
and BCmy_and(z2, c, b);
assign orUpperInput = z1;
assign orlowerInput = z2;
or	fin_or(z,orUpperInput,orlowerInput);

initial
begin


	a = 1; b = 0; c = 0;

	#1; // wait for z
	$display("a=%1d b=%1d c=%1d z=%1d",  a, b,c, z);
        $finish;
end
endmodule