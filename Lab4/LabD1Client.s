				.text         
		
main:		addi    $sp, $sp, -4 
			sw      $ra, 0($sp)         

			
			addi	$a0, $0,3         
            addi 	$a1, $0, 8         
            jal     Fraction         
			add     $s0, $0, $v0    # s0 holds a 
			
			addi	$a0, $0, 1         
            addi 	$a1, $0, 2         
            jal     Fraction         
			add     $s1, $0, $v0    # s0 holds a 
			
			
			
			lw      $ra, 0($sp)         
			addi    $sp, $sp, 4
			jr      $ra
			