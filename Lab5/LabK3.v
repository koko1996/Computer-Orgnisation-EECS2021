module labK;
reg a, b;  // reg without size means 1-bit
wire notOutput, lowerInput, tmp, z;

not my_not(notOutput, b);
assign lowerInput = notOutput;
and my_and(z, a, lowerInput);

initial
begin
	a = 1;
	b = 1;
	#1 $display("a=%b b=%b z=%b", a, b, z);
	$finish;
end


endmodule