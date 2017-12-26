         .globl fini           
		         .text         
main:    #---------------------    
		 addi     $v0, $0, 5        # v0 = readInt 
         syscall         
         addi     $t0, $v0, 0	

		 sll     $t1, $t0 ,21		 
		 srl     $t1, $t1 , 31
		 
		 beq      $t1, $0, XX		 
		 addi     $t2, $0, 1024
		 addi     $t4, $0, -1

		 
		 xor      $t2, $t2, $t4
		 and      $t3, $t0, $t2
		 j YY
		 
	XX:  ori 	  $t3, $t0, 1024
		
		 
	YY:	 addi     $v0, $0, 1       # service #1 
		 add      $a0, $0, $t3      # printInt 
		 syscall
		 
		 
         #---------------------         
fini:    jr       $ra    