         .globl fini         
         .text         
main:    #---------------------    
		 addi     $s0, $0, 0
         add      $t0, $0, $0 
         addi     $v0, $0, 5        # v0 = readInt 
         syscall         
         add      $t0, $t0, $v0		 
		 addi     $t5, $0 , 0
		 
loop:    slt      $t9, $t5, $t0 
         beq      $t9, $0, xx
		 add      $s0,$s0,$t5
		 addi	  $t5,$t5,1	 
		 j         loop         
		 
xx:      addi     $v0, $0, 1        # service #1 
		 add      $a0, $0, $s0      # printInt 
		 syscall
       
		 #---------------------         
fini:    jr       $ra               #    return    		 
