         .globl fini           
		         .text         
main:    #---------------------    
		 addi     $v0, $0, 5        # v0 = readInt 
         syscall         
         addi     $t0, $v0, 0	 
		 ori     $t1, $0, 0xffff 
		 sll      $t1, $t1, 16
		 ori      $t1, $t1,0xfbff
		 and      $t5, $t0, $t1
		 addi     $v0, $0, 1        # service #1 
		 add      $a0, $0, $t5      # printInt 
		 syscall
		 
		 
         #---------------------         
fini:    jr       $ra    