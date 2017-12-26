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
		

#-------PRINTING s0   WHICH IS (3/8)		
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
			

#-------PRINTING s1   WHICH IS (1/2)		

			addi    $a0, $s1, 0
			jal 	getNumerator
			addi	$t0, $v0, 0         
			
			addi    $a0, $s1, 0
			jal 	getDenominator
			addi	$t1, $v0, 0
			
			addi	$a0, $t0, 0
			addi	$a1, $t1, 0
			jal 	printFraction
			jal 	println

# ADDING S0 AND S1 	14/16
			addi    $a0, $s0,0
			addi    $a1, $s1,0
			jal 	adding

# PRINTING S0  AFTER ADDING  S1 TO IT
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

			
# mutating setNumerator
			addi    $a0,$s0,0
			addi 	$a1,$0, 1
			jal		setNumerator
			
			
# mutating setDenominator
			addi    $a0,$s0,0
			addi 	$a1,$0, 2
			jal		setDenominator

#-------PRINTING s0   WHICH IS (1/2)		
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
			
# THE END PART 			
			lw      $ra, 0($sp)         
			addi    $sp, $sp, 4
			jr      $ra
			