module labL;
reg [0:0] a;
reg [0:0] b;
reg [0:0] cin;  
reg [1:0] expect;

wire [0:0] z;
wire [0:0] cout;

integer i, j, k;

yAdder1 my_adder(z, cout, a, b, cin);

initial 
begin
	for (i = 0; i < 2; i = i + 1)
        begin
        for (j = 0; j < 2; j = j + 1)
            begin
			for (k = 0; k < 2; k = k + 1)
				begin
		a = i; b = j;cin = k;
		expect = a + b + cin;
		#1;   
		if ( expect[1]===cout && expect[0]===z)
			$display("PASS: a=%b b=%b c=%b z=%b cout=%b ", a, b, cin, z, cout);
		else
			$display("FAIL: a=%b b=%b c=%b z=%b cout=%b ", a, b, cin, z, cout);
		
			end
		end 
	end

$finish;
end



endmodule
				