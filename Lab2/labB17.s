         .globl fini           
		         .text         
main:    #---------------------    
		 addi     $v0, $0, 5        # v0 = readInt 
         syscall         
         addi     $t0, $v0, 0	
		 
		 
		 lui     $t6, 0xffff
		 ori     $t6, $t6 , 0xfbff

		 
		 and      $t5, $t0, $t6
		 addi     $v0, $0, 1        # service #1 
		 add      $a0, $0, $t5      # printInt 
		 syscall
		 
		 
         #---------------------         
fini:    jr       $ra    