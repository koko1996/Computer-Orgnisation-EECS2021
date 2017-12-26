module labL; 
reg [31:0] a, b; 
reg [31:0] expect; 
reg [2:0] op; 
wire ex; 
wire [31:0] z; 
reg ok, flag; 
yAlu mine(z, ex, a, b, op); 
initial 
begin 
  repeat  (10)  
  begin  
	ok=0;
    a  =  $random;  
    b  =  $random;  
    flag = $value$plusargs("op=%b", op); 
    // The oracle: compute "expect" based on "op" 
	#1		if (op === 3'b000) begin
                expect = a & b;
             end
             else if (op === 3'b001) begin
                expect = a | b;
             end
             else if (op === 3'b010) begin
                expect = a + b;
             end
             else if (op === 3'b110) begin
                expect = a - b;
             end

             #1;

             // Compare the circuit's output with "expect"
             // and set "ok" accordingly
			ok = (expect === z) ? 1 : 0;

              #1;  
    // Compare the circuit's output with "expect" 
    // and set "ok" accordingly 
    // Display ok and the various signals 
    		if(ok===1 )
			$display("PASS: a=%b b=%b op=%b z=%b ex=%b ", a, b, op, z, ex);
		else
			$display("FAIL: a=%b b=%b op=%b z=%b ex=%b ", a, b, op, z, ex);
		end
	$finish;  
end 
endmodule 