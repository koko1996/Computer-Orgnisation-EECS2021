module labK;
reg a, b, c, flag1 ,flag2 ,flag3;
reg [1:0] expect;
wire AandB, AxorB, AxorB_xorC, AxorB_andC, z ,Cout;
integer i,j,k;

and A_and_B(AandB, a, b);
xor  A_xor_B(AxorB,a,b);
xor A_xor_B_xor_c(AxorB_xorC,AxorB,c);
and A_xor_B_and_c(AxorB_andC,AxorB,c);
assign z = AxorB_xorC;
or C_out(Cout,AandB,AxorB_andC);


initial
begin
        for (i = 0; i < 2; i = i + 1)
        begin
            for (j = 0; j < 2; j = j + 1)
            begin
				for (k = 0; k < 2; k = k + 1)
				begin
		    a = i; b = j;c = k;
			//expect1 = ((a ^ b) ^ c);
			//expect2 = ((a ^ b) & c) | (a & b);
			expect=a+b+c;
			#1; // wait for z
			if ( expect[0]===z && expect[1]===Cout )
				$display("PASS: a=%b b=%b c=%b z=%b Cout=%b", a, b, c, z ,Cout);
			else
				$display("FAIL: a=%b b=%b c=%b z=%b Cout=%b", a, b, c, z, Cout);
				end
			end
		end
    $finish;
end
endmodule