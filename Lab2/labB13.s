         .globl fini           
		         .text         
main:    #---------------------    
		 addi     $v0, $0, 5        # v0 = readInt 
         syscall         
         addi     $t0, $v0, 0	 
         sll      $t0, $t0, 21
		 srl      $t0, $t0, 31
         addi     $v0, $0, 1        # service #1 
		 add      $a0, $0, $t0      # printInt 
		 syscall
		 
         #---------------------         
fini:    jr       $ra    