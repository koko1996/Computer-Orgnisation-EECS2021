         .globl	Fraction         
		 .globl	getNumerator	
		 .globl	getDenominator
		 .globl	adding
		 .globl	setNumerator
		 .globl	setDenominator
		 .globl	multiply
		 .globl	subtract
		 .globl	divide
         .text         
Fraction:                  
         #---------------------------------------------         
         add      $t0, $0, $a0      # t0 = numerator 
         add      $t1, $0, $a1      # t1 = denominator 
         # store the attributes somewhere in memory 
         # and return a reference to where they are 
		 addi    $v0,    $0,    9    
         addi    $a0,    $0,    8    
         syscall    
		
		 sw      $t0,    0($v0)    
         sw      $t1,    4($v0)
		 
		 
		 jr         $ra

 
 getNumerator:#----------------------------------------------         
		 # retrieve the numerator of this
         # fraction and return it in $v0. 
		 lw   $v0 , 0($a0)
		 
	
		 jr		$ra
		 

 getDenominator:#---------------------------------------------         
		 # retrieve the numerator of this
         # fraction and return it in $v0. 
		 lw   $v0 , 4($a0)
		 
	
		 jr		$ra
		 
adding:#--------------------------
		 lw   	$t0 , 0($a0) #this
		 lw		$t1 , 4($a0)
		 
		 lw   	$t2 , 0($a1) # other
		 lw   	$t3 , 4($a1)		 

		 mult 	$t0, $t3
		 mflo 	$t4
		 
		 mult 	$t1, $t2
		 mflo 	$t5
		 
		 add  	$t4, $t4 , $t5
			
		 mult 	$t1, $t3
		 mflo 	$t5
		 
		 sw   	$t4 , 0($a0) #this
		 sw		$t5 , 4($a0)
		 
		
		jr $ra

setNumerator: #-------------------------
		sw		$a1, 0($a0)
		
		jr  	$ra


setDenominator: #-------------------------
		sw		$a1, 4($a0)
		
		jr  	$ra
		
		
multiply:#------------------------
		lw   	$t0, 0($a0) # this 
		lw   	$t1, 4($a0)
		
		lw   	$t2, 0($a1) #other
		lw   	$t3, 4($a1)
		
		mult 	$t0,$t2
		mflo 	$t4
		mult 	$t1,$t3
		mflo 	$t5
		
		sw		$t4, 0($a0)
		sw		$t5, 4($a0)
		
		jr 		$ra
		
		
subtract:#---------------------
  	       addi    $sp, $sp, -12 
		sw      $ra, 0($sp) 
		sw      $a0, 4($sp) 
		sw      $a1, 8($sp) 

		lw   	$a0, 0($a1) # other
		lw   	$a1, 4($a1)
		addi    $t7, $0, -1
		mult	$a0, $t7
		mflo	$a0
		jal     Fraction
		
		
		addi	$a1,$v0,0
		lw      $a0, 4($sp) 
		jal		adding
		
		
		lw      $ra, 0($sp) 
		lw      $a0, 4($sp) 
		lw      $a1, 8($sp)  
		addi    $sp, $sp, 12 

		jr 		$ra
		
divide:	addi    $sp, $sp, -12 
		sw      $ra, 0($sp) 
		sw      $a0, 4($sp) 
		sw      $a1, 8($sp) 

		lw   	$a0, 4($a1) # other
		lw   	$a1, 0($a1)
		jal     Fraction
		
		
		addi	$a1,$v0,0
		lw      $a0, 4($sp) 
		jal		multiply
		
		
		lw      $ra, 0($sp) 
		lw      $a0, 4($sp) 
		lw      $a1, 8($sp)  
		addi    $sp, $sp, 12 

		jr 		$ra
