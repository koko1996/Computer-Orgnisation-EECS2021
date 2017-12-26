         .globl fini           
		         .text         
main:    #---------------------    
		 addi     $v0, $0, 5        # v0 = readInt 
         syscall         
         addi     $t0, $v0,0	 
         sll      $t1, $t0, 4
		 sll      $t2, $t0, 1
         add      $t2, $t2,$t1
		 addi     $v0, $0, 1        # service #1 
		 add      $a0, $0, $t2      # printInt 
		 syscall
		 
         #---------------------         
fini:    jr       $ra    