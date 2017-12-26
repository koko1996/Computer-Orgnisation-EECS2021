				.text         
		
main:		addi    $sp, $sp, -4 
		sw      $ra, 0($sp)         

			
		addi	$a0, $0,3         
            	addi 	$a1, $0, 8         
          	jal     Fraction         
		add     $s0, $0, $v0    # s0 holds array 
			
		addi	$a0, $0, 1         
	        addi 	$a1, $0, 2         
	        jal     Fraction         
		add     $s1, $0, $v0    # s0 holds a 
			
		addi    $a0, $s0, 0
		jal 	getNumerator
		addi	$t0, $v0, 0         
			
		addi    $a0, $s0, 0
		jal 	getDenominator
		addi	$t1, $v0, 0
			
		addi	$a0, $t0, 0
		addi	$a1, $t1, 0
		jal 	printFraction
			
			
		jal 	println
		
		addi    $a0, $s1, 0
		jal 	getNumerator
		addi	$t0, $v0, 0         
			
		addi    $a0, $s1, 0
		jal 	getDenominator
		addi	$t1, $v0, 0
			
		addi	$a0, $t0, 0
		addi	$a1, $t1, 0
		jal 	printFraction
			
		
		lw      $ra, 0($sp)         
		addi    $sp, $sp, 4
		jr      $ra
			
