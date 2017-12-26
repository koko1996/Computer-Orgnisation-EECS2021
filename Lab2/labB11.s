         .globl fini           
		         .text         
main:    #---------------------    
         addi     $t0, $0, -60 
         sra      $a0, $t0, 1 
         addi     $v0, $0, 1        # service #1 
		 add      $a0, $0, $a0      # printInt 
		 syscall
		 
		 addi     $v0, $0, 11        # service #11 
		 addi     $a0, $0, ' '      # print space 
         syscall
		 
         sll      $a0, $t0, 1 
		 addi     $v0, $0, 1        # service #1 
		 add      $a0, $0, $a0      # printInt 
         syscall
         #---------------------         
fini:    jr       $ra    