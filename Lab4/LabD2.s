         .globl	Fraction         
		 .globl	getNumerator	
		 .globl	getDenominator
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
		 # retrieve the denominator of this
         # fraction and return it in $v0. 
		 lw   $v0 , 4($a0)
		 
	
		 jr		$ra
