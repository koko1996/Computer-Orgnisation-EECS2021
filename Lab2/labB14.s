         .globl fini           
		         .text         
main:    #---------------------    
		 addi     $v0, $0, 5        # v0 = readInt 
         syscall         
         addi     $t0, $v0, 0	 
		 andi     $t1, $t0 ,1024
		 addi     $t2, $0, 1024	 
		 beq      $t1,$t2, XX		 
		 addi     $v0, $0, 1        # service #1 
		 addi     $a0, $0, 0      # printInt 
		 syscall
		 j fini
		 
	XX:  addi     $v0, $0, 1        # service #1 
		 addi     $a0, $0, 1      # printInt 
		 syscall
		
		 
         #---------------------         
fini:    jr       $ra    