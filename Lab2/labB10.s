         .globl fini           
		 .text         
main:    #---------------------    
         addi     $t0, $0, 10 
         addi     $t1, $0, 7 
         div      $t0, $t1   
         mfhi     $a0
		 addi     $v0, $0, 1        # service #1 
		 add      $a0, $0, $a0      # printInt 
		 syscall
		 addi     $t3, $0, ' '
         addi     $v0, $0, 11        # service #1 
		 add      $a0, $0, $t3      # printInt 
		 syscall
		 mflo     $a0
		 addi     $v0, $0, 1        # service #1 
		 add      $a0, $0, $a0      # printInt 
		 syscall
		 
         addi     $v0, $0, 11        # service #1 
		 add      $a0, $0, $t3      # printInt 
		 syscall
		 
		 
		 mult     $t0, $t1   
         mfhi     $a0
		 addi     $v0, $0, 1        # service #1 
		 add      $a0, $0, $a0      # printInt 
		 syscall
		 
         addi     $v0, $0, 11        # service #1 
		 add      $a0, $0, $t3      # printInt 
		 syscall
		 mflo     $a0
		 addi     $v0, $0, 1        # service #1 
		 add      $a0, $0, $a0      # printInt 
		 syscall
		 
		 
		 #---------------------         
fini:    jr       $ra               #    return    		 
